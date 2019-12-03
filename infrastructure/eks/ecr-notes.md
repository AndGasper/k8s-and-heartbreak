# AWS Elastic Container Registry (ECR)
- [Amazon ECR Sample for CodeBuild](https://docs.aws.amazon.com/codebuild/latest/userguide/sample-ecr.html)



- [IAM and AWS STS Condition Context Keys](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_iam-condition-keys.html)

```
+-----------+
| Account 1 |
|           |
+-----------+
    ^
    |
    |
    |
+-------------------------+
| Some builder account    | ------>  +-----------+
|                         |          | Account 2 |
|                         |          |           |
|                         |          +-----------+
|                         |
+-------------------------+
        |
        |
        |
        V
    +-----------+
    | Account 3 |
    |           |
    +-----------+
```

For IAM policies, it really does not matter if you have 1 account or 1000 accounts (maybe, I could see it getting weird), just build out the principals.
That's kind of the nice part about IAM!/How Amazon has built it.


```
image_scanning_configuration {
    scan_on_push = true
}
```

- Yes, it will probably take longer, but let's be realistic, I am probably not going to sit down and write some customer scanner logic for docker images. Someone else is already fighting the good fight.
    - [Elastic Container Registry: Image  Scanning](https://docs.aws.amazon.com/AmazonECR/latest/userguide/image-scanning.html)
    - [ECR Events and EventBridge](https://docs.aws.amazon.com/AmazonECR/latest/userguide/ecr-eventbridge.html)
