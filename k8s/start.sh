#!/bin/sh

########################################################################
# This script starts the k8s daemonset
# 
# Instructions:
# a) set your Scalyr write key in your shell ( e.g. export SCALYR_API_KEY=<YOUR_SCALYR_KEY> )
# b) edit configmap.yaml to set cluster name (to match the k8s cluster you want to monitor)
# c) edit configmap.yaml to set `SCALYR_K8S_RATELIMIT_CLUSTER_NUM_AGENTS` to the approximate number of Kubernetes Nodes in your cluster.
# d) source ./start.sh <configmap_file_name>
########################################################################


CONFIGMAP_FILE="configmap.yaml"

if [ -n "$1" ]; then
    CONFIGMAP_FILE=$1
fi

if [ -z "$SCALYR_API_KEY" ]; then
    echo "Please set SCALYR_API_KEY environment variable.  Exiting."
    return
fi

# delete old objects
echo "Deleting old scalyr daemonset ..."
kubectl delete daemonset scalyr-agent-2

echo "Deleting old scalyr configmap ..."
kubectl delete configmap scalyr-config

echo "Deleting old scalyr service account ..."
kubectl delete -f https://raw.githubusercontent.com/scalyr/scalyr-agent-2/release/k8s/scalyr-service-account.yaml

echo "Deleting old scalyr api-key secret ..."
kubectl delete secret scalyr-api-key

# Create Scalyr API key secret from environment variable
echo "Creating scalyr api-key secret ..."
kubectl create secret generic scalyr-api-key --from-literal=scalyr-api-key=${SCALYR_API_KEY}

# Authorize Scalyr agent pods
echo "Creating scalyr service account ..."
kubectl create -f https://raw.githubusercontent.com/scalyr/scalyr-agent-2/release/k8s/scalyr-service-account.yaml

# Create the Scalyr config map
echo "Creating scalyr config map ..."
kubectl create -f ${CONFIGMAP_FILE}
kubectl get configmap scalyr-config -o yaml

# Create the daemonset
echo "Creating scalyr daemon set ..."
kubectl create -f ./daemonset_envfrom.yaml
