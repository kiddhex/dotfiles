#!/bin/sh
# Sync a local fork of the laravel/framework repository

# Specify remote upstream repository that will be synced with the fork.
if ! git config remote.upstream.url > /dev/null; then
    git remote add upstream git@github.com:laravel/framework.git
fi

printf '\n\033[0;34m%s\033[0m' "Fetching the upstream remote branches..."

# Fetch the branches and their respective commits from the upstream repository.
git fetch upstream

printf '\n\033[0;34m%s\033[0m\n\n' "Syncing local branches with upstream..."

# Sync master branch with the upstream repository
git checkout master
git merge upstream/master

# Sync 5.2 branch with the upstream repository
git checkout 5.2
git merge upstream/5.2

# Sync 5.1 branch with the upstream repository
git checkout 5.1
git merge upstream/5.1

printf '\n\033[0;32m%s\033[0m\n' "Your fork is now up to date!"
