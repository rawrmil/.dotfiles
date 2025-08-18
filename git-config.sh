#!/bin/sh

git config --global user.name "Ramil Khasanshin"
git config --global user.email "khasanshin.ramil@list.ru"
git config --global alias.a 'add'
git config --global alias.aa 'add --all'
git config --global alias.r 'rm --cached'
git config --global alias.unstage 'reset --soft HEAD~1'
git config --global alias.l 'log --oneline --graph --decorate'
git config --global alias.s 'status'
git config --global alias.p 'push'
git config --global alias.pn 'push --no-verify'
git config --global alias.c 'commit'
git config --global alias.cl 'clone'
git config --global alias.aliases 'config --get-regexp "^alias"'
git config --global credential.helper 'store'
