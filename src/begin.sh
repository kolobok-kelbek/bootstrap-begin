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
		nano \
		htop

if ! [[ -f ${BASHRC} ]] ; then
    touch ${BASHRC}
fi

$(
    alias dev="cd ~/Dev"
    alias dc="docker-compose"
    alias d="docker"
    alias ga="git add "
    alias gb="git branch "
    alias gc="git commit"
    alias gcm="git commit -m "
    alias gd="git diff"
    alias go="git checkout "
    alias gst="git status "
    alias gh="git cherry -v origin/master"
    alias ghw="git cherry -v origin/master | wc -l"
    alias g="git "
    alias dclr="docker image prune && docker volume prune"
) >> ${ALIASES}


#################################
#             GIT               #
#################################

apt-get install -y git

$(
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
) >> ~/.gitconfig

$(
    GIT_PROMPT_ONLY_IN_REPO=1
    GIT_PROMPT_THEME=Single_line_Ubuntu
    source ~/.bash-git-prompt/gitprompt.sh
) >> $BASHRC


#################################
#            PYENV              #
#################################

PYENV=~/.pyenv
BASH_PYENV=~/.bash_pyenv

git clone https://github.com/pyenv/pyenv.git ${PYENV}

echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ${BASH_PYENV}
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ${BASH_PYENV}
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ${BASH_PYENV}


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