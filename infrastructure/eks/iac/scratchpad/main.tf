# https://docs.aws.amazon.com/AmazonECR/latest/userguide/RepositoryPolicyExamples.html

variable "user_arns" {
    type = list(string)
    description = "The ARNs of specific AWS users."
    default = [
        "arn:aws:iam::123456789012:user/push-pull-user-1",
        "arn:aws:iam::123456789012:user/push-pull-user-2"
    ]
}

data "aws_iam_policy_document" "ecr_repository_policy_specific_users" {
    statement {
        sid = "AllowPushPull"
        effect = "Allow"
        principals {
            type = "AWS"
            identifiers = var.user_arns
        }
        actions = [
            "ecr:GetDownloadUrlForLayer",
            "ecr:BatchGetImage",
            "ecr:BatchCheckLayerAvailability",
            "ecr:PutImage",
            "ecr:InitiateLayerUpload",
            "ecr:UploadLayerPart",
            "ecr:CompleteLayerUpload"
        ]
        resources = [
            "*"
        ]
    }
}

variable "ecr_region" {
    type = string
    default = "us-east-2"
    description = "The region that the ECR repository exists in."
}

variable "ecr_repository_owner_account_id" {
    type = string
    description = "The account id of ecr repository."
    value = "123456789012"
}

variable "ecr_repository_name" {
    type = string
    description = "The name of the ecr repository"
    value = "k8s-and-heartbreak"
}

variable "ecr_trusted_principals" {
    type = list(string)
    description = "A list of entities who are considered to be trusted to push to the ECR repository"
    default = []
}

# maybe
locals {
    repositories = [ 
        "aws:aws:ecr:${var.ecr_region}:${var.ecr_repository_owner_account_id}:repository:${var.ecr_repository_name}"
    ]
}


# NAIVE AWS SINGLE Account
data "aws_iam_policy_document" "ecr_cross_account_policy_document" {
    statement {
        sid = "AllowPush"
        effect = "Allow"
        principals {
            type = "AWS"
            identifiers = var.ecr_trusted_principals
        }
        resource = [
            "aws:aws:ecr:${var.ecr_region}:${var.ecr_repository_owner_account_id}:repository:${var.ecr_repository_name}"
        ]
    }
}

# Example IP Address Based 
data "aws_iam_policy_document" "ecr_policy_by_ip_address_document" {
    statement {
        sid = "IPAllow"
        effect = "Allow"
        principals {
            type = "AWS"
            identifiers = [
                "*"
            ]
        }
        resource = [
            "aws:aws:ecr:${var.ecr_region}:${var.ecr_repository_owner_account_id}:repository:${var.ecr_repository_name}"
        ]
        condition {
            test = "NotIpAddress"
            variable = "aws:sourceIp"
            values = "SOME_IP_ADDRESS_IN_THAT_RANGE/32"
        }
        condition {
            test = "IpAddress"
            variable = "aws:sourceIp"
            values = "SOME_RANGE_OF_IP_ADDRESSES/16"
        }
    }
}

# Example: Service-Linked Role
# Allow codebuild access
data "aws_iam_policy_document" "codebuild_access_policy_document" {
    statement {
        sid = "CodeBuildAccess"
        effect = "Allow"
        actions = [
            "ecr:BatchCheckLayerAvailability",
            "ecr:BatchGetImage",
            "ecr:GetDownloadUrlForLayer"
        ]
        principals {
            type = "Service"
            identifiers = [
                "codebuild.amazonaws.com"
            ]
        }
        resources = [
            "*"
        ]
    }
}