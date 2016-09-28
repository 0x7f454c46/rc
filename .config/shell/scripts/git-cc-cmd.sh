#!/bin/bash

if [[ $(basename "${1}") =~ ^0000- ]] ; then
	for p in $(dirname "${1}")/*.patch
	do
		cat "${p}" | sed -n					\
			's/^[cC][cC]:[[:blank:]]*\([[:graph:]].*\)/\1/p'
	done
fi

