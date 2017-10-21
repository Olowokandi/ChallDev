variable "region_zone" {
  default = "us-central1-f"
}

variable "public_key_path" {
  description = "Path to file containing public key"
  default = "/home/gbolahan/.ssh/id_rsa.pub"
}