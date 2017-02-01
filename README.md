Containers for [Rundeck CLI](https://rundeck.github.io/rundeck-cli/) and [go-rundeck](https://github.com/lusis/go-rundeck).

# go-rundeck

```
docker run -e RUNDECK_URL=http://rundeck:4440 RUNDECK_TOKEN=sometoken steeef/go-rundeck rundeck-list-projects
```

# rundeck-cli

```
docker run -e RD_URL=http://rundeck:4440 -e RD_TOKEN=sometoken steeef/rundeck-cli projects list
```
