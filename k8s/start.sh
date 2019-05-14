#!/bin/sh

################################################
# This script starts the k8s daemonset
################################################

kubectl delete secret scalyr-api-key
kubectl create secret generic scalyr-api-key --from-literal=scalyr-api-key=YOUR_WRITE_KEY

kubectl delete -f https://raw.githubusercontent.com/scalyr/scalyr-agent-2/release/k8s/scalyr-service-account.yaml
kubectl create -f https://raw.githubusercontent.com/scalyr/scalyr-agent-2/release/k8s/scalyr-service-account.yaml

kubectl delete configmap scalyr-config
kubectl create -f ./configmap.yaml
kubectl get configmap scalyr-config -o yaml

kubectl delete daemonset scalyr-agent-2
kubectl create -f ./daemonset.yaml
