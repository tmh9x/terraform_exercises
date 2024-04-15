provider "tls" {}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
}

resource "tls_self_signed_cert" "example" {
  private_key_pem = tls_private_key.rsa.private_key_pem
  validity_period_hours = 6
  early_renewal_hours = 3
  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
  dns_names = ["example.com"]
}
