- Terraform policy for "lazy" programmatic generation
```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:CreateBucket",
                "s3:PutBucketAcl",
                "s3:PutBucketWebsite",
                "s3:PutBucketPolicy",
                "s3:GetBucketPublicAccessBlock",
                "s3:PutBucketPublicAccessBlock",
                "s3:ListBucket",
                "s3:PutObject",
                "s3:GetObject",
                "s3:GetObjectAcl",
                "s3:PutObjectAcl",
                "s3:GetBucketCORS",
                "s3:GetBucketWebsite",
                "s3:GetBucketVersioning",
                "s3:GetBucketObjectLockConfiguration",
                "s3:GetAccelerateConfiguration",
                "s3:GetBucketRequestPayment",
                "s3:GetBucketLogging",
                "s3:GetLifecycleConfiguration",
                "s3:GetReplicationConfiguration",
                "s3:GetEncryptionConfiguration",
                "s3:GetBucketLocation",
                "s3:GetBucketTagging",
                "s3:GetObjectTagging",
                "s3:DeleteBucket"
            ],
            "Resource": "arn:aws:s3:::*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "route53domains:GetDomainDetail",
                "route53domains:ListDomains",
                "route53domains:ListOperations",
                "route53domains:ListTagsForDomain",
                "route53domains:UpdateTagsForDomain",
                "route53domains:UpdateDomainNameservers",
                "route53:CreateHostedZone",
                "route53:CreateTrafficPolicy",
                "route53:CreateTrafficPolicyInstance",
                "route53:CreateTrafficPolicyVersion",
                "route53:CreateHealthCheck",
                "route53:GetHostedZone",
                "route53:GetTrafficPolicy",
                "route53:GetTrafficPolicyInstance",
                "route53:GetHealthCheck",
                "route53:GetHealthCheckCount",
                "route53:GetHealthCheckLastFailureReason",
                "route53:GetHealthCheckStatus",
                "route53:GetChange",
                "route53:ListHostedZones",
                "route53:ListResourceRecordSets",
                "route53:ListTagsForResource",
                "route53:ListTagsForResources",
                "route53:ListTrafficPolicies",
                "route53:ListHealthChecks",
                "route53:ListTrafficPolicyInstances",
                "route53:ListTrafficPolicyInstancesByHostedZone",
                "route53:ListTrafficPolicyVersions",
                "route53:UpdateTrafficPolicyInstance",
                "route53:UpdateHealthCheck",
                "route53:ChangeResourceRecordSets"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "cloudfront:CreateDistribution",
                "cloudfront:CreateDistributionWithTags",
                "cloudfront:GetDistribution",
                "cloudfront:GetDistributionConfig",
                "cloudfront:ListDistributions",
                "cloudfront:ListTagsForResource",
                "cloudfront:TagResource",
                "cloudfront:UpdateDistribution",
                "cloudfront:CreateCloudFrontOriginAccessIdentity",
                "cloudfront:GetCloudFrontOriginAccessIdentity",
                "cloudfront:DeleteCloudFrontOriginAccessIdentity"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ssm:Describe*",
                "ssm:Get*",
                "ssm:List*"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "acm:ListCertificates"
            ],
            "Resource": "*"
        }
    ]
}
```