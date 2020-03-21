output "public_ip" {
  value = ["${scaleway_instance_server.web.*.public_ip}"]
}

output "domain" {
  value = ["${cloudflare_record.domain.*.hostname}"]
}