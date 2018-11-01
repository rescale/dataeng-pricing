variable "ssh_key_name" {
  default = "<KEY NAME OF YOUR CHOICE ON AWS>"
}

variable "public_key_content" {
  default = "ssh-rsa <YOUR KEY MATERIAL>"
}

variable "profile" {
  default = "<.aws/credentials PROFILE NAME>"
}

variable "myip" {
  default = "<LOCAL PUBLIC IP FOR ACCESS TO BASTION>"
}

variable "rescale_account_for_public_ami" {
  default = "604329154527"
}

variable "region" {
  default = "us-west-2"
}

variable "az1" {
  default = "us-west-2a"
}

variable "az2" {
  default = "us-west-2b"
}
