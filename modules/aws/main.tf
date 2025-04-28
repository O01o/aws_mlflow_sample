locals {
  region = "ap-northeast-1"
  name = "a-matsui"
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = local.region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

module "common" {
  source = "./common"
  name = "${local.name}-common"
  region = local.region
  az = {
    first = "a"
    second = "c"
  }
}

module "ml" {
  source = "./ml"
  name = "${local.name}-ml"
  region = local.region
  vpc_id = module.common.vpc_id
  subnet_id = module.common.vpc_subnet_id_second
  depends_on = [ module.common ]
}

module "tracker" {
  source = "./tracker"
  name = "${local.name}-tracker"
  region = local.region
  vpc_id = module.common.vpc_id
  subnet_id = module.common.vpc_subnet_id_second
  key_pair_name = var.key_pair_name
  depends_on = [ module.common ]
}