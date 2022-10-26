packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}
build {
  sources = ["source.amazon-ebs.linux"]

  provisioner "shell" {
    scripts = [
      "./setup.sh",
    ]
  }

}