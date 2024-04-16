provider "local" {}

variable "create_file" {
  default = true
}

resource "local_file" "example" {
  count     = var.create_file ? 1 : 0
  content   = "Hello World!"
  filename  = "${path.module}/hello_world.txt"
}
