#!/bin/bash
set -e

# Install Packages
sudo yum update -y
sudo yum install -y python3.9 python3-pip
sudo yum install -y git
sudo yum install -y aws-cli
sudo yum install -y jq
sudo yum install -y gcc make
curl -sSfL https://rye-up.com/get | RYE_INSTALL_OPTION="--yes" bash
source "$HOME/.rye/env"
rye init
rye add mlflow
rye sync

git clone https://github.com/O01o/pytorch_mlflow_sample.git
cd pytorch_mlflow_sample/
rye sync
rye run python image_exstractor.py
rye run python train.py x.x.x.x 5000