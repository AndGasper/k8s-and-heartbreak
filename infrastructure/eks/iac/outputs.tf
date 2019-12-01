output "data_plane_vpc_arn" {
    description = "The Amazon Resource Number of the Data Plane VPC."
    value = "${module.eks_network.data_plane_vpc_arn}"
}

output "control_plane_vpc_arn" {
    description = "The ARN of the control plane VPC."
    value = "${module.eks_network.control_plane_vpc_arn}"
}