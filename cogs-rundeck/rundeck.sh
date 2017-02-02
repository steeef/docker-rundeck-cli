#!/bin/bash -x

declare -a ARGUMENTS
for ((i=0;i<${COG_ARGC};i++)); do
    var="COG_ARGV_${i}"
    ARGUMENTS[$i]=${!var}
done

case "$1" in
  list)
    command=rundeck-list-jobs
    ;;
  run)
    command=rundeck-run-job
    ;;
  history)
    command=rundeck-get-history
    ;;
  *)
    echo "ERROR: unknown command"
    exit 1
esac

/usr/local/bin/${command} ${ARGUMENTS[*]}
