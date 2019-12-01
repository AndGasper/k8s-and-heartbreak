output "data_plane_vpc_arn" {
    description = "The Amazon Resource Number of the Data Plane VPC."
    value = "${module.eks_network.data_plane_vpc_arn}"
}

output "control_plane_vpc_arn" {
    description = "The ARN of the control plane VPC."
    value = "${module.eks_network.control_plane_vpc_arn}"
}

output "control_plane_vpc_id" {
    description = "The ID of the control plane vpc."
    value = "${module.eks_network.control_plane_vpc_id}"
}

output "cluster_arn" {
    description = "The ARN of the EKS Cluster."
    value = "${module.eks_cluster.eks_cluster_arn}"
}

output "eks_cluster_endpoint" {
    description = "The endpoint of the EKS Cluster."
    value = "${module.eks_cluster.eks_cluster_endpoint}"
}

output "cluster_logs_arn" {
    description = "The ARN of the Cloudwatch Logs for the cluster"
    value = "${module.eks_cluster.aws_cloudwatch_log_group_arn}"
}