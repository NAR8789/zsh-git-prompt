#!/bin/zsh -y

source preview_git_super_status.sh

test_default_theme() {
  read -r -d '' EXPECTED_PREVIEW <<EXPECTED_PREVIEW
clean:				[00m[[01;35mmaster[00m|[01;32m✔[00m][00m
basic metrics:			[00m[[01;35mmaster[00m ↓·2[00m↑·1[00m|[31m●3[00m[34m✚5[00m[36m…6[00m[01;34m⚑7[00m][00m
local only:			[00m[[01;35mmaster[00m L[00m|[01;32m✔[00m][00m
local only, with metrics:	[00m[[01;35mmaster[00m L[00m ↓·2[00m↑·1[00m|[31m●3[00m[34m✚5[00m[36m…6[00m[01;34m⚑7[00m][00m
merging:			[00m[[01;35mmaster[00m[01;35m|MERGING[00m[00m|[31m✖1[00m][00m
merging, with metrics:		[00m[[01;35mmaster[00m[01;35m|MERGING[00m[00m L[00m ↓·2[00m↑·1[00m|[31m●3[00m[31m✖4[00m[34m✚5[00m[36m…6[00m[01;34m⚑7[00m][00m
rebasing:			[00m[[01;35m:abc1234[00m[01;35m|REBASE[00m 3/10[00m|[01;32m✔[00m][00m
rebasing, with metrics:		[00m[[01;35m:abc1234[00m[01;35m|REBASE[00m 2/7[00m|[31m●3[00m[31m✖4[00m[34m✚5[00m[36m…6[00m[01;34m⚑7[00m][00m
merging, with show_upstream:	[00m[[01;35mmaster[00m[01;35m|MERGING[00m[00m {[34morigin[00m}[00m ↓·2[00m↑·1[00m|[31m●3[00m[31m✖4[00m[34m✚5[00m[36m…6[00m[01;34m⚑7[00m][00m
EXPECTED_PREVIEW
  assertPreviewEquals "$EXPECTED_PREVIEW"
}

test_retheme() {
  ZSH_THEME_GIT_PROMPT_BEHIND="↓"
  ZSH_THEME_GIT_PROMPT_AHEAD="↑"
  ZSH_THEME_GIT_PROMPT_LOCAL='L'
  ZSH_GIT_PROMPT_SHOW_UPSTREAM=2
  ZSH_THEME_GIT_PROMPT_UPSTREAM_FRONT="%{$fg_bold[blue]%}"
  ZSH_THEME_GIT_PROMPT_UPSTREAM_END="%{${reset_color}%}"
  ZSH_THEME_GIT_PROMPT_MERGING="%{$fg_bold[yellow]%}MERGE"
  ZSH_THEME_GIT_PROMPT_REBASE="%{$fg_bold[yellow]%}REBASE "
  ZSH_THEME_GIT_PROMPT='(${(j:|:)${(s:|:)${:-$branch|$upstream|$merge_or_rebase|$behind$ahead$staged$conflicts$changed$untracked$stashed$clean}}})'

  read -r -d '' EXPECTED_PREVIEW <<EXPECTED_PREVIEW
clean:				[00m([01;35mmaster[00m|[01;32m✔[00m)[00m
basic metrics:			[00m([01;35mmaster[00m|↓2[00m↑1[00m[31m●3[00m[34m✚5[00m[36m…6[00m[01;34m⚑7[00m)[00m
local only:			[00m([01;35mmaster[00m|L[00m|[01;32m✔[00m)[00m
local only, with metrics:	[00m([01;35mmaster[00m|L[00m|↓2[00m↑1[00m[31m●3[00m[34m✚5[00m[36m…6[00m[01;34m⚑7[00m)[00m
merging:			[00m([01;35mmaster[00m|[01;33mMERGE[00m|[31m✖1[00m)[00m
merging, with metrics:		[00m([01;35mmaster[00m|L[00m|[01;33mMERGE[00m|↓2[00m↑1[00m[31m●3[00m[31m✖4[00m[34m✚5[00m[36m…6[00m[01;34m⚑7[00m)[00m
rebasing:			[00m([01;35m:abc1234[00m|[01;33mREBASE 3/10[00m|[01;32m✔[00m)[00m
rebasing, with metrics:		[00m([01;35m:abc1234[00m|[01;33mREBASE 2/7[00m|[31m●3[00m[31m✖4[00m[34m✚5[00m[36m…6[00m[01;34m⚑7[00m)[00m
merging, with show_upstream:	[00m([01;35mmaster[00m|[01;34morigin[00m[00m|[01;33mMERGE[00m|↓2[00m↑1[00m[31m●3[00m[31m✖4[00m[34m✚5[00m[36m…6[00m[01;34m⚑7[00m)[00m
EXPECTED_PREVIEW
  assertPreviewEquals "$EXPECTED_PREVIEW"
}

assertPreviewEquals() {
  assertEquals "$1" "$(preview_git_super_status)"
}

setUp() {
  unset ZSH_GIT_PROMPT_SHOW_UPSTREAM

  # reset all theme vars
  ZSH_THEME_GIT_PROMPT_PREFIX="["
  ZSH_THEME_GIT_PROMPT_SUFFIX="]"
  ZSH_THEME_GIT_PROMPT_HASH_PREFIX=":"
  ZSH_THEME_GIT_PROMPT_SEPARATOR="|"
  ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_bold[magenta]%}"
  ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[red]%}%{●%G%}"
  ZSH_THEME_GIT_PROMPT_CONFLICTS="%{$fg[red]%}%{✖%G%}"
  ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg[blue]%}%{✚%G%}"
  ZSH_THEME_GIT_PROMPT_BEHIND="%{↓·%2G%}"
  ZSH_THEME_GIT_PROMPT_AHEAD="%{↑·%2G%}"
  ZSH_THEME_GIT_PROMPT_STASHED="%{$fg_bold[blue]%}%{⚑%G%}"
  ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%}%{…%G%}"
  ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}%{✔%G%}"
  ZSH_THEME_GIT_PROMPT_LOCAL=" L"
  ZSH_THEME_GIT_PROMPT_UPSTREAM_FRONT=" {%{$fg[blue]%}"
  ZSH_THEME_GIT_PROMPT_UPSTREAM_END="%{${reset_color}%}}"
  ZSH_THEME_GIT_PROMPT_MERGING="%{$fg_bold[magenta]%}|MERGING%{${reset_color}%}"
  ZSH_THEME_GIT_PROMPT_REBASE="%{$fg_bold[magenta]%}|REBASE%{${reset_color}%} "
  ZSH_THEME_GIT_PROMPT='$ZSH_THEME_GIT_PROMPT_PREFIX$branch$merge_or_rebase$upstream${${:-$behind$ahead}:+ }$behind$ahead$ZSH_THEME_GIT_PROMPT_SEPARATOR$staged$conflicts$changed$untracked$stashed$clean$ZSH_THEME_GIT_PROMPT_SUFFIX'
}

SHUNIT_PARENT="$0"
source test/common.zsh
