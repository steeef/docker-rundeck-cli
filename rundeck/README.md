# rundeck

## Description

Simple Rundeck install to test Rundeck CLI and Cog bundle.

By default, user "admin" with password "admin" is created. You can specify
which hostname to be redirected to by specifying the `RDECK_HOSTNAME`
environment variable.

There's no SSL, no external database. If you want to persist data, make sure to
mount these volumes:

- "/rundeck/etc"
- "/rundeck/var"
- "/rundeck/projects"
- "/rundeck/server/config"
- "/rundeck/server/data"
