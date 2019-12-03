output "event_rule_id" {
    description = "The name of the rule."
    value = "${aws_cloudwatch_event_rule.event_rule.id}"
}

output "event_rule_arn" {
    description = "The Amazon Resource Number (ARN) of the event rule."
    value = "${aws_cloudwatch_event_rule.event_rule.arn}"
}

