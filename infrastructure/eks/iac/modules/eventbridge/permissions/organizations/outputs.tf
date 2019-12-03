output "organizations_event_permission_id" {
    description = "The cloudwatch events permission statement id."
    value = "${aws_cloudwatch_event_permission.organization_access.id}"
}
