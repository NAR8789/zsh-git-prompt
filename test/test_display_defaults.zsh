#!/bin/zsh -y

setUp() {
  clean_git_vars
}

test_clean() {
  assertGitPromptEquals '[00m[[01;35mmaster[00m|[01;32m✔[00m][00m'
}

test_all_basic_metrics() {
  GIT_AHEAD=1
  GIT_BEHIND=2
  GIT_STAGED=3
  # no GIT_CONFLICTS... could throw this in and test it anyways, but I'm pretty sure this can't happen without
  # a merge or rebase in progress
  GIT_CHANGED=5
  GIT_UNTRACKED=6
  GIT_STASHED=7

  assertGitPromptEquals '[00m[[01;35mmaster[00m ↓·2[00m↑·1[00m|[31m●3[00m[34m✚5[00m[36m…6[00m[01;34m⚑7[00m][00m'
}

test_local_only() {
  GIT_LOCAL_ONLY=1

  assertGitPromptEquals '[00m[[01;35mmaster[00m L[00m|[01;32m✔[00m][00m'
}

test_local_only_all_metrics() {
  GIT_AHEAD=1
  GIT_BEHIND=2
  GIT_STAGED=3
  GIT_CHANGED=5
  GIT_UNTRACKED=6
  GIT_STASHED=7
  GIT_LOCAL_ONLY=1

  assertGitPromptEquals '[00m[[01;35mmaster[00m L[00m ↓·2[00m↑·1[00m|[31m●3[00m[34m✚5[00m[36m…6[00m[01;34m⚑7[00m][00m'
}

test_merging() {
  GIT_MERGING=1
  GIT_CONFLICTS=1

  assertGitPromptEquals '[00m[[01;35mmaster[00m[01;35m|MERGING[00m[00m|[31m✖1[00m][00m'
}

test_merging_all_metrics() {
  GIT_MERGING=1

  GIT_AHEAD=1
  GIT_BEHIND=2
  GIT_STAGED=3
  GIT_CONFLICTS=4
  GIT_CHANGED=5
  GIT_UNTRACKED=6
  GIT_STASHED=7
  GIT_LOCAL_ONLY=1

  assertGitPromptEquals '[00m[[01;35mmaster[00m[01;35m|MERGING[00m[00m L[00m ↓·2[00m↑·1[00m|[31m●3[00m[31m✖4[00m[34m✚5[00m[36m…6[00m[01;34m⚑7[00m][00m'
}

test_rebasing() {
  GIT_BRANCH=:abc1234
  GIT_REBASE=3/10

  assertGitPromptEquals '[00m[[01;35m:abc1234[00m[01;35m|REBASE[00m 3/10[00m|[01;32m✔[00m][00m'
  # clean repo while rebasing can happen--for example, stopping at an `edit` during an interactive rebase
}

test_rebasing_all_metrics() {
  GIT_REBASE=2/7
  GIT_BRANCH=:abc1234

  GIT_STAGED=3
  GIT_CONFLICTS=4
  GIT_CHANGED=5
  GIT_UNTRACKED=6
  GIT_STASHED=7
  GIT_LOCAL_ONLY=1

  assertGitPromptEquals '[00m[[01;35m:abc1234[00m[01;35m|REBASE[00m 2/7[00m L[00m|[31m●3[00m[31m✖4[00m[34m✚5[00m[36m…6[00m[01;34m⚑7[00m][00m'
}

SHUNIT_PARENT="$0"
source test/common.zsh
