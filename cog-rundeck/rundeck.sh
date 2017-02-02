#!/bin/bash

export PATH=${PATH}:/usr/local/bin

declare -a ARGUMENTS
for ((i=0;i<${COG_ARGC};i++)); do
    var="COG_ARGV_${i}"
    ARGUMENTS[$i]=${!var}
done

if [ -n "${COG_OPT_PRJ}" ]; then
  project=${COG_OPT_PRJ}
else
  project=${RUNDECK_DEFAULT_PROJECT}
fi

case "$(basename "$0")" in
  list)
    rundeck-list-jobs ${project} ${ARGUMENTS[*]}
    ;;
  run)
    jobid=$(rundeck-find-job-by-name "${ARGUMENTS[*]}" ${project} | grep " ${ARGUMENTS[*]} " | cut -d' ' -f2)
    if [ -n "${jobid}" ]; then
      rundeck-run-job ${jobid} ${COG_OPT_ARG}
    else
      echo "ERROR: job not found."
    fi
    ;;
  history)
    rundeck-get-history ${project}
    ;;
  *)
    echo "ERROR: unknown command"
    exit 1
esac
