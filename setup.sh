#!/bin/bash

#set -x

stow_ignore=

# D E P E N D E N C I E S

# Default
zsh_chsh_path="/bin/zsh"

# Termux
if [ `echo $PREFIX | grep -o "com.termux"` ]; then
	zsh_chsh_path="zsh"
	stow_flags="--ignore .termux "
fi

# U T I L S

hascmd() {
	if command -v "$1" 2>&1 >/dev/null; then
		echo "[LOG] neovim is here..."
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

if hascmd "startx"; then
	stow_flags="--ignore .termux"
fi

if hascmd "envsubst"; then
	echo "[LOG] envsubst the configs..."
	# should replace dpi but will just copy
fi

echo "Stow Flags: $stow_flags"
cd ~/.dotfiles && stow src $stow_flags
