# cog-rundeck

A wrapper for [go-rundeck](https://github.com/lusis/go-rundeck).
Intended to be used as a [Cog](https://github.com/operable/cog) bundle.
In order to use this with your own Rundeck installation, a few environment
variables must be set:

- `RUNDECK_URL`: The full URL to your Rundeck instance (e.g.,
  `http://rundeck.example:4440`).
- `RUNDECK_TOKEN`: The API token to use.

As an alternative to the token, you could instead use:

- `RUNDECK_USERNAME`
- `RUNDECK_PASSWORD`

Either username/password or token must be set to authenticate.

You can also specify a default project with

- `RUNDECK_DEFAULT_PROJECT`

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
  -e RUNDECK_PASSWORD=admin \
  -e COG_ARGC=1 \
  -e COG_ARGV_0=test \
  --network=rundeck \
  steeef/cog-rundeck /bundle/list
```
