#!/bin/bash

function grep_cc()
{
	sed -n 's/^[cC][cC]:[[:blank:]]*\([[:graph:]].*\)/\1/p'
}
function grep_by()
{
	sed -n 's/^[[:graph:]]*-[bB][yY]:[[:blank:]]*\([[:graph:]].*\)/\1/p'
}

if [[ $(basename "${1}") =~ ^0000- ]] ; then
	for p in $(dirname "${1}")/*.patch
	do
		cat "${p}" | grep_cc
		cat "${p}" | grep_by
	done
else
	cat $(dirname "${1}")/0000-*.patch | grep_cc
	cat "${1}" | grep_by
fi

