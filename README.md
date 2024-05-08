# Create Statistics of all Public Repos in 'kit-data-manager' Organization
## Requirements
- bash
- jq
- gh
- xargs

## Usage
### Generate Personal Access Token
Use this [link](https://github.com/settings/tokens) to generate a personal access token with
at least the following rights: 
- admin:public_key
- read:org
- read:packages
- repo

Copy generated link and store it in a local file (e.g.: mytoken.txt)!

### Authenticate for gh
```
# Authenticate against github.com by reading the token from a file
$ gh auth login --with-token < mytoken.txt
```
### Clone Repo
```
$ git clone THIS_REPO
$ cd THIS_REPO
```
### Create Statistics
```
$ bash create_repo_statistics.sh
```
### Push Results to GitHub
```
$ git add *.csv
$ git commit -m "Add new results to files holding statistics."
$ git push
```

## Add new Repositories from the kit-data-manager Organization to Statistics
Append one line holding the repo name (without kit-data-manager) to 'repo_list.txt'.
To skip a repository start line with '#'

## Analyze Statistics
To analyze statistics, you can import the csv files into Excel and analyze them with a pivot table
as required. (See [example](example/AnalyzeStatisticsExample.xlsx))

## Collect Download Counts of Packages
Use links listed in [organization_packages](organization_packages.md) to collect download counts
of packages. 

:information_source: If the list is no longer up to date due to new package(s) create a new list:

```
$ bash create_list_of_packages.sh
$ git add organization_packages.md
$ git commit -m "Refresh packages list."
$ git push
```

