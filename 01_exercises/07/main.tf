provider "http" {}

data "http" "chuck_norris_joke" {
  url = "https://api.chucknorris.io/jokes/random"
}

resource "local_file" "chuck_norris_joke" {
  content = data.http.chuck_norris_joke.response_body
  filename = "${path.module}/chuck_norris_joke.json"
}