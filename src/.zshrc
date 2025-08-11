# Rami's take on Luke's config for ZSH
export PATH="/sbin:$PATH"
export PATH="$HOME/.dotfiles/scripts/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/termux:$PATH"
export VISUAL=nvim
export EDITOR="$VISUAL"

# Dotfiles synchronisation
exec ~/.dotfiles/scripts/utils/dotfiles-sync.sh > ~/.sync-dotfiles.log 2>&1 &!

# Aliases
alias ls="ls --color=auto"
function ch() {
	cd ~/.dotfiles/notes
	target=`find -type f | fzf --query '/dev/null'`
	[ -z $target ] || nvim
}
alias g="git"
alias gac="git commit"

autoload -U colors && colors
#PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
PS1="$ "

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt appendhistory
setopt sharehistory

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
	if [[ ${KEYMAP} == vicmd ]] ||
	     [[ $1 = 'block' ]]; then
		echo -ne '\e[1 q'
	elif [[ ${KEYMAP} == main ]] ||
	     [[ ${KEYMAP} == viins ]] ||
	     [[ ${KEYMAP} = '' ]] ||
	     [[ $1 = 'beam' ]]; then
		echo -ne '\e[5 q'
	fi
}
zle -N zle-keymap-select; zle -N zle-line-init
autoload edit-command-line; zle -N edit-command-line

zle-line-init() {
	zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
	echo -ne "\e[5 q"
}
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

bindkey -s '^f' 'cd $(find ~ -type d | fzf)\n'

# Edit line in vim with ctrl-e:
bindkey '^e' edit-command-line

# Load zsh-syntax-highlighting; run last
#source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
