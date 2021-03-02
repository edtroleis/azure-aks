# Horizontal Pod Autoscaler Walkthrough
https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/

## Deploy pods
```
az aks get-credentials -n aks -g rg-aks
kubectl apply -f https://k8s.io/examples/application/php-apache.yaml
```

## Setting autoscaler
```
kubectl autoscale deployment php-apache --cpu-percent=50 --min=1 --max=10
```

# Monitoring
```
kubectl get hpa -w
```

## Increase load
Now, we will see how the autoscaler reacts to increased load. We will start a container, and send an infinite loop of queries to the php-apache service (please run it in a different terminal):
```
kubectl run -i --tty load-generator --rm --image=busybox --restart=Never -- /bin/sh -c "while sleep 0.01; do wget -q -O- http://php-apache; done"
```
