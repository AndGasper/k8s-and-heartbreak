resource "aws_cloudwatch_event_permission" "organization_access" {
    principal = "*"
    statement_id = "OrganizationAccess"

    condition {
        key = "aws:PrincipalOrgID"
        type = "StringEquals"
        value = "${var.organization_id}"
    }
  
}

