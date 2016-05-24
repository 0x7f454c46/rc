#
# `git contrib` - command that shows your contribution to the project.
# It accepts all options from `git log`: you may specify author,
# files, range between hashes, etc.
# It will output stats for files (numbers of added/removed lines)
# and total statistics.
#
# Example:
# [criu]$ ~/.config/shell/scripts/git-contrib.sh --author=Safonov master
# Ins	Dels	Filename
# 2	2	arch/x86/parasite-head.S
# 15	0	cr-check.c
# 49	11	cr-dump.c
# 4	3	criu/arch/aarch64/crtools.c
# 0	3	criu/arch/aarch64/include/asm/parasite-syscall.h
# 1	1	criu/arch/aarch64/include/asm/restorer.h
# 3	3	criu/arch/aarch64/Makefile.syscalls
# 4	3	criu/arch/arm/crtools.c
# 0	4	criu/arch/arm/include/asm/parasite-syscall.h
# 1	1	criu/arch/arm/include/asm/restorer.h
# 3	3	criu/arch/arm/Makefile.syscalls
# 1	3	criu/arch/ppc64/crtools.c
# 0	3	criu/arch/ppc64/include/asm/parasite-syscall.h
# 1	1	criu/arch/ppc64/include/asm/restorer.h
# 4	4	criu/arch/ppc64/Makefile.syscalls
# 4	3	criu/arch/x86/crtools.c
# 0	3	criu/arch/x86/include/asm/parasite-syscall.h
# 1	27	criu/arch/x86/include/asm/restorer.h
# 9	8	criu/arch/x86/Makefile.syscalls
# 2	1	criu/arch/x86/syscalls/syscall_32.tbl
# ... # omitted here
#
# Total: 1175 added, 522 deleted.
#        653 difference.
#
# You may want to add it to your git aliases:
# git config --global alias.contrib '!bash git-contrib.sh'
#
# Copyright (c) 2016 Dmitry Safonov
#
# This program is free software; you can redistribute it and/or modify
# it under the terms and conditions of the GNU General Public License,
# version 2, as published by the Free Software Foundation.
#
# This program is distributed in the hope it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#

declare -A INSERTIONS
declare -A DELETIONS
TOTAL_INS=0
TOTAL_DEL=0

# Colors
red='\E[31m'
green='\E[32m'

while read adds dels filename
do
	INSERTIONS[${filename}]=$((INSERTIONS[${filename}] += adds))
	DELETIONS[${filename}]=$((DELETIONS[${filename}] += dels))
	TOTAL_INS=$((TOTAL_INS += adds))
	TOTAL_DEL=$((TOTAL_DEL += dels))
done <<< "$(git log --numstat --pretty='' $@)"

echo -e "Ins\tDels\tFilename"

for f in "${!INSERTIONS[@]}"
do
	echo -en $green
	echo -en "${INSERTIONS[$f]}\t"
	echo -en $red
	echo -en "${DELETIONS[$f]}\t"
	tput sgr0
	echo -e "${f}"
done | sort -k3

echo
echo -n "Total: "
echo -en $green
echo -n "$TOTAL_INS"
tput sgr0
echo -n " added, "
echo -en $red
echo -n "$TOTAL_DEL"
tput sgr0
echo " deleted."
echo "       $((TOTAL_INS - TOTAL_DEL)) difference."
