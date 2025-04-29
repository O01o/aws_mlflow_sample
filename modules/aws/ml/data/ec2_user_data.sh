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

# Install uv and MLflow
curl -LsSf https://astral.sh/uv/install.sh | sh
source "/home/ec2-user/.cargo/bin"
uv init
uv add mlflow
uv sync

# Clone Git Project
git clone https://github.com/O01o/pytorch_mlflow_sample.git
cd pytorch_mlflow_sample/
uv sync
# uv run python train.py x.x.x.x 5000
