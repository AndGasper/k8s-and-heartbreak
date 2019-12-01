output "eks_cluster_arn" {
    description = "The ARN of the EKS cluster."
    value = "${aws_eks_cluster.eks_cluster.arn}"
}

output "eks_cluster_certificate_authority" {
    description = "The certificate authority information."
    value = "${aws_eks_cluster.eks_cluster.certificate_authority}"
}

output "eks_cluster_endpoint" {
    description = "The endpoint to ping for accessing the kubernetes api within the cluster."
    value = "${aws_eks_cluster.eks_cluster.endpoint}"
}

output "aws_cloudwatch_log_group_arn" {
    description = "The ARN of the cloudwatch logs group for the cluster."
    value = "${aws_cloudwatch_log_group.cluster_logs.arn}"
}

output "logs_kms_key_arn" {
    description = "The ARN of the KMS key for the logs group."
    value = "${aws_kms_key.logs_kms_key.arn}"
}
