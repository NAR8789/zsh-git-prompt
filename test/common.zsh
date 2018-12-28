# Source this file at the end of every test file. This handles common setup as well as sourcing shunit2
# NOTE: due to limitations of zsh < 5.0.7, caller must set `SHUNIT_PARENT="$0"` when sourcing (similar to when sourcing
# shunit2 directly)
# NOTE: this currently expects working directory to be the root of the repo

source zshrc.sh

source test/helpers/preview_git_status.zsh

assertGitPromptEquals() {
  assertEquals "$@" "$(print -P $(git_super_status))"
}

source test/shunit2/shunit2
