#!/bin/bash

# How to execute
# ./scale-pod.sh -n|--number {numberPods} -d|--deploy
# n|number = number of pods to deploy
# d|deploy = deploy autoscaling-example
# Example: ./scale-pod.sh --deploy

# Parse parameters
POSITIONAL=()
while [[ $# -gt 0 ]]; do
  key="$1"

  case $key in
  -n | --number)
    numberPods="$2"
    numberPods=${numberPods,,}
    shift
    shift
    ;;
  -d | --deploy)
    deploy="true"
    shift
    shift
    ;;
  *)                      # unknow option
    POSITIONAL+=("$1")    # save it in an array for later
    shift                 # part argument
    ;;
  esac
done

set -- "${POSITIONAL[@]}" # restore positional parameters

# variables
aksResourceGroup="rg-aks"
aksName="aks"
aksNamespace="scaling-demo"

# connect aks
az aks get-credentials -n $aksName -g $aksResourceGroup

if [[ $deploy = "true" ]]; then
  # Create a dedicated namespace
  kubectl create namespace $aksNamespace

  # Deploy the application to AKS
  kubectl apply -f https://raw.githubusercontent.com/ThorstenHans/aks-cluster-scaling-demo/master/kubernetes/scaling-demo.yaml -n $aksNamespace

  echo "Deployed scaling-demo application on $aksName."
else
  # scale demo deployment to numberPods replicas
  kubectl scale deploy/demo -n $aksNamespace --replicas $numberPods

  echo "Scaled scaling-demo to $numberPods pods"
fi
