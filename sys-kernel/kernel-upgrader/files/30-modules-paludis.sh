#!/bin/bash
[[ "${PACKAGE_MANAGER}" = "paludis" ]] || exit 0
modules_find() {
	for X in /lib*/modules ; do cave owner $X ; done | sed -e 's,^,=,' -e 's,:.*,,' 
}
MODULES="$(modules_find)"
[ -z "$MODULES" ] && exit 0
env -i HOME="$HOME" LC_CTYPE="${LC_ALL:-${LC_CTYPE:-$LANG}}" PATH="$PATH" USER="$USER" cave resolve -1xz -- $MODULES
true
