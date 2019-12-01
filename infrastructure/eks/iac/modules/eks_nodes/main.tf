# PERMISSIONS stuff
# So the nodes can pull ECR images.
data "aws_iam_policy_document" "ecr_policy_document" {
    statement {
        effect = "Allow"
        actions = [
            "ecr:BatchCheckLayerAvailability",
            "ecr:BatchGetImage",
            "ecr:GetDownloadUrlForLayer",
            "ecr:GetAuthorizationToken"
        ]
        resources = [
            "*"
        ]
    }
}