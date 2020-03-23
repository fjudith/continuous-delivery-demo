# Atelier 1 - Les bases de Terraform

Les machine Scaleway sont root dès le démarrage initial (super-utilisateur par défaut).
La bonne pratique consiste donc à désactiver cet utilisateur afin de réduire les risques d'attaques.

> Remarque: Comme tout cloud publique, Scaleway est activement surveillé par les pirates.

* Sécurisation de base du système d'exploitation.

Pour vérifier que l'accès root est bien accessible :
```bash
ssh root@<ip_address>
```

## Cloud-init

Cloud-init permet, avant que la machine ne soit démarrée, de charger une configuration au système définie dans le fichier `cloud-init.yaml`.
La sécurité de cette machine et ses accès seront renforcés de cette façon :
- Désactivation du super-utilisateur `root`.
- Mise à jour des paquets.
- Création de l'utilisateur `sysops`.
- Ajout de la clé SSH pulique.

1. Editer le fichier `cloud-init/cloud-init.yaml` en fonction de votre clé SSH publique.
2. Exécuter les commandes suivantes :

```bash
# Initialisation de l'environnement de travail.
terraform init

# Initialisation du plan d'exécution.
terraform plan

# Exécution du plan d'exécution.
terraform apply
```

3. Vérifier que l'accès root ne soit plus accessible en exécutant la commande suivante :
```bash
ssh root@<ip_address>
```

4. Enfin, se connecter avec le user préalablement créé via cloud-init :
```bash
ssh sysops@<ip_address>
```