#!/usr/bin/env bash

set -e


#################################
#            BASE               #
#################################

BASHRC=~/.bashrc
ALIASES=~/.bash_aliases

apt-get install -y apt-transport-https \
		ca-certificates \
		curl \
		wget \
		make \
		build-essential \
		snapd \
		libssl-dev \
		neovim \
		htop

if ! [[ -f ${BASHRC} ]] ; then
    touch ${BASHRC}
fi

cat <<EOF >> ${ALIASES}

alias dev="cd ~/Dev"
alias devp="cd ~/Dev/projects"
alias devs="cd ~/Dev/sandbox"
alias dc="docker-compose"
alias d="docker"
alias ga="git add "
alias gb="git branch "
alias gc="git commit"
alias gcm="git commit -m "
alias gd="git diff"
alias gg="git checkout "
alias gst="git status "
alias gh="git cherry -v origin/master"
alias ghw="git cherry -v origin/master | wc -l"
alias g="git "
alias dprune="docker container prune && docker image prune && docker volume prune && docker network prune"
alias dclean="if ! [ -z $(docker ps -q) ]; then docker stop $(docker ps -q); fi && if ! [ -z $(docker ps -qa) ]; then docker rm $(docker ps -qa); fi && if ! [ -z $(docker images -q) ]; then docker rmi $(docker images -q) -f; fi"
EOF


#################################
#             GIT               #
#################################

apt-get install -y git

cat <<EOF >> ~/.gitconfig
[core]
    autocrlf = input
    safecrlf = true
    quotePath = off
[alias]
    f = fetch --all -p
    r = rebase
    st = status -sbu
    co = checkout
    ci = commit
    cp = commit --no-edit --amend
    br = branch
    ri = rebase -i
    cb = "!f() { BRANCH=`git rev-parse --abbrev-ref HEAD`; git commit -m \"$BRANCH $1\"; }; f"
    om = cherry -v origin/master
    lo = log --oneline
    bm = cherry -v HEAD origin/master
    lg = log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commits
    caa = "!f() { git add . && git commit --amend --no-edit && git push --force-with-lease; }; f"
    oml = "!f() { git cherry -v origin/master | wc -l; }; f"
    fush = push --force-with-lease
    hist = log --pretty=format:\"%h %ad | %s%d [%an]\" --graph --date=short
    type = cat-file -t
    dump = cat-file -p
    ldiff = diff origin/master
EOF

#################################
#          GIT-PROMT            #
#################################

git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1

cat <<EOF >> $BASHRC

if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
    GIT_PROMPT_ONLY_IN_REPO=1
    GIT_PROMPT_THEME=Single_line_Ubuntu
    source $HOME/.bash-git-prompt/gitprompt.sh
fi
EOF

#################################
#            DEV-ENV            #
#################################

DEV_DIR=~/Dev
SANDBOX_DIR=${DEV_DIR}/sandbox
PROJECTS_DOR=${DEV_DIR}/projects
TMP_DIR=${DEV_DIR}/tmp

if ! [[ -d ${SANDBOX_DIR} ]] ; then
    mkdir -p ${SANDBOX_DIR}
fi

if ! [[ -d ${PROJECTS_DOR} ]] ; then
    mkdir -p ${PROJECTS_DOR}
fi

if ! [[ -d ${TMP_DIR} ]] ; then
    mkdir -p ${TMP_DIR}
fi


#################################
#           BOOTSTRAP           #
#################################

git clone git@github.com:kolobok-kelbek/bootstrap.git ${SANDBOX_DIR}
pip3 install -r requirements.pip
python3 ./main.py
