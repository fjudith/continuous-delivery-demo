variable "scaleway_region" {
  description = "Scaleway hosting region: Paris (par1), Amsterdam (ams1)"
  default     = "fr-par"
}

variable "scaleway_access_key" {
  description = "Scaleway access_key"
  default     = "12345678-1234-1234-1234-123456789abc"
}

variable "scaleway_secret_key" {
  description = "Scaleway secret_key"
  default     = "12345678-1234-1234-1234-123456789abc"
}

variable "scaleway_organization_id" {
  description = "Scaleway organization_id"
  default     = "12345678-1234-1234-1234-123456789abc"
}

variable "scaleway_zone" {
  description = "Scaleway zone"
  default     = "fr-par-1"
}

variable "cloudflare_email" {
  description = "Cloudflare email"
  default     = "admin@example.com"
}

variable "cloudflare_token" {
  description = "Cloudflare Global API Key"
  default     = "12345678123412341234123456789abc"
}

variable "name" {
  description = "Name allocated to resources and tags"
  default     = "12345678123412341234123456789abc"
}

variable "domain" {
  description = "DNS zone"
  default     = "example.com"
}