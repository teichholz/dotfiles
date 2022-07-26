function _cache {
	(( $+commands[$1] )) || return 1
	local cache_dir="$XDG_CACHE_HOME/${SHELL##*/}"
	local cache="$cache_dir/$1"
	if [[ ! -f $cache || ! -s $cache ]]; then
		echo "Caching $1"
		mkdir -p $cache_dir
		"$@" >$cache
		chmod 600 $cache
	fi
	if [[ -o interactive ]]; then
		source $cache || rm -f $cache
	fi
}

function _source {
  for file in "$@"; do
    [ -r $file ] && source $file
  done
}

_source $ZDOTDIR/.p10k.zsh
