# Source this file at the end of every test file. This handles common setup as well as sourcing shunit2

# NOTE: this currently expects working directory to be the root of the repo

source zshrc.sh

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

SHUNIT_PARENT="$(setopt POSIX_ARGZERO; echo $0)"
source test/shunit2/shunit2
