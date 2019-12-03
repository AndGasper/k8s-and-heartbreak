# [AWS EventBridge](https://docs.aws.amazon.com/eventbridge/latest/userguide/what-is-amazon-eventbridge.html)



```

event1-\    +--------------+             +-------------------------+
event2- |-->| Event Filter | -> event2 ->| Event Target: SNS Topic | -> fork-event-search-analytics-pipeline
eventN-/    +--------------+             +-------------------------+

```



```
input_transformer support the following:

input_paths - (Optional) Key value pairs specified in the form of JSONPath (for example, time = $.time)
input_template - (Required) Structure containing the template body
```


```
resource "aws_iam_role" "service_role_for_sns_topic" {
    name = "${var.service_name}SnsServiceRole"
    assume_role_policy = "${data.aws_iam_policy_document.service_assume_role_policy_document.json}"
}


data "aws_iam_policy_document" "service_assume_role_policy_document" {
    version = "2012-10-17"
    statement {
        principals {
            type = "Service"
            identifiers = [
                "${var.service_name}"
            ]
        }
        actions = ["sts:AssumeRole"]
    }
}
```