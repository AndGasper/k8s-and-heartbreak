```
"Condition": {
    "{condition-operator}": {
        "{condition-key}": "{condition-value}" 
    }
}
```
which "maps" to: 
```
condition {
    test = "NotIpAddress" # {condition-operator}
    variable = "aws:SourceIp" # {condition-key}
    values = "x.x.x.x/y" # {condition-value}
}
```


## Notable find(s):
- [Terraform: AWS Modules - Terraform IAM](https://github.com/terraform-aws-modules/terraform-aws-iam)
- [Terraform - IAM Roles with SAML](https://github.com/terraform-aws-modules/terraform-aws-iam/tree/master/examples/iam-assumable-roles-with-saml)