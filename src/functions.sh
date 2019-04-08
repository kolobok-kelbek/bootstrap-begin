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
			co = checkout
			ci = commit
			st = status
			br = branch
			hist = log —pretty=format:\"%h %ad | %s%d [%an]\" —graph —date=short
			type = cat-file -t
			dump = cat-file -p
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
