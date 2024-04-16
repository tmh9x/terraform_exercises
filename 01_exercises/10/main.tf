provider "random" {}

resource "random_password" "secure_password" {
  length = 12
  special = true
}

output "password" {
  sensitive = true
  value = random_password.secure_password.result
}
