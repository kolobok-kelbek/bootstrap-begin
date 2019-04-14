#!/bin/bash

BASHRC="~/.bashrc"

installDefaultUtilsAndTools () {
	apt-get install -y apt-transport-https \
		ca-certificates \
		curl \
		wget \
		make \
		build-essential \
		snapd \
		libssl-dev \
		python3 \
		python3-setuptools \
		python3-software-properties \
		git \
		nano \
		htop \
		terminator \
		nautilus
}

# generation ssh key
genSsh () {
    mkdir -p ~/.ssh
    ssh-keygen
}

addAliases() {
	if [ -f $BASHRC ] ; then
		$(
			alias dc="docker-compose"
			alias d="docker"
			alias dc="docker-compose"
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
		 ) >> $BASHRC

		. $BASHRC
	else
		echo "Problem! Dir $BASHRC not found!"
	fi
}

installOpenJDK () {
	sudo add-apt-repository ppa:openjdk-r/ppa \
		&& sudo apt-get update -q \
		&& sudo apt install -y openjdk-11-jdk
}

installGitWithTools () {
	sudo apt-get install -y git

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
			hist = log —pretty=format:\"%h %ad | %s%d [%an]\" —graph —date=short
			type = cat-file -t
			dump = cat-file -p
			ldiff = diff origin/master
	) >> ~/.gitconfig

	$(
		GIT_PROMPT_ONLY_IN_REPO=1
		GIT_PROMPT_THEME=Single_line_Ubuntu
		source ~/.bash-git-prompt/gitprompt.sh
	 ) >> $BASHRC
}

installDockerWithTools () {

	# install dry
	curl -sSf https://moncho.github.io/dry/dryup.sh | sudo sh
	sudo chmod 755 /usr/local/bin/dry
}

installPythonWithTools () {

}
