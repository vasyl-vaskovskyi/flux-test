#!/bin/bash
echo Create Namespace
kubectl create namespace flux-system 
echo Add Age Key Secrets
sops exec-file age-key-secret.yaml "kubectl apply -f {} -n flux-system"
echo Git Pull Secrets
sops exec-file git-pull-secret.yaml "kubectl apply -f {} -n flux-system"
echo Install Components
kubectl apply -f flux-components.yaml
sleep 10
echo "Install Git & Kustomize Sync"
kubectl apply -f flux-sync.yaml
