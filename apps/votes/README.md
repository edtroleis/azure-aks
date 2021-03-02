# Votes app
After attach aks with acr it is necessary give permissions between them. There is a bug with terraform and azure provider api"
```
az aks update -n aks -g rg-aks --attach-acr acr_name
az aks get-credentials -n aks -g rg-aks
az acr login --name acr_name
```

## Azure Vote application
- https://github.com/Azure-Samples/azure-voting-app-redis.git
- https://docs.microsoft.com/pt-br/azure/aks/tutorial-kubernetes-deploy-application

## Login into acr
```
az acr login --name acr_name
```

## Show acr name
```
az acr list --output table
az acr list --resource-group azure-k8stest --query "[].{acrLoginServer:loginServer}" --output table
```

## List images in registry
```
az acr repository list --name acr_name --output table
```

## See tags for specific images
```
az acr repository show-tags --name acr_name --repository azure-vote-front --output table
```
