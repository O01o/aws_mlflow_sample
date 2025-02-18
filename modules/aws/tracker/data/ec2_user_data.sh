#!/bin/bash
#!/bin/bash
set -e

# Install packages
curl -sSfL https://rye-up.com/get | RYE_INSTALL_OPTION="--yes" bash
source "$HOME/.rye/env"
rye init
rye add mlflow
rye sync

# Start MLflow Tracking Server
# rye run mlflow server --host 0.0.0.0 --port 5000