## Customer load test PoC

This branch provides is a template for running customer load tests using
Kubernetes and the Scalyr Agent and sending the load to the Scalyr internal
instance, `logstaging.scalyr.com`.  The Scalyr Agent has been configured to
allow for high log volume.

## Clone appropriate branch

You will need to edit the provided YAML files in preparation for your
load test.  We suggest you clone the appropriate branch:

    git clone -b customer_c git@github.com:scalyr/agent-poc.git

And then change to the `agent-poc/k8s` directory

    cd agent-poc/k8s

## Set up the required Kubernetes resources

Before you run the load test, you need to perform the following actions
to create the necesary Kubernetes resources.

### Create the Scalyr namespace.

All resources will be created in a namespace called `scalyr`.

    kubectl create namespace scalyr

### 2.  Create a secret with a write logs API key from your test account.

To obtain a write logs API key, log into the account provided to you
by Scalyr and go to [API keys](https://logstaging.scalyr.com/keys) page.
Copy an existing key with "Write" access in the "Log Access Keys" section.

Then create a secret with that value:

    kubectl create secret generic scalyr-api-key --namespace=scalyr --from-literal=scalyr-api-key="<YOUR KEY>"

### 3.  Create required Kubernetes resources.

Create the configuration state and service account used by the Scalyr Agent container.

    kubectl create -f configmap.yaml
    kubectl create -f scalyr-service-account.yaml

### 4.  Start the Scalyr Agent

   kubectl create -f scalyr-agent-2.yaml

## Run the load test

To achieve 20TB/day, this requires a log volume of ~230 MB/sec across the entire cluster.

We recommend each Scalyr Agent instance handles 5 MB/sec of upload traffic.

Ideally, those should be spread evenly across all nodes, therefore we suggest
having 43 nodes, each running the Scalyr Agent DaemonSet, and each running load
generating pods creating up to 5 MB/sec total log volume for the node.  

## Additional technical details

Things you should note from this load test:

1.  You should use the `log.config.scalyr.com/attributes.parser` annotation to specify a parser
  for your load generator.

2. The most recent build of the Scalyr Agent is `scalyr/scalyr-k8s-agent:2.1.3
3. The Kubernetes downward api needs to be used to expose environment variables to the Scalyr Agent container
4. Memory requirements under high load may increase and if memory limits are set too low, then the agent
   container will be killed.  Setting a memory request size of 80Mi and a memory limit of 150Mi should be safe values.
5. The Scalyr Agent requires various paths mapped in from the host node otherwise it won't be able
   to find the files to upload.

