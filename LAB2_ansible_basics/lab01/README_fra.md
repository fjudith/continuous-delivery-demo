# LAB 3 Ansible - lab01

L'objectif de atelier 1 consiste à créer l'environnement de travail qui représentera la partie Continuous Delivery au travers de l'outil Ansible.

Quelques fonctionnalités basiques seront présentées :
- [ ] Installation Ansible
- [ ] Exécution de commande Ad-Hoc
- [ ] Création du workplace Ansible (inventory, host_vars)
- [ ] Exécution d'un playbook Ansible


## Contexte

Les déploiements démontrés seront effectués de la sorte :
- 1 serveur `deploy-server`, plateforme sur laquelle les déploiements seront exécutés.
- 1 serveur `target-server01` qui reçevera ces déploiements.



## Mise en place de l'environnement de travail

1. Sur Windows, installer Docker Desktop (https://hub.docker.com/editions/community/docker-ce-desktop-windows/).

2. Redémarrer Windows après l'installation.

3. Via le terminal (PowerShell, VSCode, ...), exécuter la commande suivante :
``` bash
docker --version
```

4. Télécharger l'image CentOS via la commande suivante :
```bash
# Télécharge l'image centos (registry dockerhub)
docker pull ubuntu
# Liste les images téléchargées
docker ps -l
```

5. Exécuter le container et y accéder via les commandes suivantes :
```bash
# Démarrer 2 containers Ubuntu dans un état infini, avec le port 80 exposé
docker run -t -d --name=deploy-server ubuntu
docker run -p 80:80 -t -d --name=target-server01 ubuntu
# Liste les containers démarrés
docker container ls
```

6. Accéder au container de déploiement et exécuter les commandes suivantes :
```bash
# Accès au prompt du container - ! si VSCode //bin//bash
docker exec -it deploy-server /bin/bash
# Installation de paquets nécessaires
apt-get update
apt-get install vim iputils-ping ssh git -y
# Démarrage du processus SSH
service ssh start
# Installation Ansible
apt-get install software-properties-common -y
apt-add-repository --yes --update ppa:ansible/ansible
apt-get install ansible -y
ansible --version
```

7. Créer le container cible sur lequel seront envoyés les déploiements :
```bash
# Démarrer le containers Ubuntu dans un état infini, avec le port 80 exposé
docker run -p 80:80 -t -d --name=target-server01 ubuntu
apt-get update
apt-get install vim iputils-ping ssh -y
```

8. Effectuer le partage de clé SSH entre les deux serveurs
```bash
# Sur le serveur `deploy-server`, générer les clés SSH sans MDP
ssh-keygen
cat ~/.ssh/id_rsa.pub
# Sur le serveur client
mkdir ~/.ssh && vim ~/.ssh/authorized_keys
# Copier la clé publique du root de la machine `deploy-server`
```

> Remarque : Il sera nécessaire de connaître les IPs des deux containers, puisque pas de résolution de nom :
> ``` hostname -i ```


## Exécution d'Ansible

1. Commande Ad-Hoc de test :
```bash
# Effectue un ping sur toutes les machines de l'inventaire
ansible all -m ping -i inventory-local
# Effectue un 'Gathering Facts' sur le serveur frontend
ansible LOC-frontend -m setup -i inventory-local
# Copie le fichier de configuration dans le home directory de
ansible LOC-frontend -i inventory-local -m copy -a "src=root/ansible/lab01/files/config_file dest=/tmp" -vvv
```

2. Exécution d'un playbook Ansible
```bash
ansible-playbook playbook_deployment.yaml -i inventory-local
```

### Documentation

La documentation officielle est bien entendue accessible via le site officiel : https://docs.ansible.com/ansible/latest/index.html.

Mais également via le CLI :
```bash
ansible-doc
ansible-doc <module>
```