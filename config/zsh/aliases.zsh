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
alias ls=exa
alias l=exa
alias cat=bat
alias o=xdg-open
alias aliaser="source aliaser"

alias y='xclip -selection clipboard -in'
alias p='xclip -selection clipboard -ou'

alias spanish='chromium --new-window https://www.duolingo.com/learn https://www.spanishdict.com/translation https://espanol.lingolia.com/de/grammatik/zeitformen & > /dev/null'

if command -v exa >/dev/null; then
  alias exa="exa --group-directories-first";
  alias l="exa -1";
  alias ll="exa -lg";
  alias la="LC_COLLATE=C exa -la";
fi

cat() {
  filename=$(basename "$1")
  extension="${filename##*.}"
  filename="${filename%.*}"
  CAT=bat

  if [ $extension -eq "md" ]; then
    if command -v mdcat >/dev/null; then
      CAT=mdcat
    fi
  fi

  ${CAT} "$1"
};




take() {
  mkdir "$1" && cd "$1";
}; compdef take=mkdir

r() {
  local time=$1; shift;
  sleep "${time}m" && notify-send --urgency=critical 'Reminder:' "$@" > /dev/null &;
}; compdef r=sched
