variable "do_token" {}
variable "public_key" {}

provider "digitalocean" {
  token = "${var.do_token}"
}

data "digitalocean_image" "docker" {
  name = "its-cloud-7.6"
}

resource "digitalocean_ssh_key" "default" {
  name       = "TF Key"
  public_key = "${var.public_key}"
}

resource "digitalocean_droplet" "node" {
  count    = 1
  image    = "${data.digitalocean_image.docker.image}"
  name     = "tf-node"
  region   = "sfo2"
  size     = "s-1vcpu-1gb"
  ssh_keys = ["${digitalocean_ssh_key.default.id}"]
} 