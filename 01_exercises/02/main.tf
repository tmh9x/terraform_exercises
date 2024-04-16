provider "local" {}

resource "random_integer" "number" {
  min = 1
  max = 100
}

output "number_output" {
  value = random_integer.number.result
}