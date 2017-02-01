Containers for [Rundeck CLI](https://rundeck.github.io/rundeck-cli/) and [go-rundeck](https://rundeck.github.io/rundeck-cli/).

# go-rundeck
Use tag "latest" for go-rundeck. To run individual commands, run the container like:

```
docker run -e RUNDECK_URL=http://rundeck:4440 RUNDECK_TOKEN=sometoken steeef/docker-rundeck-cli rundeck-list-projects
```

# rundeck-cli

Use tag "java" for the Java Rundeck CLI. To run: 

```
docker run -e RD_URL=http://rundeck:4440 -e RD_TOKEN=sometoken steeef/rundeck-cli:java projects list
```
