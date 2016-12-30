#!/bin/bash

function grep_cc()
{
	sed -n 's/^[cC][cC]:[[:blank:]]*\([[:graph:]].*\)/\1/p'
}

if [[ $(basename "${1}") =~ ^0000- ]] ; then
	for p in $(dirname "${1}")/*.patch
	do
		cat "${p}" | grep_cc
	done
else
	cat $(dirname "${1}")/0000-*.patch | grep_cc
fi

