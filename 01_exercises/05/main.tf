provider "template" {}

variable "user" {}
variable "password" {}

data "template_file" "config" {
  template = <<EOT
{
  "user": "${var.user}",
  "password": "${var.password}"
}
EOT
}

resource "local_file" "config_json" {
  content  = data.template_file.config.rendered
  filename = "${path.module}/config.json"
}