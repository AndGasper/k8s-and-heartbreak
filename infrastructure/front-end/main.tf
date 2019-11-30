terraform {
    required_version = "0.12.5"
}

provider "aws" {
    version = "~> 2.22"
    region = "us-east-1"
}

provider "template" {
    version = "~> 2.1"
}

module "static-site" {
    source = "./modules/static-site"
    
    site_bucket_name = "${var.site_bucket_name}"
    hosted_zone_name = "${var.hosted_zone_name}"
    
    ssm_parameter_name = "${var.ssm_parameter_name}"
}