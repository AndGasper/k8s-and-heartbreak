variable "site_bucket_name" {
    type = "string"
    description = "The name of the site"
    default = "k8s-and-heartbreak"
}

variable "hosted_zone_name" {
    type = "string"
    description = "The name on the route53 resource"
    default = "k8s-and-heartbreak.com"
}

variable "ssm_parameter_name" {
    type = "string"
    description = "The name of the SSM parameter that points to the certificate"
    default = "CertificateArn-k8s-and-heartbreak.com"
}

