#!/usr/bin/env zsh

function e() {
  ig emacs $* &
}

ediff() { e --eval "(ediff-files \"$1\" \"$2\")"; }
