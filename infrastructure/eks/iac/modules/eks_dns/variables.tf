variable "data_plane_security_group_id" {
    type = string
    description = "The ID of a security group associated with the data plane VPC."
}

variable "control_plane_security_group_id" {
    type = string
    description = "The ID of the security group associated with the control plane VPC." 
}


variable "data_plane_subnet_1_id" {
    type = string
    description = "The ID of the data plane 1 subnet."
}

variable "data_plane_subnet_2_id" {
    type = string
    description = "The ID of the data plane 2 subnet."
}

variable "cluster_name" {
    type = string
    description = "The name of the cluster."
    default = "k8s-and-heartbreak"
}

variable "domain_name" {
    type = string
    description = "The domain name for the routing."
    default = "k8s-and-heartbreak.com"
}