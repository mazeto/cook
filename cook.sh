#!/bin/sh
# for convenience
alias ?=test
# Global list of dependencies
DEPS=""
CFGDIR="$HOME/.config/cook"

# The bash function check returns true, 0,
# when recompilation is needed.
# it also sets a variable called DEPS.
# DEPS is a useful variable that holds a list of
# all dependencies, so you can write
# check bin src1.c src2.c src3.c && $CC -o bin $DEPS
# Usage: check executable bar.c foo.c lib.c etc.c

check(){
    # resets the DEPS list
    DEPS=""
    # at 1st, assume we don't need to recompile
    ret=1
    # if the 1st file don't even exist, return true
    # in this case, we don't return 0 yet, because
    # we need to set the DEPS variable
    ? ! -f "$1" && ret=0
    # for each given argument
    for file in $@;{
        # skip 1st arg, because the 1st arg
        # is the very object file to be compiled
        ? "$file" == "$1" && continue
        # appends to DEPS.
        DEPS="$DEPS $file"
        # if the file doesn't exists, print err.
        ? ! -f "$file" && echo -e  \
            "\x1b[33;41m"          \
            "$file doesn\'t exist" \
            "\x1b[0m" && break
        # but if it is newer than the 1st arg return 0
        ? "$file" -nt "$1" && ret=0 && break;
    }
    return $ret
}

# The function contains returns true, 0 in bash,
# if the argsarray contains the word.
# usage: contains word argsarray
# this is probably not the best way to do it,
# but its the way I know, and it works.

contains(){
    echo "$(echo $@ | cut -c $((${#1}+2))-)" |\
    grep "$1" > /dev/null && return 0
    return 1
}

# handles cook -f file
[[ "$#" == "2"  ]] &&\
[[ "$1" == "-f" ]] &&\
[[ -e "$2"      ]] &&\
. "$2"             &&\
exit 0

# handles cook -n template
[[ "$#" == "2" ]]          &&\
[[ "$1" == "-n" ]]         &&\
[[ -e "$CFGDIR/$2" ]]      &&\
cp "$CFGDIR/$2" "cookbook" &&\
exit 0

# handles cook [args]
[[ -e "./cookbook" ]]     &&\
echo "running ./cookbook" &&\
. "./cookbook" $@         &&\
exit 0

# handles everything else
echo -en "usage:\n\tcook [-f cookbook] [-n template]\n" &&\
exit 0
