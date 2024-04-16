provider "random" {}

resource "random_integer" "red" {
  min = 0
  max = 255
}

resource "random_integer" "green" {
  min = 0
  max = 255
}

resource "random_integer" "blue" {
  min = 0
  max = 255
}

locals {
  red_hex   = format("%02x", random_integer.red.result)
  green_hex = format("%02x", random_integer.green.result)
  blue_hex  = format("%02x", random_integer.blue.result)
}

resource "local_file" "color_scheme" {
  content  = "#${local.red_hex}${local.green_hex}${local.blue_hex}"
  filename = "${path.module}/color_scheme.txt"
}