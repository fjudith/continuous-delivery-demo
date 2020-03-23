# Connexion à l'API du founisseur
provider "scaleway" {
  access_key      = "${var.scaleway_access_key}"
  secret_key      = "${var.scaleway_secret_key}"
  organization_id = "${var.scaleway_organization_id}"
  zone            = "${var.scaleway_zone}"
  region          = "${var.scaleway_region}"
}

# Génération d'une IP publique
resource "scaleway_instance_ip" "public_ip" {}


# Génération de la stratégie de sécurité réseau
# Note: Ouverture pour les protocoles SSH, HTTP et HTTPS uniquement
resource "scaleway_instance_security_group" "www" {
  inbound_default_policy  = "drop"
  outbound_default_policy = "accept"

  inbound_rule {
    action = "accept"
    port   = "22"
  }

  inbound_rule {
    action = "accept"
    port   = "80"
  }

  inbound_rule {
    action = "accept"
    port   = "443"
  }
}

# Génération du serveur comprenant l'association des ressources précédement approvisionnés
# i.e. IP publique, stratégie.
resource "scaleway_instance_server" "web" {
  type  = "DEV1-S"
  image = "ubuntu-bionic"

  tags = [ "front", "web", "${var.name}" ]

  ip_id = "${scaleway_instance_ip.public_ip.id}"

  security_group_id = "${scaleway_instance_security_group.www.id}"
  
  cloud_init = "${file("cloud-init/cloud-init.yaml")}"

}