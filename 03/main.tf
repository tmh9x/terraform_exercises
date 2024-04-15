provider "local" {}
provider "random" {}

resource "random_string" "file_name" {
  length = 10
  special = false
  upper = false
  numeric = false
}

resource "local_file" "file" {
  content = "Hello Terraform!"
  filename = "${path.module}/${random_string.file_name.result}.txt"
  directory_permission = "0644"
  file_permission = "0644"
}