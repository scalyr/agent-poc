#!/bin/sh

########################################################################
# This script starts the k8s daemonset
# You must
# a) enter your Scalyr write key
# b) edit configmap.yaml to include any environment-aware variables
########################################################################

kubectl delete secret scalyr-api-key
kubectl create secret generic scalyr-api-key --from-literal=scalyr-api-key=${SCALYR_API_KEY}

kubectl delete -f https://raw.githubusercontent.com/scalyr/scalyr-agent-2/release/k8s/scalyr-service-account.yaml
kubectl create -f https://raw.githubusercontent.com/scalyr/scalyr-agent-2/release/k8s/scalyr-service-account.yaml

kubectl delete configmap scalyr-config
kubectl create -f ./configmap.yaml
kubectl get configmap scalyr-config -o yaml

kubectl delete daemonset scalyr-agent-2
kubectl create -f ./daemonset_envfrom.yaml
