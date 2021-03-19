#!/usr/bin/env zsh

alias e='emacsclient'
ediff() { e --eval "(ediff-files \"$1\" \"$2\")"; }
