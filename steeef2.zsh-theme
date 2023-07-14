# prompt style and colors based on Steve Losh's Prose theme:
# https://github.com/sjl/oh-my-zsh/blob/master/themes/prose.zsh-theme
#
# vcs_info modifications from Bart Trojanowski's zsh prompt:
# http://www.jukie.net/bart/blog/pimping-out-zsh-prompt
#
# git untracked files modification from Brian Carper:
# https://briancarper.net/blog/570/git-info-in-your-zsh-prompt

export VIRTUAL_ENV_DISABLE_PROMPT=1

function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo %{$brightpink%}'('`basename $VIRTUAL_ENV`')'
}
PR_GIT_UPDATE=1

setopt prompt_subst

autoload -U add-zsh-hook
autoload -Uz vcs_info

#use extended color palette if available
if [[ $terminfo[colors] -ge 256 ]]; then
    turquoise="%F{81}"
    orange="%F{208}"
    purple="%F{135}"
    hotpink="%F{161}"
    hotred="%F{1}"
    brightpink="%F{163}"
    limegreen="%F{118}"
    green="%F{28}"
    brightyellow="%F{191}"
    white="%F{7}"
else
    turquoise="%F{cyan}"
    orange="%F{yellow}"
    purple="%F{magenta}"
    hotpink="%F{red}"
    hotred="%F{red}"
    brightpink="%F{red}"
    limegreen="%F{green}"
    green="%F{green}"
    brightyellow="%F{yellow}"
    white="%F{white}"
fi

# enable VCS systems you use
zstyle ':vcs_info:*' enable git svn

# check-for-changes can be really slow.
# you should disable it, if you work with large repositories
zstyle ':vcs_info:*:prompt:*' check-for-changes true

# set formats
# %b - branchname
# %u - unstagedstr (see below)
# %c - stagedstr (see below)
# %a - action (e.g. rebase-i)
# %R - repository path
# %S - path in the repository
PR_RST="%f"
FMT_BRANCH="(%{$turquoise%}%b%u%c${PR_RST})"
FMT_ACTION="(%{$white%}%a${PR_RST})"
FMT_UNSTAGED="%{$green%}●"
FMT_STAGED="%{$orange%}●"

zstyle ':vcs_info:*:prompt:*' unstagedstr   "${FMT_UNSTAGED}"
zstyle ':vcs_info:*:prompt:*' stagedstr     "${FMT_STAGED}"
zstyle ':vcs_info:*:prompt:*' actionformats "${FMT_BRANCH}${FMT_ACTION}"
zstyle ':vcs_info:*:prompt:*' formats       "${FMT_BRANCH}"
zstyle ':vcs_info:*:prompt:*' nvcsformats   ""


function steeef_preexec {
    case "$2" in
        *git*)
            PR_GIT_UPDATE=1
            ;;
        *hub*)
            PR_GIT_UPDATE=1
            ;;
        *svn*)
            PR_GIT_UPDATE=1
            ;;
    esac
}
add-zsh-hook preexec steeef_preexec

function steeef_chpwd {
    PR_GIT_UPDATE=1
}
add-zsh-hook chpwd steeef_chpwd

function steeef_precmd {
    # (( spare_width = ${COLUMNS} ))
    space="   "
    # user_machine_size=${#${(%):-%n@%m : }}
    # path_size=${#PWD}
    # branch=$(git_current_branch)
    # branch_size=${#branch}
    # (( spare_width = ${spare_width} - (${user_machine_size} + ${path_size} + ${branch_size}) ))
    # while [ ${#space} -lt $spare_width ]; do
    #     space=" $space"
    # done

    if [[ -n "$PR_GIT_UPDATE" ]] ; then
        # check for untracked files or updated submodules, since vcs_info doesn't
        if git ls-files --other --exclude-standard 2> /dev/null | grep -q "."; then
            PR_GIT_UPDATE=1
            FMT_BRANCH="%{$brightyellow%}<< %b%u%c%{$hotred%}● %{$brightyellow%}>>${PR_RST}"
        else
            FMT_BRANCH="%{$brightyellow%}<< %b%u%c %{$brightyellow%}>>${PR_RST}"
        fi

        zstyle ':vcs_info:*:prompt:*' formats "${space}${FMT_BRANCH} "

        vcs_info 'prompt'
        PR_GIT_UPDATE=
    fi
}
add-zsh-hook precmd steeef_precmd

# PROMPT=$'%{$purple%}%n${PR_RST} at %{$orange%}%m${PR_RST} in %{$limegreen%}%~${PR_RST} $vcs_info_msg_0_$(virtualenv_info)$ '
PROMPT=$'
%{$white%}╭─ %D - %*
%{$white%}├  %F{blue}%n${PR_RST}@%{$purple%}%m${PR_RST} : %{$turquoise%}%~${PR_RST}  $vcs_info_msg_0_
%{$white%}╰─≻≻ $(virtualenv_info)%f $ '
