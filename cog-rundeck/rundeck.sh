#!/bin/bash

export PATH=${PATH}:/usr/local/bin

echo "COGCMD_WARN: Getting arguments"
declare -a ARGUMENTS
for ((i=0;i<${COG_ARGC};i++)); do
    var="COG_ARGV_${i}"
    ARGUMENTS[$i]=${!var}
done

echo "COGCMD_WARN: Getting project"
if [ -n "${COG_OPT_PRJ}" ]; then
  project=${COG_OPT_PRJ}
else
  project=${RUNDECK_DEFAULT_PROJECT}
fi
echo "COGCMD_INFO: Using project ${project}"

case "$(basename "$0")" in
  list)
    echo "COGCMD_INFO: Listing jobs in project ${project}"
    rundeck-list-jobs ${project} ${ARGUMENTS[*]}
    ;;
  run)
    echo "COGCMD_INFO: Finding job named ${ARGUMENTS[*]} in ${project}"
    jobid=$(rundeck-find-job-by-name "${ARGUMENTS[*]}" ${project} | grep " ${ARGUMENTS[*]} " | cut -d' ' -f2)
    if [ -n "${jobid}" ]; then
      echo "COGCMD_INFO: found job: ${jobid}"
      echo "COGCMD_INFO: running job ${jobid} with arguments: ${COG_OPT_ARG}"
      rundeck-run-job ${jobid} ${COG_OPT_ARG}
    else
      echo "COGCMD_ERROR: job not found."
      echo "ERROR: job not found."
    fi
    ;;
  history)
    echo "COGCMD_INFO: getting history of ${project}"
    rundeck-get-history ${project}
    ;;
  *)
    echo "COGCMD_ERROR: command not found: $(basename "$0")"
    echo "ERROR: unknown command"
    exit 1
esac
