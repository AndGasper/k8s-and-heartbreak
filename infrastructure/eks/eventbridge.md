# Amazon EventBridge
- `AWS::Events::EventBus`
- `AWS::Events::EventBusPolicy`
- `AWS::Events::Rule`

It's kind of unclear if terraform's events implementation is the same or different from "new" eventbridge. They're the same but kind of different. 
- [aws_cloudwatch_event_permission](https://www.terraform.io/docs/providers/aws/r/cloudwatch_event_permission.html)


```
                              +----------------------
                              |             
+-----------+          +--------------+   /-> SNS
| principal | -event-> | event filter | -
+-----------+          +--------------+
                              |
                              +------------------------
```

```
+---------------------------------------------------+
| Event Force, like the Speed Force but for Events  |
+---------------------------------------------------+
```

SNS topic 

## `AWS::Events::EventBus`
- >  The AWS::Events::EventBus resource creates or updates a partner event bus or custom event bus. Partner event buses can receive events from applications and services created by AWS SaaS partners. You need to create a partner event bus for each partner event source that you want to receive events from.


- Jesus. Just use EventBus

```
Type: AWS::Events::EventBusPolicy
Properties: 
  Action: String
  Condition: 
    Condition
  EventBusName: String
  Principal: String
  StatementId: String
```
- The permission policy on the default event bus can't exceed 10 KB in size.
```
The AWS::Events::EventBusPolicy resource creates an event bus policy for Amazon EventBridge. An event bus policy enables your account to receive events from other AWS accounts. These events can trigger EventBridge rules created in your account. 
```

```
SampleEventBusPolicy: 
    Type: AWS::Events::EventBusPolicy
    Properties: 
        Action: "events:PutEvents"
        Principal: "111122223333"
        StatementId: "MyStatement"
```

```
SampleEventBusPolicy: 
    Type: AWS::Events::EventBusPolicy
    Properties: 
        Action: "events:PutEvents"
        Principal: "*"
        StatementId: "MyStatement"
        Condition: 
            Type: "StringEquals"
            Key: "aws:PrincipalOrgID"
            Value: "o-1234567890"

```

- Event Pattern?