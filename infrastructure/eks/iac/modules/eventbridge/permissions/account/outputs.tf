output "event_permission_statement_id" {
    description = "The statement id for the account granted access."
    value = "${aws_cloudwatch_event_permission.account_level_access.id}"
}
