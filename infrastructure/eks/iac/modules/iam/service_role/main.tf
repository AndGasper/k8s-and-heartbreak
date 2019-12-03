resource "aws_iam_role" "service_role" {
    name = "${var.service_name}ServiceRole"
    assume_role_policy = "${data.aws_iam_policy_document.service_assume_role_policy_document.json}"
    tags = {
        Name = "${var.service_name}ServiceRole"
        Project = "k8s-and-heartbreak"
    }
}


data "aws_iam_policy_document" "service_assume_role_policy_document" {
    version = "2012-10-17"
    statement {
        principals {
            type = "Service"
            identifiers = [
                "${var.service_name}"
            ]
        }
        actions = [
            "sts:AssumeRole"
        ]
    }
}




resource "aws_iam_role" "service_role_for_sns_topic" {
    name = "${var.service_name}SnsServiceRole"
    assume_role_policy = "${data.aws_iam_policy_document.service_assume_role_policy_document.json}"
}


data "aws_iam_policy_document" "service_assume_role_policy_document" {
    version = "2012-10-17"
    statement {
        principals {
            type = "Service"
            identifiers = [
                "${var.service_name}"
            ]
        }
        actions = ["sts:AssumeRole"]
    }
}