#!/bin/bash

export OPTION="" # por defecto update I instalar modulos
export VALUES=""

while [ -n "$1" ]; do # while loop starts
	case "$1" in
    -o) OPTION="$2"
        shift
        ;;
    -m) VALUES="$2"
      shift
      ;;
	esac
	shift
done

if [ "$OPTION" = "" ]; then
    echo "Option is required -o"
    exit 1
fi

if [ "$VALUES" = "" ]; then
    echo "VALUES is required -m"
    exit 1
fi

rep=$MODULE
    oldIFS=$IFS;
    IFS=","
    for item in $rep;
    do
      convert_module "$item"
      mod_upd+="${mod},"
    done;
    IFS=$oldIFS
    modules_upd=" -u ${mod_upd%,*}"
