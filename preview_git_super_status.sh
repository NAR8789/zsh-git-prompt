preview_git_super_status() {
  (
    source "$__GIT_PROMPT_DIR/test/helpers/preview_git_status.zsh"

    show_git_prompt() {
      print -P "$1$(git_super_status)"
    }

    clean_git_vars
    show_git_prompt "clean:\t\t\t\t"

    clean_git_vars
    GIT_AHEAD=1
    GIT_BEHIND=2
    GIT_STAGED=3
    GIT_CHANGED=5
    GIT_UNTRACKED=6
    GIT_STASHED=7
    show_git_prompt "basic metrics:\t\t\t"

    clean_git_vars
    GIT_LOCAL_ONLY=1
    show_git_prompt "local only:\t\t\t"

    clean_git_vars
    GIT_AHEAD=1
    GIT_BEHIND=2
    GIT_STAGED=3
    GIT_CHANGED=5
    GIT_UNTRACKED=6
    GIT_STASHED=7
    GIT_LOCAL_ONLY=1
    show_git_prompt "local only, with metrics:\t"

    clean_git_vars
    GIT_MERGING=1
    GIT_CONFLICTS=1
    show_git_prompt "merging:\t\t\t"

    clean_git_vars
    GIT_MERGING=1
    GIT_AHEAD=1
    GIT_BEHIND=2
    GIT_STAGED=3
    GIT_CONFLICTS=4
    GIT_CHANGED=5
    GIT_UNTRACKED=6
    GIT_STASHED=7
    GIT_LOCAL_ONLY=1
    show_git_prompt "merging, with metrics:\t\t"

    clean_git_vars
    GIT_BRANCH=:abc1234
    GIT_REBASE=3/10
    show_git_prompt "rebasing:\t\t\t"

    clean_git_vars
    GIT_REBASE=2/7
    GIT_BRANCH=:abc1234
    GIT_STAGED=3
    GIT_CONFLICTS=4
    GIT_CHANGED=5
    GIT_UNTRACKED=6
    GIT_STASHED=7
    show_git_prompt "rebasing, with metrics:\t\t"
  )
}

# vim: set filetype=zsh:
