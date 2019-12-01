- How do I update a deployment? 
- https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#updating-a-deployment

```
kubectl describe deployments 
```

```
kubectl describe deployments
Name:                   albums
Namespace:              default
CreationTimestamp:      Sat, 30 Nov 2019 02:29:57 -0800
Labels:                 com.docker.service.id=k8s-and-heartbreak-albums
                        com.docker.service.name=albums
                        com.docker.stack.namespace=k8s-and-heartbreak
Annotations:            com.docker.stack.expected-generation: 1
                        deployment.kubernetes.io/revision: 1
Selector:               com.docker.service.id=k8s-and-heartbreak-albums,com.dock                                                      er.service.name=albums,com.docker.stack.namespace=k8s-and-heartbreak
Replicas:               5 desired | 5 updated | 5 total | 5 available | 0 unavai                                                      lable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  25% max unavailable, 25% max surge
Pod Template:
  Labels:  com.docker.service.id=k8s-and-heartbreak-albums
           com.docker.service.name=albums
           com.docker.stack.namespace=k8s-and-heartbreak
  Containers:
   albums:
    Image:        agasper01/k8s-and-heartbreak-api
    Port:         <none>
    Host Port:    <none>
    Environment:  <none>
    Mounts:       <none>
  Volumes:        <none>
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Available      True    MinimumReplicasAvailable
  Progressing    True    NewReplicaSetAvailable
OldReplicaSets:  <none>
NewReplicaSet:   albums-dc8878d5d (5/5 replicas created)
Events:          <none>


Name:                   db
Namespace:              default
CreationTimestamp:      Sat, 30 Nov 2019 02:06:03 -0800
Labels:                 com.docker.service.id=k8s-and-heartbreak-db
                        com.docker.service.name=db
                        com.docker.stack.namespace=k8s-and-heartbreak
Annotations:            com.docker.stack.expected-generation: 1
                        deployment.kubernetes.io/revision: 1
Selector:               com.docker.service.id=k8s-and-heartbreak-db,com.docker.s                                                      ervice.name=db,com.docker.stack.namespace=k8s-and-heartbreak
Replicas:               1 desired | 1 updated | 1 total | 1 available | 0 unavai                                                      lable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  25% max unavailable, 25% max surge
Pod Template:
  Labels:  com.docker.service.id=k8s-and-heartbreak-db
           com.docker.service.name=db
           com.docker.stack.namespace=k8s-and-heartbreak
  Containers:
   db:
    Image:        agasper01/k8s-and-heartbreak-db
    Port:         <none>
    Host Port:    <none>
    Environment:  <none>
    Mounts:       <none>
  Volumes:        <none>
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Available      True    MinimumReplicasAvailable
  Progressing    True    NewReplicaSetAvailable
OldReplicaSets:  <none>
NewReplicaSet:   db-bbb557c66 (1/1 replicas created)
Events:          <none>


Name:                   web
Namespace:              default
CreationTimestamp:      Sat, 30 Nov 2019 02:06:03 -0800
Labels:                 com.docker.service.id=k8s-and-heartbreak-web
                        com.docker.service.name=web
                        com.docker.stack.namespace=k8s-and-heartbreak
Annotations:            com.docker.stack.expected-generation: 5
                        deployment.kubernetes.io/revision: 5
Selector:               com.docker.service.id=k8s-and-heartbreak-web,com.docker.                                                      service.name=web,com.docker.stack.namespace=k8s-and-heartbreak
Replicas:               1 desired | 1 updated | 1 total | 1 available | 0 unavai                                                      lable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  25% max unavailable, 25% max surge
Pod Template:
  Labels:  com.docker.service.id=k8s-and-heartbreak-web
           com.docker.service.name=web
           com.docker.stack.namespace=k8s-and-heartbreak
  Containers:
   web:
    Image:        agasper01/k8s-and-heartbreak-web
    Port:         80/TCP
    Host Port:    0/TCP
    Environment:  <none>
    Mounts:       <none>
  Volumes:        <none>
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Available      True    MinimumReplicasAvailable
  Progressing    True    NewReplicaSetAvailable
OldReplicaSets:  <none>
NewReplicaSet:   web-8658499d7c (1/1 replicas created)
Events:          <none>


```

```
$ docker stack rm k8s-and-heartbreak
Removing stack: k8s-and-heartbreak
```