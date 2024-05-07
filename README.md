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
$ git push
```

## Add new Repositories from the kit-data-manager Organization to Statistics
Append one line holding the repo name (without kit-data-manager) to 'repo_list.txt'.
To skip a repository start line with '#'

## Analyze Statistics
To analyze statistics, you can import the csv files into Excel and analyze them with a pivot table
as required.
