#
# ~/.bashrc
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#==========ENVVARs==========
export EDITOR=/usr/bin/vim
export TERM=xterm-256color

#=========DOFILES===========
alias dotfiles='/usr/bin/git --git-dir=$HOME/Proyectos/.dotfiles/ --work-tree=$HOME'

#======ALIAS Y COLORS=======
alias ls='ls --color=auto --group-directories-first -F -h --time-style=+"%d.%m.%Y %H:%M"'
alias ll='ls -l'
alias la='ls -A'
alias grep='grep --color=auto'
man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
        LESS_TERMCAP_me=$'\e[0m' \
        LESS_TERMCAP_se=$'\e[0m' \
        LESS_TERMCAP_so=$'\e[01;44;33m' \
        LESS_TERMCAP_ue=$'\e[0m' \
        LESS_TERMCAP_us=$'\e[01;32m' \
        command man "$@"
}


#===========PROMPT==========
BLUE="\033[1;34m"
ORANGE="\033[1;33m"
GREEN="\033[1;32m"
PURPLE="\033[1;35m"
GREY="\033[1;30m"
RED="\033[1;31m"
BOLD=""
RESET="\033[m"

# Git branch details
function parse_git_dirty() {
	[[ $(git status 2> /dev/null | tail -n1) != *"working directory clean"* ]] && echo "*"
}
function parse_git_branch() {
	git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

symbol="• "
symbol2="❯ "
exstatus(){
    if [ $? == 0 ]
    then
        echo -e "$GREEN"
    else
        echo -e "$RED"
    fi
}

#export PS1="\n$exstatus.\[$BLUE\]\u\[$GREY\]@\h \[$RESET\]in \[$GREEN\]\w\[$RESET\]\$([[ -n \$(git branch 2> /dev/null) ]] && echo \" on \")\[$PURPLE\]\$(parse_git_branch)\[$RED\]\n$symbol\[$RESET\]"
export PS1="\n\$(exstatus)\$symbol\[$BLUE\]\u\[$GREY\]@\h \[$RESET\]in \[$GREEN\]\w\[$RESET\]\$([[ -n \$(git branch 2> /dev/null) ]] && echo \" on \")\[$PURPLE\]\$(parse_git_branch)\n\[$ORANGE\]\$symbol2\[$RESET\]"
export PS2="\[$ORANGE\]→ \[$RESET\]"

# Only show the current directory's name in the tab
export PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}\007"'