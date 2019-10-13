## This branch provides YAML and a shell script for starting up the Scalyr Kubernetes agent.

## Configurations and Settings

The main config map is found in `configmap.yaml`.  This should be the first configuration to use.

It enables log collection, event collection and metrics collection.

By default, compression of request data is enabled.  This increases CPU usage per agent, but results
in less outgoing bandwidth.  If outgoing bandwidth is not an issue, compression can be disabled by 
commenting out the appropriate line.

A number of other config maps are also provided:

* `configmap.rate-limited.yaml` - the same as configmap, but k8s api requests made by the agent are rate limited
* `configmap.no-events.yaml` - the same as configmap, but no events are collected
* `configmap.no-events-metrics.yaml` - the same as configmap, but no events and no metrics are collected

## How to run:

1. Install `git` (e.g. apt-get install git.  Note: GKE CloudShell has `git` pre-installed)
2. `git clone https://github.com/scalyr/agent-poc.git --branch customer_t`
3. `cd agent-poc/k8s/`
4. `export SCALYR_API_KEY=<YOUR_API_KEY>`
5. Edit `configmap.yaml` `SCALYR_K8S_CLUSTER_NAME`: Change `<your-cluster-name>` to name of k8s cluster you wish to monitor.
7. `source start.sh`

Note: if you want to use a different config file from `configmap.yaml`, you should edit that config file instead
and then run `source start.sh <config_file_name>`.

## How to re-pull latest script version if you already downloaded before

1. `cd agent-poc/k8s/`
2. `mv configmap.yaml configmap.yaml.bak`
3. `git reset --hard`
4. `git pull`
5. Edit `configmap.yaml` `SCALYR_K8S_CLUSTER_NAME`: Change `<your-cluster-name>` to name of k8s cluster you wish to monitor.
7. Copy other custom changes you made from `configmap.yaml.bak` to `configmap.yaml` as needed.
8. `source start.sh <config_file_name>`

Note: if you want to use a different config file from `configmap.yaml`, you should edit that config file instead
and then run `source start.sh <config_file_name>`.
