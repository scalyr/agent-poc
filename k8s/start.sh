#!/bin/sh

########################################################################
# This script starts the k8s daemonset
# 
# Instructions:
# a) set your Scalyr write key in your shell ( e.g. export SCALYR_API_KEY=<YOUR_SCALYR_KEY> )
# b) edit configmap.yaml to set cluster name (to match the k8s cluster you want to monitor)
# c) source ./start.sh
########################################################################

# delete old objects
kubectl delete daemonset scalyr-agent-2
kubectl delete configmap scalyr-config
kubectl delete -f https://raw.githubusercontent.com/scalyr/scalyr-agent-2/release/k8s/scalyr-service-account.yaml
kubectl delete secret scalyr-api-key

# Create Scalyr API key secret from environment variable
kubectl create secret generic scalyr-api-key --from-literal=scalyr-api-key=${SCALYR_API_KEY}

# Authorize Scalyr agent pods
kubectl create -f https://raw.githubusercontent.com/scalyr/scalyr-agent-2/release/k8s/scalyr-service-account.yaml

# Create the Scalyr config map
kubectl create -f ./configmap.yaml
kubectl get configmap scalyr-config -o yaml

# Create the daemonset
kubectl create -f ./daemonset_envfrom.yaml
