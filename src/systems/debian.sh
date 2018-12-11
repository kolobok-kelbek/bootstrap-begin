#!/usr/bin/env bash

# set default repositories in sources.list
setSources() {
    {
        echo 'deb http://security.debian.org/ stretch/updates main non-free'
        echo 'deb-src http://security.debian.org/ stretch/updates main non-free'
        echo ''
        echo 'deb http://mirror.yandex.ru/debian stretch main non-free'
        echo 'deb-src http://mirror.yandex.ru/debian stretch main non-free'
        echo ''
        echo 'deb http://mirror.yandex.ru/debian stretch-updates main non-free'
        echo 'deb-src http://mirror.yandex.ru/debian stretch-updates main non-free'
        echo ''
        echo 'deb http://mirror.yandex.ru/debian/ stretch-proposed-updates main non-free contrib non-free'
        echo 'deb-src http://mirror.yandex.ru/debian/ stretch-proposed-updates main non-free contrib'
    } > /etc/apt/sources.list
}

updateBaseDebianSystem() {
    echo "apt-get update && apt-get -y upgrade";
}

installBaseDebianSystem() {
    echo "apt-get install -y";
}

getDebianPackeges() {
    echo "firmware-iwlwifi";
}

