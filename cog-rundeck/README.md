# cog-rundeck

intended to be used as a Cog bundle.

## Testing

To test against Rundeck, first run `steeef/rundeck` in its own container:

```
docker run -d -p 4440:4440 --name=rundeck steeef/rundeck
```

Then run this container with the `--net=container:` argument to share its
network. Here, list the tasks in the `test` project (you'll need to create this
project first):

```
docker run \
  -e RUNDECK_URL=http://127.0.0.1:4440 \
  -e RUNDECK_USERNAME=admin \
  -e RUNDECK_PASSWORD=password \
  -e COG_ARGC=1 \
  -e COG_ARGV_0=test \
  --net=container:rundeck \
  steeef/cog-rundeck list
```
