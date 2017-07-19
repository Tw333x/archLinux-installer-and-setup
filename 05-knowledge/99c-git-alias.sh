#!/bin/bash

# ----------------------------------------------------------------------
# Arch Linux :: Configuration
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archLinux-installer-and-setup

# ----------------------------------------------------------------------
# Git
# ----------------------------------------------------------------------
# Manually setup these two options
#git config --global user.email "your_email"
#git config --global user.name "your_name"
git config --global -l

# Store your password and specify the time on cache
git config --global credential.helper cache
git config --global credential.helper "cache --timeout=3600" # 1 hour

# Store your credentials
git config credential.helper store

# Create alias to write easy command like git cm thats means git commit -m
# These configurations will be save in this file ~/.gitconfig
git config --global --remove-section alias

git config --global alias.ad '! git add "$@" && echo -e "" && echo -e "" && git status'
git config --global alias.adp '! git add -p "$@" && echo -e "" && echo -e "" && git status'
git config --global alias.alias "! git config --get-regexp ^alias\. | sed -e s/^alias\.// -e s/\ /\ =\ /"
git config --global alias.br 'branch'
git config --global alias.cm '! git commit -m "$@" && echo -e "" && echo -e "" && git status'
git config --global alias.cma '! git commit -a -m "$@" && echo -e "" && echo -e "" && git status'
git config --global alias.cmamend '! git commit --amend && echo -e "" && echo -e "" && git status'
git config --global alias.co '! git checkout "$@" && echo -e "" && echo -e "" && git status'
git config --global alias.cob '! git checkout -b "$@" && echo -e "" && echo -e "" && git status'
git config --global alias.com '! git checkout master && echo -e "" && echo -e "" && git status'
git config --global alias.cos 'checkout -'
git config --global alias.df 'diff'
git config --global alias.dfc 'diff --cached'
git config --global alias.dfs 'diff --stat'
git config --global alias.lg 'log'
git config --global alias.lglast 'log -1 HEAD'
git config --global alias.lgp 'log --pretty=format:"%C(yellow)%h\\ %ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=short'
git config --global alias.lgwho 'shortlog -s --'
git config --global alias.pl '! git pull && echo -e "" && echo -e "" && git status'
git config --global alias.ps '! git push && echo -e "" && echo -e "" && git status'
git config --global alias.st 'status'
git config --global alias.sts 'status -s'
git config --global alias.un 'reset HEAD --'