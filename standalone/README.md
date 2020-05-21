## Customer load test PoC

This branch provides is a template for running customer load tests using
a standalone (i.e. not Kubernetes) version of the Scalyr Agent and sending the
load to the Scalyr internal instance, `logstaging.scalyr.com`.  The Scalyr
Agent has been configured to allow for high log volume.

## Clone appropriate branch

You will need to edit the provided config files in preparation for your
load test.  We suggest you clone the appropriate branch:

    git clone -b customer_c git@github.com:scalyr/agent-poc.git

And then change to the `standalone` directory

    cd agent-poc/standalone

## Configure the agent

Before you run the load test, you need to perform the following actions
to configure the agent

### Configure your API key

To obtain a write logs API key, log into the account provided to you
by Scalyr and go to [API keys](https://logstaging.scalyr.com/keys) page.
Copy an existing key with "Write" access in the "Log Access Keys" section.

Edit the file `agent.d/api_key.json` and add your Write Logs api key.
  
### Configure your logs

Edit the file `agent.d/logs.json` and add log config entries for each path
you want to monitor.  Be sure to set a unique parser type for each unique
file format.

See the [Scalyr
Documention](https://app.scalyr.com/help/scalyr-agent?#logUpload) for more
details about configuring logs.

### Configure server attributes

Edit the file `agent.json` and add in any server\_attributes you would like
associated with all log files.  It's ok to leave this empty.

See the [Scalyr
Documention](https://app.scalyr.com/help/scalyr-agent?#hostname) for more
details about server attributes.

### Copy config to the host

Once configured, you should copy `agent.json` and `agent.d` to
`/etc/scalyr-agent-2/agent.json` and /etc/scalyr-agent-2/agent.d` on the
host, overriding any files that were previously there.

### Starting the Scalyr Agent

You can now start the Scalyr Agent with

    scalyr-agent-2 start

## Run the load test

To achieve 20TB/day, this requires a log volume of ~230 MB/sec across the entire cluster.

We recommend each Scalyr Agent instance handles 5 MB/sec of upload traffic.

Ideally, those should be spread evenly across all hosts, therefore we suggest
having 43 hosts, each running the Scalyr Agent, and each generating up to 5
MB/sec log volume for all paths being monitored by the Scalyr Agent.

