#!/bin/bash

echoLine() {
	echo "==============================================="
}

isBaseDebian() {
	local OS=$1;

	if [[ $OS = "Debian" || $OS = "Ubuntu" || $OS = "Mint" ]]
	then
		echo "true";
	else
		echo "false";
	fi
}

isBaseCentOs() {
	local OS=$1;

	if [[ $OS = "CentOS" || $OS = "RedHat" || $OS = "Fedora" ]]
	then
		echo "true";
	else
		echo "false";
	fi
}

echoBeginInstall() {
	local OS=$1;

	echoLine;
    echo "Installing packages on $OS"
    echoLine;
}

echoErrorOsNotDetected() {
	echo "OS NOT DETECTED, couldn't install packages";
}

getOs() {
	local NAME=$(cat /etc/*release | grep ^NAME=);
	NAME=${NAME:5};
	echo `echo ${NAME} | awk '{print $1}' | sed 's/\"//g'`
}

install() {
	local PACKAGES=$1;
	local OS=$(getOs);

	if [[ $(isBaseDebian $OS) = "true" ]]
	then
		echoBeginInstall $OS;
	elif [[ $(isBaseCentOs $OS) = "true" ]]
	then
		echoBeginInstall $OS;
	else
		echoErrorOsNotDetected;
		exit 1;
	fi
}

# generation ssh key
genSsh() {
    mkdir -p ~/.ssh
    ssh-keygen
}

getPackages() {
	echo "apt-transport-https \
    ca-certificates \
    gnupg \
    gnupg2 \
    curl \
    software-properties-common \
    wget \
    make \
    build-essential \
    dirmngr \
    cpp \
    gpp \
    g++ \
    snap \
    snapd \
    dialog \
    devscripts \
    equivs \
    gdebi-core \
    libssl-dev \
    python3 \
    python3-setuptools \
    python3-software-properties \
    git \
    nano \
    htop \
    terminator \
    nautilus \
    default-jre"
}

addAliases() {
	if [ -f /etc/bashrc ] ; then
		{
			echo 'dc="docker-compose"'
			echo 'd="docker"'
		} > /etc/bashrc

		. /etc/bashrc
	fi
}