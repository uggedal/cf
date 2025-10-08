# shellcheck shell=sh disable=SC3043

CF_TMPDIR="$(mktemp -d)"

cleanup() {
	rm -rf "$CF_TMPDIR"
}

trap cleanup EXIT

link() {
	local src_fname="$1"
	local target="$2"

	if [ -h "$target" ]; then
		return
	fi

	if [ -f "$target" ]; then
		printf 'Existing normal file: %s\n' "$target"
		rm -i "$target"
	fi

	mkdir -p "$(dirname "$target")"
	ln -vs "$ROOT/files/$src_fname" "$target"
}

_diff() {
	local a="$1"
	local b="$2"

	if ! sudo test -e "$a"; then
		a=/dev/null
	fi

	sudo git --no-pager diff --no-index "$a" "$b" || :
}

_copy() {
	local src="$1"
	local dest="$2"

	if cmp -s "$dest" "$src"; then
		return
	fi

	_diff "$dest" "$src"

	case "$dest" in
	/home/* | /Users/*)
		mkdir -p "$(dirname "$dest")"
		mv "$src" "$dest"
		;;
	*)
		sudo mkdir -p "$(dirname "$dest")"
		sudo cp "$src" "$dest"
		;;
	esac
}

copy() {
	_copy "$ROOT/files/${1}" "$2"
}

tmpl() {
	local src="$ROOT/files/${1}.in"
	local dest="$2"
	local tmp="$CF_TMPDIR/$1"
	shift 2

	local var_names_list="$*"
	set --

	for var_name in $var_names_list; do
		eval var_value=\$"$var_name"
		# shellcheck disable=SC2154
		set -- "$@" -e "s|@${var_name}[@]|${var_value}|g"
	done

	if [ "$#" -eq 0 ]; then
		echo 'need template var names' >&2
		exit 1
	fi

	sed "$@" "$src" >"$tmp"

	_copy "$tmp" "$dest"
}
