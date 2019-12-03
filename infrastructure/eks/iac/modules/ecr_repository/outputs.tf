output "ecr_repository_name" {
    description = "The name of the repository."
    value = "${aws_ecr_repository.ecr_repository.name}"
}
output "ecr_repository_arn" {
    description = "The ARN of the ECR repository."
    value = "${aws_ecr_repository.ecr_repository.arn}"
}

output "ecr_repository_url" {
    description = "The URL of the repository"
    value = "${aws_ecr_repository.ecr_repository.repository_url}"
}

output "ecr_kitchen_sink" {
    description = "A kitchen sink output. Curious if this works."
    value = {
        "arn": "${aws_ecr_repository.ecr_repository.arn}",
        "url": "${aws_ecr_repository.ecr_repository.repository_url}"
    }
}