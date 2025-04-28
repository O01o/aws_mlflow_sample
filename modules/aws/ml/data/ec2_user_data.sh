#!/bin/bash
set -e

# Install CloudWatch Agent
sudo yum install -y amazon-cloudwatch-agent

# Place /opt/aws/amazon-cloudwatch-agent/bin/config.json

# Execute CloudWatch Agent
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
  -a fetch-config \
  -m ec2 \
  -c file:/opt/aws/amazon-cloudwatch-agent/bin/config.json \
  -s

# Install Git
sudo yum update -y
sudo yum install -y git

# Install Rye and MLflow
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
