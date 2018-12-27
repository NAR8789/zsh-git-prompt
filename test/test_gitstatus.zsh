#!/bin/zsh -y

. ./zshrc.sh

test_show_upstream_unset() {
  unset ZSH_GIT_PROMPT_SHOW_UPSTREAM
  GIT_BRANCH=master
  GIT_UPSTREAM=origin/master

  assertGitPromptEquals '[00m[[01;35mmaster[00m|[01;32m✔[00m][00m'
}

test_show_upstream_0() {
  ZSH_GIT_PROMPT_SHOW_UPSTREAM=0
  GIT_BRANCH=master
  GIT_UPSTREAM=origin/master

  assertGitPromptEquals '[00m[[01;35mmaster[00m|[01;32m✔[00m][00m'
}

test_show_upstream_1() {
  ZSH_GIT_PROMPT_SHOW_UPSTREAM=1
  GIT_BRANCH=master
  GIT_UPSTREAM=origin/master

  assertGitPromptEquals '[00m[[01;35mmaster[00m {[34morigin/master[00m}[00m|[01;32m✔[00m][00m'
}

test_show_upstream_2() {
  ZSH_GIT_PROMPT_SHOW_UPSTREAM=2
  GIT_BRANCH=master
  GIT_UPSTREAM=origin/master

  assertGitPromptEquals '[00m[[01;35mmaster[00m {[34morigin[00m}[00m|[01;32m✔[00m][00m'
}

test_show_upstream_2_mismatched_upstream() {
  ZSH_GIT_PROMPT_SHOW_UPSTREAM=2
  GIT_BRANCH=foo
  GIT_UPSTREAM=origin/bar

  assertGitPromptEquals '[00m[[01;35mfoo[00m {[34morigin/bar[00m}[00m|[01;32m✔[00m][00m'
}

test_show_upstream_2_slashy_branch_name() {
  ZSH_GIT_PROMPT_SHOW_UPSTREAM=2
  GIT_BRANCH=feature/foo
  GIT_UPSTREAM=origin/feature/foo

  assertGitPromptEquals '[00m[[01;35mfeature/foo[00m {[34morigin[00m}[00m|[01;32m✔[00m][00m'
}

test_show_upstream_2_slashy_branch_name_mismatched_upstream() {
  ZSH_GIT_PROMPT_SHOW_UPSTREAM=2
  GIT_BRANCH=feature/foo
  GIT_UPSTREAM=origin/feature/bar

  assertGitPromptEquals '[00m[[01;35mfeature/foo[00m {[34morigin/feature/bar[00m}[00m|[01;32m✔[00m][00m'
}

test_show_upstream_2_slashy_branch_name_suffix_of_upstream() {
  # Since we're using suffix removal to shorten a branch name down to an upstream name, this test
  # checks to make sure we actually get all the way down to a remote, rather than a remote plus some
  # prefix of a branch name

  ZSH_GIT_PROMPT_SHOW_UPSTREAM=2
  GIT_BRANCH=foo
  GIT_UPSTREAM=origin/feature/foo

  assertGitPromptEquals '[00m[[01;35mfoo[00m {[34morigin/feature/foo[00m}[00m|[01;32m✔[00m][00m'
}

assertGitPromptEquals() {
  assertEquals "$@" "$(print -P $(git_super_status))"
}

setUp() {
  # set some default "sane" values here so in indiviudal tests so we can just set the ones we care about
  GIT_BRANCH=master
  GIT_AHEAD=0
  GIT_BEHIND=0
  GIT_STAGED=0
  GIT_CONFLICTS=0
  GIT_CHANGED=0
  GIT_UNTRACKED=0
  GIT_STASHED=0
  GIT_LOCAL_ONLY=0
  GIT_UPSTREAM=origin/master
  GIT_MERGING=0
  GIT_REBASE=0

  unset ZSH_GIT_PROMPT_SHOW_UPSTREAM
}

# mock: avoid running gitstatus.py, and just update __CURRENT_GIT_STATUS to match the various individual status vars
update_current_git_vars() {
  __CURRENT_GIT_STATUS=(
    "$GIT_BRANCH"
    "$GIT_AHEAD"
    "$GIT_BEHIND"
    "$GIT_STAGED"
    "$GIT_CONFLICTS"
    "$GIT_CHANGED"
    "$GIT_UNTRACKED"
    "$GIT_STASHED"
    "$GIT_LOCAL_ONLY"
    "$GIT_UPSTREAM"
    "$GIT_MERGING"
    "$GIT_REBASE"
  )
}

SHUNIT_PARENT="$0"
. ./test/shunit2/shunit2
