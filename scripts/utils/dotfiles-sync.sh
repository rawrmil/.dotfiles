#/bin/bash
cd ~/.dotfiles
echo "[ dotfiles-sync.sh ] BEGIN"
git pull --rebase
git add .
git commit -m "Auto-sync $(date)" || true
git push
echo "[ dotfiles-sync.sh ] END"
