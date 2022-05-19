#!/usr/bin/env bash

# Create a new branch for the PR based on the original source branch
SOURCE_BRANCH="release-2.3"
DESTINATION_BRANCH="main"
MERGE_BRANCH="${INPUT_PR_MERGE_BRANCH:-"merge-branch"}"
git checkout -b $MERGE_BRANCH origin/$SOURCE_BRANCH

# Change the upstream branch to the destination branch
git branch -u origin/$DESTINATION_BRANCH

# Rebase the new source branch onto the destination branch
git rebase || true

(git rebase --show-current-patch) || true
CURRENTLY_REBASING=$?
echo "CURRENTLY_REBASING (exit code): $CURRENTLY_REBASING"

if [ $CURRENTLY_REBASING -ne 0 ]; then
  echo "Need to manually resolve conflicts.  Aborting Rebase."
  git rebase --abort
fi