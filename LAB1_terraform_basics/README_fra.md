# Atelier 1 - Les bases de terraform

L'objectif de atelier 1 consite à créer un serveur Linux exposé sur internet.

## Contexte

Cet atelier repose sur le Cloud publique Scaleway qui est très apprécié des developpeurs en France pour son faible coût et sa simplicité.
Cependant cette simplicité se paye par certains défauts de sécurité dont il faut se **préoccuper**.

Au delà de l'approvisionnement en ressources, Terraform permet d'interragir à la volée avec les ressources, cela permet à l'opérateur de pousser des fonctions basiques de sécurité.

Les concepts clés suivants sont abordés lors de la mise en oeuvre :

* Protection des données sensibles dans Git
* Génération de ressources dans le Cloud
* Sécurisation des machines (fondamentaux)


## Mise en oeuvre

### Protection des données sensibles dans Git

Il est impératif de se poser la question de la protection des données suivantes afin qu'elles ne se retrouvent pas publiées dans l'historique de Git.

1. [ ] **La clé API du fournisseur Cloud** utilisée pour s'approvisionner auprès du fournisseur Cloud.
2. [ ] **La clé privée SSH** utilisée notamment pour configurer les machines.
3. [ ] **Les fichiers de configuration** utilisés pour le ciblage.
4. [ ] **Les données de travail** du gestionnaire de configuration.

#### Solution de base

La solution de base consiste à exclure les fichiers sensibles de l'historique de GIT.
Ce dernier le permet à l'aide du fichier `.gitignore`.

Dans le cas de Terraform ce sont les fichiers `*.tfvars`, (ici `terraform.tfvars`) qui sont les plus critiques puisqu'ils servent justement de source de personnalisation du déploiement.
Cependant Terraform génère également plusieurs fichiers de travail.

Notamment `terraform.tfstate` qui contient l'inventaire des ressources approvisionnées qui contient des informations tout aussi interressantes pour un attaquant :

* Le nom de l'hébergeur
* Le nom d'hôte des machines
* Les adresses IP publiques

**Consulter le fichier** [.gitignore](./.gitignore)

## Génération de ressources dans le Cloud

La génération de ressources dans le Cloud consistera à, dans un premier temps, définir les spécifications du serveur qui sera provisionné, puis les déployer dans le provideur Cloud sélectionné (ici Cloudflare).

Le fichier `main.tf` recensera toutes les informations nécessaires pour le provisionnement :

* Hébergeur
* Stratégie d'accès (ports, access/deny, ...)
* Image, correspondant à l'OS
* ...

INFO : La syntaxe et les données envoyées pour le  provisionnement de machine peut différer d'un hébergeur à un autre. Il est nécessaire alors de se renseigner sur la documentation officielle de Terraform qui répertorie tous ces hébergeurs (https://www.terraform.io/docs/providers/index.html)

1. Créer votre fichier `terrafrom.tfvars` à l'aide des données transmises par le formateur.
2. Exécuter les commandes suivantes pour créer votre machine :

```bash
# Initialisation de l'environnement de travail
terraform init

# Initialisation du plan d'exécution
# 1. Validation des accès
# 2. Simulation du déploiement (dry-run)
# 3. Arbitrage des ressources (création, modification, destruction)
terraform plan

# Exécution du plan
terraform apply
```

A la fin du processus, les informations suivantes doivent s'afficher :

```text
Apply complete! Resources: 1 added, 1 changed, 0 destroyed.

Outputs:

domain = [
    <your_name>.testruction.io
]
public_ip = [
    <your_public_ip>
]
```


## Sécurisation des machines (fondamentaux)
