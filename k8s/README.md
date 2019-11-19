## This branch provides YAML and a shell script for starting up the Scalyr Kubernetes agent.

## Configurations and Settings

In this configuration, compression of request data is disabled because on a fast network, it allows for higher
througput.

If bandwidth is a concern, or on slower networks, enabling compression might improve throughput, but it's better
to try with a lower compression level so as to reduce CPU usage because increased CPU means the agent has less time
between requests to process incoming logs.

The setting that provides the best thoughput will be highly dependent on the customer network, and so the customer
should try both with and without compression to see which provides the best throughput for their situation.

## How to run:

1. Install `git` (e.g. apt-get install git.  Note for GKE customers: GKE CloudShell has `git` pre-installed)
2. `git clone https://github.com/scalyr/agent-poc.git --branch sidecar`
3. `cd agent-poc/k8s/`
4. `export SCALYR_API_KEY=<YOUR_API_KEY>`
5. Edit `configmap.yaml` `SCALYR_K8S_CLUSTER_NAME`: Change `<your-cluster-name>` to name of k8s cluster you wish to monitor.
7. `source start.sh` or `source sidecar.sh` to run in sidecar mode

## How to re-pull latest script version if you already downloaded before

1. `cd agent-poc/k8s/`
2. `mv configmap.yaml configmap.yaml.bak`
3. `git reset --hard`
4. `git pull`
5. Edit `configmap.yaml` `SCALYR_K8S_CLUSTER_NAME`: Change `<your-cluster-name>` to name of k8s cluster you wish to monitor.
7. Copy other custom changes you made from `configmap.yaml.bak` to `configmap.yaml` as needed.
8. `source start.sh` or `source sidecar.sh` to run in sidecar mode

