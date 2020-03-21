# Configuration du poste de travail

## AnyDesk

Outil de partage et contrôle d'écran à distance.
C'est cet outil qui sera utilisé en cas d'assistance.

https://download.anydesk.com/AnyDesk.exe?_ga=2.150720118.1107067096.1584801492-1250718496.1584801492


## Chocolatey

Chocolatey est un gestionnaire d'installation de logiciel qui simplie grandement l'initialisation de l'environnement de travail.

Lancer **Windows Powershell** en tant qu'Administrateur, puis exécuter la commande suivante pour installer **Chocolatey**.

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```

Lancer les commandes suivantes pour installer les logiciels requis pour les séances de **travaux pratiques**.

```powershell
choco install -y visualstudiocode sharex git.install kubernetes-cli python3 pip
choco install -y terraform=0.11.14
```

Fermer la fenêtre Window Powershell. 

## Ansible

Lancer **Git Bash**, puis exécuter les commandes suivantes pour installer Ansible v2.8

```bash
pip install ansible==2.8.10
```

## Envoi Clé SSH 

Une clé publique SSH est requise pour l'exécution des Travaux Pratiques

> Si vous possédz déjà une clé publique SSH, veuillez la transmettre au Formateur.

Si vous ne possédez **pas** de clé SSH, exécuter les commandes suivantes pour la générer.

```bash
ssh-keygen -t rsa  -b 4090 -C "<adresse email>"
```

Exécuter la commande suivante afin d'afficher la clé publique SSH.

```bash
cat ~/.ssh/id_rsa.pub
```

Transmettez la clé publique SSH au formateur pour qu'il puisse l'enregistrer chez le fournisseur d'infrastructure.

## Téléchargement des TPs

Lancer les commandes