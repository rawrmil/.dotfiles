#!/bin/bash

#set -x

stow_flags="--ignore '\.templ$'"

# D E P E N D E N C I E S

# Default
zsh_chsh_path="/bin/zsh"

# Termux
if [ `echo $PREFIX | grep -o "com.termux"` ]; then
	zsh_chsh_path="zsh"
else
	stow_flags="$stow_flags --ignore .termux"
fi

# U T I L S

hascmd() {
	if command -v "$1" 2>&1 >/dev/null; then
		echo "[LOG] $1 is here..."
		return 0
	fi
	echo "[ERR] no '$1' command!"
	return 1
}

# P R O G R A M S

hascmd "nvim"
hascmd "tmux"
hascmd "fzf"

if hascmd "git"; then
	echo "[LOG] git setup..."
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
	git config --global alias.aliases 'config --get-regexp' 'alias'
fi

if hascmd "zsh" && [ `basename "$SHELL"` != "zsh" ]; then
	echo "[LOG] zsh setup..."
	chsh -s $zsh_chsh_path
fi

if hascmd "gh"; then
	if gh auth status > /dev/null; then
		echo "[LOG] gh already authorized..."
	else
		echo "[LOG] gh login..."
		gh auth login
	fi
fi

if hascmd "envsubst"; then
	echo "[LOG] envsubst the configs..."
	# should replace dpi but will just copy
	cd ~/.dotfiles
	find . -name "*.templ" -print0 | while IFS= read -r -d $'\0' file; do
		name="${file%.templ}"
		envsubst < "$file" > "$name"
	done
fi

if hascmd "stow"; then
	echo "Stow Flags: $stow_flags"
	cd ~/.dotfiles && stow src $stow_flags
fi
