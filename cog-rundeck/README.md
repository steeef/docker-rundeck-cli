# cog-rundeck

intended to be used as a Cog bundle.

## Testing

To test against Rundeck, first create a network:

```
docker network create rundeck
```

Then run `steeef/rundeck` in its own container:

```
docker run -d -p 4440:4440 --name=rundeck --network=rundeck steeef/rundeck
```

Then run this container with the same `--network=rundeck` argument to share its
network. Here, list the tasks in the `test` project (you'll need to create this
project first):

```
docker run \
  -e RUNDECK_URL=http://rundeck:4440 \
  -e RUNDECK_USERNAME=admin \
  -e RUNDECK_PASSWORD=password \
  -e COG_ARGC=1 \
  -e COG_ARGV_0=test \
  --network=rundeck \
  steeef/cog-rundeck /bundle/rundeck.sh list
```
