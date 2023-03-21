locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

source "amazon-ebs" "vm1" {
  ami_name      = "${var.ami_name}-${local.timestamp}"
  instance_type = "${var.instance_type}"
  profile       = "packer"
  region        = "${var.region}"
  source_ami    = "${var.source_ami}"
  ssh_username  = "${var.ssh_username}"
}

build {
  sources = ["source.amazon-ebs.vm1"]

  provisioner "shell" {
    script = "./packages.sh"
  }

  provisioner "file" {
    destination = "/tmp/index.html"
    source      = "./index.html"
  }

  provisioner "shell" {
    inline = ["sudo mv /tmp/index.html /var/www/html/index.html", "sleep 10", "sudo systemctl restart nginx"]
  }

  post-processor "manifest" {
    output = "output.json"
  }
}
