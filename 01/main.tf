provider "local" {}

resource "local_file" "name" {
  content = "Hello Terraform!"
  filename = "${path.module}/hello.txt"
}