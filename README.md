# backup_git_repos

## Usage

### 1. Install gh

```shell
brew install gh
# login with github account
gh auth login
```

### 2. Run the backup script

> NOTE: The script will clone all repos in the org list, be sure to have enough disk space and replace `YOUR_ORG_NAME` with your org name.

```shell
git clone https://github.com/0xrjman/backup_git_org_repos
cd backup_git_org_repos && chmod +x ./backup_git_org_repos.sh
./backup_git_org_repos.sh "YOUR_ORG_NAME"
```

or

```shell
gh repo list YOUR_ORG_NAME -L 3000 | awk '{print $1}' | xargs -I {} sh -c 'echo "Cloning {}..."; gh repo clone {} -- -q; echo "{} cloned."'
```
