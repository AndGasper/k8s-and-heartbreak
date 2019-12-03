# Simple Notification Service (SNS)
- [Protecting Amazon SNS Data Using Server-Side Encryption (SSE) and AWS KMS](https://docs.aws.amazon.com/sns/latest/dg/sns-server-side-encryption.html)


### Cost Calculation 
```
API Requests per Topic (R) =    Billing Period (B) seconds
                                -------------------------
                                 Data Key Reuse Period (D) seconds * (2 * Publishing Principals (P) )
```

- Why the 2?
- 


{
    "cloudwatch": "cloudwatch.amazonaws.com",
    "events": "events.amazonaws.com",
    "dynamodb"
}
>  Enable Compatibility between Event Sources from AWS Services and Encrypted Topics
```
{
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
```

```
Some Amazon SNS event sources require you to provide an IAM role (rather than the service principal) in the AWS KMS key policy:
Amazon EC2 Auto Scaling
Amazon Elastic Transcoder
AWS CodePipeline
AWS Config
AWS Elastic Beanstalk
AWS IoT
```
- Interesting
    - [SNS Fork Pipeline as Subscriber](https://docs.aws.amazon.com/sns/latest/dg/sns-fork-pipeline-as-subscriber.html)
    - fork-event-search-analytics-pipeline

Fan out filtered events: `fork-event-search-analytics-pipeline`
             +---------------------------------------------------------------------------+  +------------------+
SNS Topic ---->|SQS -> Lambda -> Kinesis Firehose ---------------> ElasticSearch Service <---| Kibana Dashboard |s
             |                                                                            |  +------------------+
             |                  | Store Dead letter events                                |
             |                                                                            |
             |                  V                                                         |
             |                   S3                                                       |
             +----------------------------------------------------------------------------+