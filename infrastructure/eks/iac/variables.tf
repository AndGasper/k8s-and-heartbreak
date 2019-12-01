variable "eks_control_plane_cidr_block" {
    type = string
    description = "The CIDR Block for the EKS Control plane."
    default = "10.0.0.0/16"
}

variable "worker_node_vpc_cidr_block" {
    type = string
    description = "The CIDR block for the worker nodes."
    # 10.1.0.0 - 10.1.255.255
    default = "10.1.0.0/16"
}

variable "worker_node_subnet_1_vpc_cidr_block" {
    type = string
    description = "The CIDR block for 1 of 2 subnets."
    # 10.1.0.0 - 10.1.0.255
    default = "10.1.0.0/24"
}

variable "worker_node_subnet_2_vpc_cidr_block" {
    type = string
    description = "The CIDR block for 2 of 2 subnets."
    # 10.1.1.0 - 10.1.1.255
    default = "10.1.1.0/24"
}


variable "cluster_name" {
    type = string
    description = "The name of the cluster. An EKS requirement."
    default = "k8s-and-heartbreak"
}



# /16 = 65,536 IP Addresses. So probably overkill, but it is a default so :shrug: