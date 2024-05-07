#!/bin/bash
################################################################################
# Script for collecting statistics about repo
# Usage:
# bash statistics.sh [github/repo] [views|referrers]
################################################################################
################################################################################
# START DECLARATION FUNCTIONS
################################################################################

################################################################################
function usage {
################################################################################
  echo "Script for creating statistics for multiple github/repos."
  echo "Files listed in file './repo_list.txt' (default)"
  echo "USAGE:"
  echo "  $0 [file listing all repos]"
  exit 1
}

################################################################################
function checkParameters {
################################################################################
  # Check no of parameters.
  if [ "$#" -gt 1 ]; then
    echo "Illegal number of parameters!"
    usage
  fi
  FILE_WITH_REPOS="$ACTUAL_DIR"/repo_list.txt
  if [ "$#" -ne 0 ]; then
    FILE_WITH_REPOS=$1
  fi
}

################################################################################
function printInfo {
################################################################################
  echo "------------------------------------------------------------------------
---"
  echo "$*"
  echo "------------------------------------------------------------------------
---"
}

################################################################################
# END DECLARATION FUNCTIONS / START OF SCRIPT
################################################################################
################################################################################
# Test for commands used in this script
################################################################################
testForCommands="gh jq xargs"

for command in $testForCommands
do 
  if ! type "$command" >> /dev/null; then
    echo "Error: command '$command' is not installed!"
    exit 1
  fi
done

################################################################################
# Determine directory of script. 
################################################################################
ACTUAL_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

################################################################################
# Check parameters
################################################################################
checkParameters $*

echo "Reading repo list from file "$FILE_WITH_REPOS
while read line; do
  if [[ ${line:0:1} = \# ]] ; then
    echo "Skip repo: "$line 
  else
    echo "Determine statistics for repo: ${line}"
    bash "$ACTUAL_DIR"/views_statistics.sh ${line}
    bash "$ACTUAL_DIR"/clones_statistics.sh ${line}
    bash "$ACTUAL_DIR"/path_statistics.sh ${line}
    bash "$ACTUAL_DIR"/referrer_statistics.sh ${line}
  fi
done < "${FILE_WITH_REPOS}"

