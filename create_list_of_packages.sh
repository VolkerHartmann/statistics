#!/bin/bash
################################################################################
# Script for collecting packages of kit-data-manager
# Usage:
# bash create_list_of_packages.sh
################################################################################
################################################################################
# START DECLARATION FUNCTIONS
################################################################################

################################################################################
function usage {
################################################################################
  echo "Script for creating a list of all packages available inside"
  echo "'kit-data-manager' organization."
  echo "USAGE:"
  echo "  $0 "
  exit 1
}

################################################################################
function checkParameters {
################################################################################
  # Check no of parameters.
  if [ "$#" -ne 0 ]; then
    echo "Illegal number of parameters!"
    usage
  fi
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


printInfo Create markdown with links to all packages to collect download counts.
#Create markdown with links to all packages to collect download counts:
MD_FILE=organization_packages.md
echo "# List of Packages in 'kit-data-manager'" >  $MD_FILE

gh api -H 'Accept: application/vnd.github+json' -H 'X-GitHub-Api-Version: 2022-11-28' '/orgs/kit-data-manager/packages?package_type=container' |jq '.[] |  "- [\(.name)](\(.html_url))"' |xargs -L1 -I'{}' echo {} >> $MD_FILE
