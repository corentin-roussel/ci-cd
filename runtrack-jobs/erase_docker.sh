#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Veuillez exécuter ce script en tant que super utilisateur (root)."
  exit 1
fi

echo "Arrêt du service Docker..."
systemctl stop docker

echo "Suppression de tous les conteneurs..."
docker rm -f $(docker ps -aq)

echo "Suppression de toutes les images..."
docker rmi -f $(docker images -q)

echo "Suppression de tous les volumes..."
docker volume rm -f $(docker volume ls -q)

echo "Suppression de tous les réseaux..."
docker network rm $(docker network ls -q)

apt-get purge -y docker-ce docker-ce-cli containerd.io

echo "Suppression des fichiers de configuration Docker..."
rm -rf /var/lib/docker
rm -rf /var/lib/containerd
rm -rf /etc/docker

echo "Vérification de la désinstallation de Docker..."
if ! command -v docker &>/dev/null; then
  echo "Docker a été désinstallé avec succès."
else
  echo "Erreur lors de la désinstallation de Docker."
fi

echo "Nettoyage terminé."
