#!/bin/bash
################################################################################
# Script for creating clone statistics for github/repo.
# Usage:
# bash clones_statistics.sh [github/repo] 
################################################################################
################################################################################
# START DECLARATION FUNCTIONS
################################################################################

################################################################################
function usage {
################################################################################
  echo "Script for creating clone statistics for github/repo."
  echo "USAGE:"
  echo "  $0 [github/repo]"
  exit 1
}

################################################################################
function checkParameters {
################################################################################
  # Check no of parameters.
  if [ "$#" -ne 1 ]; then
    echo "Illegal number of parameters!"
    usage
  fi

  REPOSITORY=$1
  STATISTICS=clones
  DATE=$(date -u +%Y-%m-%d)
  WEEK=$(date -u +%V)
}

################################################################################
function printInfo {
################################################################################
  echo "---------------------------------------------------------------------------"
  echo "$*"
  echo "---------------------------------------------------------------------------"
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
# Check parameters
################################################################################
checkParameters $*

printInfo "Collect clones for "$REPOSITORY" at "$DATE" (week "$WEEK")"

gh api -H 'Accept: application/vnd.github+json' -H 'X-GitHub-Api-Version: 2022-11-28'  '/repos/kit-data-manager/'$REPOSITORY'/traffic/'$STATISTICS'?per=week' | jq '.clones[] | "\(.timestamp);\(.count);\(.uniques)"' |xargs -L1 -I'{}' echo "$WEEK;$DATE;$REPOSITORY;{}" >> $STATISTICS'_weekly.csv'

