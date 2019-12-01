variable "cluster_name" {
    type = string
    description = "The name of the cluster."
    default = "k8s-and-heartbreak"
}

variable "cluster_vpc_id" {
    type = string
    description = "The ID of the VPC to deploy the cluster into."
}