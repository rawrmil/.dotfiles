#!/bin/sh
cd ~/.dotfiles || exit 1
echo "[ dotfiles-sync.sh ] BEGIN"
git pull --no-rebase
git add .
git commit -m "Auto-sync $(date)" || true
git push
echo "[ dotfiles-sync.sh ] END"
