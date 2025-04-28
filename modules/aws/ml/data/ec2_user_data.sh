#!/bin/bash
set -e

# Install Git
sudo yum update -y
sudo yum install -y git

# Install New Relic
curl -Ls https://download.newrelic.com/install/newrelic-cli/scripts/install.sh | bash
sudo NEW_RELIC_API_KEY="<your API key" NEW_RELIC_ACCOUNT_ID="<your account ID>" /usr/local/bin/newrelic install -y infrastructure-agent

# Install Rye
curl -sSfL https://rye-up.com/get | RYE_INSTALL_OPTION="--yes" bash
source "/root/.rye/env"
rye init
rye add mlflow
rye sync

# Clone Git Project
git clone https://github.com/O01o/pytorch_mlflow_sample.git
cd pytorch_mlflow_sample/
rye sync
# rye run python train.py x.x.x.x 5000