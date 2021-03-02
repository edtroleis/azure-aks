#!/bin/bash

# variables
aksResourceGroup="rg-aks"
aksName="aks"
aksNamespace="scaling-demo"

while true; do

  printf "\n*****************************************************************************************\n"
  # Check replicas
  pods=$(kubectl get pods -n scaling-demo --no-headers | wc -l)

  # check AKS cluster nodes count
  nodes=$(kubectl get nodes --no-headers | wc -l)

  printf "# Pods: $pods\n"
  printf "# Nodes: $nodes\n\n"

  printf "# Deployment scaling-demo information\n"
  kubectl get deploy -n scaling-demo

  printf "\n# Cluster utilization\n"
  kubectl top nodes

  #echo "Press [CTRL+C] to stop..."
  sleep 15
done
