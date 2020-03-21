provider "cloudflare" {
  version = "~> 1.0"
  email   = "${var.cloudflare_email}"
  token   = "${var.cloudflare_token}"
}

# Create a record
resource "cloudflare_record" "domain" {
  domain  = "${var.domain}"
  name    = "${var.name}"
  value   = "${element(scaleway_instance_server.web.*.public_ip, 0)}"
  type    = "A"
  proxied = false
}