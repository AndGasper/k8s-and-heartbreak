resource "aws_vpc" "worker_node_vpc" {
    cidr_block = "${var.worker_node_vpc_cidr_block}"

    tags = {
        Name = "Worker Node VPC"
        Project = "k8s-and-heartbreak"
        "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    }
}



# there's a more elegant solution for the cidrs other than just more variables but I am tired.

# Look at IP network functions for something a little more elegant
# VPCs have the potential to span all availability zones
# And subnets span a single availability zone (AZ)
# So for first principles, let's make 2 AZ's for availability
resource "aws_subnet" "worker_node_subnet_1" {
    vpc_id = "${aws_vpc.worker_node_vpc.id}"
    cidr_block = "${var.worker_node_subnet_1_vpc_cidr_block}"
    tags = {
        Name = "Worker Node Subnet 1"
        Project = "k8s-and-heartbreak"
        "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    }
}

resource "aws_subnet" "worker_node_subnet_2" {
    vpc_id = "${aws_vpc.worker_node_vpc.id}"
    cidr_block = "${var.worker_node_subnet_2_vpc_cidr_block}"
    tags = {
        Name = "Worker Node Subnet 2"
        Project = "k8s-and-heartbreak"
        "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    }
}

resource "aws_vpc" "eks_control_plane_vpc" {
    cidr_block = "${var.eks_control_plane_cidr_block}"
    tags = {
        Name = "EKS Control Plane VPC"
        Project = "k8s-and-heartbreak"
        "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    }
}


# CLUSTER STUFF
resource "aws_eks_cluster" "eks_cluster" {
    name = "${var.cluster_name}"
    role_arn = local.cluster_iam_role_arn
    depends_on = [ 
        "aws_cloudwatch_log_group.eks_cluster_logs"
    ]

    enabled_cluster_log_types = [
        "api",
        "audit"
    ]

    tags = {
        Name = "eks-cluster"
        Project = "k8s-and-heartbreak"
    }

    vpc_config {
        security_group_ids = [ local.cluster_security_group_id ]
    }
}


resource "aws_cloudwatch_log_group" "eks_cluster_logs" {
    name = "/aws/eks/${var.cluster_name}/cluster"
    retention_in_days = 7
    tags = {
        Name = "${var.cluster_name}-logs"
        Project = "k8s-and-heartbreak"

    }
}
