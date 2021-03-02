#!/bin/bash

# How to execute
# ./deploy-votes.sh -i|--image {pull and push image}
# pull-push-images = {yes|no}
# Example: ./deploy-votes.sh -i yes

# Parse parameters
POSITIONAL=()
while [[ $# -gt 0 ]]; do
  key="$1"

  case $key in
  -i | --image)
    pull_push="$2"
    pull_push=${pull_push,,}
    shift
    shift
    ;;
  *)                   # unknow option
    POSITIONAL+=("$1") # save it in an array for later
    shift              # part argument
    ;;
  esac
done

set -- "${POSITIONAL[@]}" # restore positional parameters

pull_push_options=("yes" "no")
if [[ ! " ${pull_push_options[@]} " =~ " ${pull_push} " ]]; then
  echo "Not a valid option to pull and push Docker images. Values {yes|no} -> current value: ${pull_push}"
  exit 1
fi

# Variables
acr_name="edtroleisacr.azurecr.io"
aks_name="aks"
aks_resource_group="rg-aks"

# Pull image from docker.io
if [ $pull_push = "yes" ]; then

  echo "### Pulling from docker.io repository..."
  docker rmi -f mcr.microsoft.com/oss/bitnami/redis:6.0.8
  docker pull mcr.microsoft.com/oss/bitnami/redis:6.0.8 &&
    docker tag mcr.microsoft.com/oss/bitnami/redis:6.0.8 $acr_name/redis:6.0.8

  docker rmi -f mcr.microsoft.com/azuredocs/azure-vote-front:v1
  docker pull mcr.microsoft.com/azuredocs/azure-vote-front:v1 &&
    docker tag mcr.microsoft.com/azuredocs/azure-vote-front:v1 $acr_name/azure-vote-front:v1

  # Push to ACR repository
  echo "### Pushing to ACR repository..."
  az acr login --name $acr_name

  az acr repository delete --image redis:6.0.8 -n $acr_name --y
  docker push $acr_name/redis:6.0.8

  az acr repository delete --image azure-vote-front:v1 -n $acr_name --y
  docker push $acr_name/azure-vote-front:v1
fi

# Deploy app on aks"
echo "### Deploying app on aks..."
az aks get-credentials -n $aks_name -g $aks_resource_group

if [ $pull_push = "yes" ]; then
  kubectl apply -f azure-vote-on-acr.yaml
else
  kubectl apply -f azure-vote-all-in-one-redis.yaml
fi

sleep 10
echo "$(kubectl describe service azure-vote-front | grep "LoadBalancer Ingress")"
