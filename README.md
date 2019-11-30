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