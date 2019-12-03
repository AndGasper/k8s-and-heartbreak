resource "aws_cloudwatch_event_rule" "event_rule" {
    name = "${var.event_rule_name}"
    description = "${var.event_rule_description}"

    event_pattern = file("${path.module}/${var.event_pattern_name}.json")

    tags = {
        Project = "k8s-and-heartbreak"
        RuleName = "${var.event_rule_name}"

    }
}
# Extremely naive 1 topic per rule 
resource "aws_cloudwatch_event_target" "event_target" {
    rule = "${aws_cloudwatch_event_rule.event_rule.name}"
    arn = "${var.event_target_arn}"

}


# AWS::Events::Rule
# cloudwatch events rule
# AWS::Events::BusPolicy ?
# Get a little hazy 
# AWS::Events::Bus


