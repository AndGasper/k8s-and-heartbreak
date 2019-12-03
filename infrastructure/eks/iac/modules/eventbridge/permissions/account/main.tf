resource "aws_cloudwatch_event_permission" "account_level_access" {
    principal = "${var.account_principal}"
    statement_id = "${var.account_name}AccountAccess"
}