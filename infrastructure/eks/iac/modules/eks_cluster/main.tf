
data "aws_subnet_ids" "cluster_vpc_subnets" {
    vpc_id = "${var.cluster_vpc_id}"
}


resource "aws_eks_cluster" "eks_cluster" {
    name = "${var.cluster_name}"
    depends_on = ["aws_cloudwatch_log_group.cluster_logs"]

    role_arn = "${aws_iam_role.cluster_role.arn}"

    vpc_config {
        endpoint_private_access = true
        subnet_ids = "${data.aws_subnet_ids.cluster_vpc_subnets.ids}"
    }

    tags = {
        Name = "${var.cluster_name}"
        Project = "k8s-and-heartbreak"
    }

}

resource "aws_iam_openid_connect_provider" "iam_connector" {
    client_id_list = [
        "sts.amazonaws.com"
    ]
    thumbprint_list = []
    # :thunk:
    url = "${aws_eks_cluster.eks_cluster.identity.0.oidc.0.issuer}"
}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "kube_assume_role_policy" {
    statement {
        actions = [ "sts:AssumeRoleWithWebIdentity"]
        effect = "Allow"

        condition {
            test = "StringEquals"
            variable = "${replace(aws_iam_openid_connect_provider.iam_connector.url, "https://", "")}:sub"
            values = ["system:serviceaccount:kube-system:aws-node"]
        }

        principals {
            identifiers = [ "${aws_iam_openid_connect_provider.iam_connector.arn}"]
            type = "Federated"
        }
    }
}

resource "aws_iam_role" "cluster_openid_role" {
    assume_role_policy = "${data.aws_iam_policy_document.kube_assume_role_policy.json}"
    name = "cluster_role"
}

# LOGGING
resource "aws_kms_key" "logs_kms_key" {
    description = "The KMS Key for encrypting logfiles."
    policy = "${data.aws_iam_policy_document.logs_kms_policy_document.json}"
    tags = {
        Name = "${var.cluster_name} KMS Key"
        Project = "k8s-and-heartbreak"
    }
}
resource "aws_cloudwatch_log_group" "cluster_logs" {
    depends_on = [
        "aws_kms_key.logs_kms_key"
    ]

    name = "/aws/eks/${var.cluster_name}/cluster"
    retention_in_days = 7

    # kms_key_id = "${aws_kms_key.logs_kms_key.key_id}"

    tags = {
        Name = "${var.cluster_name} Cluster Logs"
        Project = "k8s-and-heartbreak"
    }
}

data "aws_iam_policy_document" "eks_cluster_assume_role" {
    statement {
        effect = "Allow"
        actions = [
            "sts:AssumeRole"
        ]
        principals {
            type = "Service"
            identifiers = [
                "eks.amazonaws.com"
            ]
        }
    }
}

resource "aws_iam_role" "cluster_role" {
    name = "ClusterRole"
    description = "An IAM role for the EKS cluster"
    assume_role_policy = "${data.aws_iam_policy_document.eks_cluster_assume_role.json}"
    
    tags = {
        Name = "${var.cluster_name}Role"
        Project = "k8s-and-heartbreak"
    }
}

resource "aws_iam_role_policy_attachment" "eks_service_policy_attachment" {
    role = "${aws_iam_role.cluster_role.name}"
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"

}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy_attachment" {
    role = "${aws_iam_role.cluster_role.name}"
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"

}





data "aws_iam_policy_document" "logging_policy_document" {
    statement {
        sid = "CreateLogGroup"
        effect = "Allow"
        actions = [
            "logs:CreateLogGroup"
        ]
        resources = [
            "*"
        ]
    }
    statement {
        sid = "CreateLogStream"
        effect = "Allow"
        actions = [
            "logs:CreateLogStream",
            "logs:DescribeLogStreams"
        ]
        resources = [
            "arn:aws:logs:*:*:log-group:/aws/eks/*:*"
        ]
    }

    statement {
        sid = "PutLogEvents"
        actions = [
            "logs:PutLogEvents"
        ]
        resources = [
            "arn:aws:logs:*:*:log-group:/aws/eks/*:*:*"
        ]
    }
}

resource "aws_iam_policy" "eks_logging_policy" {
    name = "EksLoggingPolicy"
    description = "EKS Logging Policy since I figure the managed policy ARNs will have to fade away eventually."
    policy = "${data.aws_iam_policy_document.logging_policy_document.json}"
}

data "aws_region" "current" {}


data "aws_iam_policy_document" "logs_kms_policy_document" {
    # Allow account to continue to manage the key
    statement {
        sid = "Enable IAM User Permissions"
        effect = "Allow"
        principals {
            type = "AWS"
            identifiers = [
                "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
            ]

        }
        actions = [
            "kms:*"
        ]
        resources = [
            "*"
        ]
    }
    statement {
        sid = "AllowLogsToUseKMS"
        effect = "Allow"
        actions = [
            "kms:Encrypt*",
            "kms:Decrypt*",
            "kms:ReEncrypt*",
            "kms:GenerateDataKey*",
            "kms:Describe*"
        ]
        principals {
            type = "Service"
            identifiers = [
                "logs.${data.aws_region.current.name}.amazonaws.com"
            ]
        }
        # Grumbles.
        resources = [
            "*"
        ]
    }
    
}

data "aws_iam_policy_document" "logs_assume_role_policy" {
    statement {
        effect = "Allow"
        actions = [
            "sts:AssumeRole"
        ]
        principals {
            type = "Service"
            identifiers = [
                "logs.${data.aws_region.current.name}.amazonaws.com"
            ]
        }
    }
}

resource "aws_iam_role" "cloudwatch_logs_role" {
    name = "EksCloudwatchLogsRole"
    assume_role_policy = "${data.aws_iam_policy_document.logs_assume_role_policy.json}"
}


resource "aws_kms_grant" "kms_grant_cluster" {
    depends_on = [
        "aws_kms_key.logs_kms_key"
    ]
    name = "${var.cluster_name}-kms-grant"
    key_id = "${aws_kms_key.logs_kms_key.key_id}"
    grantee_principal = "${aws_iam_role.cluster_role.arn}"
    operations = [
        "Encrypt",
        "Decrypt",
        "ReEncryptTo",
        "ReEncryptFrom",
        "GenerateDataKey",
        "DescribeKey" 
    ]
}
# Grant the logs service permission to use the KMS key
# tighten with encryption context
resource "aws_kms_grant" "kms_grant_logs" {
    depends_on = [
        "aws_kms_key.logs_kms_key"
    ]

    name = "logs-kms-grant"
    key_id = "${aws_kms_key.logs_kms_key.key_id}"
    grantee_principal = "${aws_iam_role.cloudwatch_logs_role.arn}"
    operations = [
        "Encrypt",
        "Decrypt",
        "ReEncryptTo",
        "ReEncryptFrom",
        "GenerateDataKey",
        "DescribeKey"   
    ]  
}



