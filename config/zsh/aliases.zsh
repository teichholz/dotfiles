alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias -- -='cd -'

alias q=exit
alias clr=clear
alias sudo='sudo '
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias wget='wget -c'
alias nr='sudo nixos-rebuild'
alias o=xdg-open
alias o='a -e xdg-open' # quick opening files with xdg-open
alias e='f -e nvim'
alias v='f -e nvim'
alias cat='bat'

alias y='xclip -selection clipboard -in'
alias p='xclip -selection clipboard -ou'

if command -v exa >/dev/null; then
  alias exa="exa --group-directories-first";
  alias l="exa -1";
  alias ll="exa -lg";
  alias la="LC_COLLATE=C exa -la";
fi

take() {
  mkdir -p "$1" && cd "$1";
}; compdef take=mkdir

ig() {
  $* &> /dev/null
}

org() {
  file=$(mktemp)
  p > $file
  pandoc --from mediawiki --to org $file | y
}

r() {
  local time=$1; shift;
  sleep "${time}m" && notify-send --urgency=critical 'Reminder:' "$@" > /dev/null &;
}; compdef r=sched
