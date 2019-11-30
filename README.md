# [K8's and Heartbreak](https://k8s-and-heartbreak.com/)
- Website: https://k8s-and-heartbreak.com/
- [Docker Compose](https://docs.docker.com/compose/compose-file/)
- [Kubernetes example](https://docs.docker.com/docker-for-windows/kubernetes/)
    - [Docker + Kubernetes: Composes](https://github.com/dockersamples/k8s-wordsmith-demo/blob/master/docker-compose.yml)




Words = Albums


## Deploy me!
1. Build the docker images
```
docker-compose build
```

2. Deploy the app to Kubernetes as a stack using the compose file: 
```
export DOCKER_ORCHESTRATOR=kubernetes
docker stack deploy k8s-and-heartbreak -c docker-compose.yml
```

Note:
```
WARNING: experimental environment variable DOCKER_ORCHESTRATOR is set. Please use DOCKER_STACK_ORCHESTRATOR instead
```


Note: On windows, had to enable Kubernetes from the settings in docker



## Kubernetes Debugging (Because why would anything work right the first time)
- [Debug Application Cluster: Determine Reason For Pod Failure](https://kubernetes.io/docs/tasks/debug-application-cluster/determine-reason-pod-failure/)
- [Kubernetes Cheat Sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)


- Having to debug the albums failure
- Get the services
```
kubectl get services
```

```
NAME            TYPE           CLUSTER-IP     EXTERNAL-IP   PORT(S)          AGE
albums-here     ClusterIP      None           <none>        55555/TCP        10m
db              ClusterIP      None           <none>        55555/TCP        20m
kubernetes      ClusterIP      10.96.0.1      <none>        443/TCP          22m
web             ClusterIP      None           <none>        55555/TCP        20m
web-published   LoadBalancer   10.110.251.1   localhost     8080:32681/TCP   20m
```

- Get the pods 
- Input: 
```
kubectl get pods
```
- Output: 
```
kubectl get pods
NAME                     READY   STATUS             RESTARTS   AGE
albums-dc8878d5d-6v464   0/1     CrashLoopBackOff   4          2m39s
albums-dc8878d5d-ln9m2   0/1     CrashLoopBackOff   4          2m39s
albums-dc8878d5d-mkpcj   0/1     CrashLoopBackOff   4          2m39s
albums-dc8878d5d-rmgbv   0/1     CrashLoopBackOff   4          2m39s
albums-dc8878d5d-zx898   0/1     CrashLoopBackOff   4          2m39s
db-bbb557c66-7cb6j       1/1     Running            0          26m
web-8658499d7c-8g4db     1/1     Running            0          26m
```