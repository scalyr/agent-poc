## This branch provides agent config files for starting up the standalone Scalyr agent.

## Configurations and Settings

The main config file is `agent.json` which contains global level settings for the entire agent.

The directory `agent.d` contains additional configuration files to aid with modularity. These are:

* `api_key.json` - the config snippet containing the API key
* `logs.json` - a config snippet for specifying which logs to monitor.  You can put multiple logs in the 
  same file, or you can split each log in to its own separate snippet.

## How to run:

1. Install `curl` if it is not installed (e.g. apt-get install -y curl)
2. Change to the agent configuration directory `cd /etc/scalyr-agent-2`
3. Download the config settings:
   1. `curl -sO https://raw.githubusercontent.com/scalyr/agent-poc/customer_t/standalone/agent.json`
   2. `curl -s -o agent.d/api_key.json https://raw.githubusercontent.com/scalyr/agent-poc/customer_t/standalone/agent.d/api_key.json`
   3. `curl -s -o agent.d/logs.json https://raw.githubusercontent.com/scalyr/agent-poc/customer_t/standalone/agent.d/logs.json`
4. Edit `agent.d/api_key.json`. Change `api_key` to your api key.
5. Edit `agent.d/logs.json`. Add log configurations for each log file you want to monitor.
6. Edit `agent.json`. Add any server attributes you'd like to associate with this serverHost.
7. Run `scalyr-agent-2 start`
7. Run `scalyr-agent-2 status -v` to ensure the agent is running
