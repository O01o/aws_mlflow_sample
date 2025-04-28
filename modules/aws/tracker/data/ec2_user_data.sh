#!/bin/bash
set -e

# Install Rye and MLflow
curl -sSfL https://rye-up.com/get | RYE_INSTALL_OPTION="--yes" bash
source "/home/ec2-user/.rye/env"
rye init
rye add mlflow
rye sync

# Start MLflow Tracking Server
rye run mlflow server --host 0.0.0.0 --port 5000