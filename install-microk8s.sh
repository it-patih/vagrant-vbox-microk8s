#!/bin/bash

echo "###"
echo "### install-microk8s.sh ###"
echo `id`
echo "###"

echo "> Deploying microk8s"
#snap install microk8s --classic --channel=1.25/stable
snap install microk8s --classic --channel=1.27/stable
ufw allow in on cni0 && sudo ufw allow out on cni0
ufw default allow routed

echo "> Enable microk8s addons"
microk8s enable dns
microk8s enable dashboard
microk8s enable hostpath-storage
microk8s status
microk8s kubectl get all --all-namespaces

echo "> Host your first service in Kubernetes"
microk8s kubectl create deployment microbot --image=dontrebootme/microbot:v1
microk8s kubectl scale deployment microbot --replicas=2
microk8s kubectl expose deployment microbot --type=NodePort --port=80 --name=microbot-service

