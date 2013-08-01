#!/bin/bash
export LANG=C LC_ALL=
find /usr/src/linux-"${1}" -exec chmod a+r -- {} +
find /usr/src/linux-"${1}" -perm /0100 -exec chmod a+x {} +
true
