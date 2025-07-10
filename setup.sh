#!/bin/bash

#set -x

# D E P E N D E N C I E S

# Default
zsh_chsh_path="/bin/zsh"

# Termux
if [ `echo $PREFIX | grep -o "com.termux"` ]; then
	zsh_chsh_path="zsh"
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

if hascmd "zsh"; then
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

cd ~/.dotfiles
stow src
