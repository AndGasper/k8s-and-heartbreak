output "service_role_arn" {
  value = "${aws_iam_role.service_role_for_sns_topic.arn}"
  description = "The Amazon Resource Number (ARN) of the servi"
}

