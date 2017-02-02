# cog-rundeck

intended to be used as a Cog bundle.

## Testing

To test against Rundeck, first run `jordan/rundeck` in its own container:

```
docker run -it \
  -p 4440:4440 \
  -e SERVER_URL=http://127.0.0.1:4440 \
  -e RUNDECK_ADMIN_PASSWORD=password \
  --name=rundeck \
  jordan/rundeck
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
  cog-rundeck list
```
