#!/bin/zsh -y

setUp() {
  clean_git_vars
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

SHUNIT_PARENT="$0"
source test/common.zsh
