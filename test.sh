#!/usr/bin/env bash

git rebase

(git rebase --show-current-patch) || true
CURRENTLY_REBASING=$?
echo "CURRENTLY_REBASING (exit code): $CURRENTLY_REBASING"

if [ $CURRENTLY_REBASING -ne 0 ]; then
  echo "Need to manually resolve conflicts.  Aborting Rebase."
  git rebase --abort
fi