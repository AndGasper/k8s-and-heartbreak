output "sns_topic_arn" {
    description = "The Amazon Resource Number (ARN) of the Simple Notification Service (SNS) topic."
    value = "${aws_sns_topic.topic.arn}"
}
output "sns_topic_kms_key_arn" {
  description = "The ARN of the KMS key created for the SNS topic."
  value = "${aws_kms_key.topic_key.arn}"
}
