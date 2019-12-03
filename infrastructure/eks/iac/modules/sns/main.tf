
# ENCRYPTION 
resource "aws_kms_key" "topic_key" {
    description = "KMS key for encrypting the SNS Topic."
    tags = {
        Topic = "${var.sns_topic_name}"
        Project = "k8s-and-heartbreak"


    }
}

resource "aws_kms_alias" "topic_key_alias" {
    name_prefix = "alias/${var.sns_topic_name}" 
    target_key_id = "${aws_kms_key.topic_key.id}"
}

resource "aws_sns_topic" "topic" {
    name = "${var.sns_topic_name}"
    display_name = "${var.sns_topic_name}"
    kms_master_key_id = "${aws_kms_key.topic_key.arn}"
}
# Extremely naive. Single account implementation.
data "aws_iam_policy_document" "sns_topic_event_policy_document" {
    statement {
        effect = "Allow"
        actions = [
            "sns:Publish"
        ]
        principals {
            type = "Service"
            identifiers = [
                "events.amazonaws.com"
            ]
        }
        resources = [
            "${aws_sns_topic.topic.arn}"
        ]
    }
}

resource "aws_sns_topic_policy" "sns_topic_event_policy" {
    arn = "${aws_sns_topic.topic.arn}"
    policy = "${data.aws_iam_policy_document.sns_topic_event_policy_document.json}"
}

