variable "sns_topic_name" {
    type = string
    description = "The name of the SNS topic."
    default = "k8s-and-heartbreak"
  
}

variable "services" {
    type = map(string)
    description = "The services allowed to use SNS."
    default = {
        "cloudwatch": "cloudwatch.amazonaws.com"
        "events": "events.amazonaws.com"
        "dynamodb": "dynamodb.amazonaws.com"
        "glacier": "glacier.amazonaws.com"
        "redshift": "redshift.amazonaws.com"
        "ses": "ses.amazonaws.com"
        "s3": "s3.amazonaws.com"
        "codecommit": "codecommit.amazonaws.com"
        "dms": "dms.amazonaws.com"
        "ds": "ds.amazonaws.com"
        "importexport": "importexport.amazonaws.com"
    }
  
}
