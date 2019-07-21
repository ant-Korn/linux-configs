#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#if which tmux >/dev/null 2>&1; then
#if not inside a tmux session, and if no session is started, start a new session
#    test -z "$TMUX" && (tmux attach || ./scripts/tmux_start.sh)
#fi

alias ls='ls --color=auto'
#PS1='[\u@\h \W]\$ '
PS1='\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[1;37m\]'
#PS1="[\[\e[7;92m\]\u\[\e[7;93m\]\W\]\[\e[7;95m\]$\[\e[0m\]] "
#PS1="\[\033[01;37m\]\$? \$(if [[ \$? == 0 ]]; then echo \"\[\033[01;32m\];)\"; else echo \"\[\033[01;31m\];(\"; fi) $(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]\h'; else echo '\[\033[01;32m\]\u@\h'; fi)\[\033[01;34m\] \w \$\[\033[00m\] "
#PROMPT_COMMAND='es=$?; [[ $es -eq 0 ]] && unset error || error=$(echo -e "\e[1;41m $es \e[40m")'
#PS1="${error} ${PS1}"

export LESS=-R
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

export EDITOR=vim

man() {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[38;5;246m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[04;38;5;146m' \
    man "$@"
}


# System
alias winmnt="sudo mount /mnt/win"
alias winunm="sudo umount /mnt/win"
alias flashmnt="sudo mount /mnt/flash"
alias flashunm="sudo umount /mnt/flash"
alias sdn="shutdown now"
alias progs="(pacman -Qet && pacman -Qm) | sort -u" # List programs I've installed
alias nf="clear && neofetch"

# Settings
alias vs="vim ~/.vimrc"
alias bs="vim ~/.bashrc"
alias is="vim ~/.config/i3/config"

# Programms
alias cond="source /opt/anaconda/bin/activate root"
alias dcond="source /opt/anaconda/bin/deactivate root"
alias ll="ls -lh"
alias v="vim"
alias r="ranger"
alias msc="ncmpcpp"
alias stream="streamlink --hls-segment-threads 2 -p mpv"
alias pclean="profile-cleaner"

# stream recording to mp4 format
function record() {
    if [ -z "$1" ] || [ -z "$2" ]; then
        echo "Usage: ${FUNCNAME[0]} [URL] [filename]";
        return 1;
    fi
    streamlink --hls-segment-threads 3 -O $1 best | tee >(ffmpeg -i pipe:0 -c copy -bsf:a aac_adtstoasc -f mp4 -movflags empty_moov+separate_moof+frag_keyframe $2.mp4)  | mpv -
}
alias torref="~/scripts/tor_new_identity.py"

# Moves
alias p="cd ~/projects && pwd && ll"
alias pt="cd ~/projects/tex_proj && pwd && ll"
alias cfg="cd ~/my_configs/linux-configs && pwd && ll -a"


ranger() {
    if [ -z "$RANGER_LEVEL" ]; then
        /usr/bin/ranger "$@"
    else
        exit
    fi
}

