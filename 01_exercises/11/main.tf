provider "random" {}

resource "random_integer" "subnet_count" {
  min = 1
  max = 5
}

locals {
  subnet_cidrs = [
    for i in range(random_integer.subnet_count.result) : "10.0.${i}.0/24"
  ]
}

resource "local_file" "subnet_data" {
  content = join("\n", local.subnet_cidrs)
  filename = "${path.module}/subnets.txt"
}