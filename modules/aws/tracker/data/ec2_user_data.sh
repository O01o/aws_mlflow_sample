#!/bin/bash
set -e

# Install uv and MLflow
curl -LsSf https://astral.sh/uv/install.sh | sh
source "/home/ec2-user/.cargo/bin"
uv init
uv add mlflow
uv sync

# Start MLflow Tracking Server
uv run mlflow server --host 0.0.0.0 --port 5000