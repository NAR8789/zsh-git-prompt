# these live outside of test/common.zsh so preview_git_super_status.sh can also use them

clean_git_vars() {
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
