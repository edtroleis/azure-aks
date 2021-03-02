#!/bin/bash

# variables
aksResourceGroup="rg-aks"
aksName="aks"

# connect aks
az aks get-credentials -n $aksName -g $aksResourceGroup

# deploy apache auto-scaler example
kubectl apply -f https://k8s.io/examples/application/php-apache.yaml

## Setting autoscaler
kubectl autoscale deployment php-apache --cpu-percent=50 --min=1 --max=10
