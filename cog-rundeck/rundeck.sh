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
    # Just get job names and descriptions, nothing else
    # otherwise we get a huge list that exceeds the max msg length
    results=$(rundeck-list-jobs -F csv ${project} ${ARGUMENTS[*]} \
      | grep -E '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}')
    # Now get just the name and description
    if [ -n "${results}" ]; then
      echo "COG_TEMPLATE: joblist"
      echo "JSON"
      jq -nR '[inputs | split(",") | {"name": .[1], "descr": .[2]}]' <<< "${results}"
    else
      echo "COGCMD_ERROR: No jobs found for ${project}"
      echo "ERROR: No jobs found for ${project}"
    fi
    ;;
  run)
    echo "COGCMD_INFO: Finding job named ${ARGUMENTS[*]} in ${project}"
    jobid=$(rundeck-find-job-by-name "${ARGUMENTS[*]}" ${project} \
      | grep -E '[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}' \
      | cut -d' ' -f2)
    if [ -n "${jobid}" ]; then
      echo "COGCMD_INFO: found job: ${jobid}"
      echo "COGCMD_INFO: running job ${jobid} with arguments: ${COG_OPT_ARG}"
      results=$(rundeck-run-job ${jobid} ${COG_OPT_ARG})
      execution_id=$(echo $results | grep -oE '[0-9]+')
      link="${RUNDECK_URL}/project/${project}/execution/show/${execution_id}"
      echo "${results}: ${link}"
    else
      echo "COGCMD_ERROR: job not found."
      echo "ERROR: job not found."
      exit 1
    fi
    ;;
  history)
    echo "COGCMD_INFO: getting history of ${project}"
    echo "COG_TEMPLATE: table"
    rundeck-get-history ${project}
    ;;
  *)
    echo "COGCMD_ERROR: command not found: $(basename "$0")"
    echo "ERROR: unknown command"
    exit 1
esac
