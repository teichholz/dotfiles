bindkey -M viins '^a' beginning-of-line
bindkey -M viins '^e' end-of-line

bindkey -M viins '^b' backward-word
bindkey -M viins '^f' forward-word

bindkey -M vicmd '^k' kill-line
bindkey -M vicmd '^u' backward-kill-line

bindkey -M vicmd 'H'  run-help

# Up arrow:
bindkey '\e[A' history-substring-search-up
bindkey '\eOA' history-substring-search-up
# Down arrow:
bindkey '\e[B' history-substring-search-down
bindkey '\eOB' history-substring-search-down

# C-z to toggle current process (background/foreground)
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# Vim's C-x C-l in zsh
history-beginning-search-backward-then-append() {
  zle history-beginning-search-backward
	zle vi-add-eol
}
zle -N history-beginning-search-backward-then-append
bindkey -M viins '^x^l' history-beginning-search-backward-then-append

# FZF
bindkey '^T' fzf-file-widget
bindkey '^R' fzf-history-widget

# FASD
bindkey '^X^A' fasd-complete
bindkey '^X^F' fasd-complete-f
bindkey '^X^D' fasd-complete-d

# goto argument
bindkey '^[1' beginning-of-line
bindkey -s '^[2' '^A^F'
bindkey -s '^[3' '^A^F^F'
bindkey -s '^[4' '^A^F^F^F'
bindkey -s '^[5' '^A^F^F^F^F'
bindkey -s '^[6' '^A^F^F^F^F^F'
bindkey -s '^[7' '^A^F^F^F^F^F^F'
bindkey -s '^[8' '^A^F^F^F^F^F^F^F'

# vim with fzf
bindkey -s '^V' 'nvim $(fzf)^M'
