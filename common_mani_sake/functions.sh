#!/bin/bash

[ -n "${BASH_VERSION}" ] || {
	echo "This script requires Bash."
	exit 1
}

set -f || exit 1
_VERSION=2024.11.23
_VERBOSE=false

function err {
	printf '%s\n' "${1-}" 2>&1
	return "${2-1}"
}
function die {
	err "$@"
	exit
}
function assert {
	eval "[[ $1 ]]" || die "Failed assertion: $1"
}
function get_opt_and_optarg {
	OPT=$1 OPTARG= OPTSHIFT=0
	if [[ $1 == -[!-]?* ]]; then
		OPT=${1:0:2} OPTARG=${1:2}
	elif [[ $1 == --*=* ]]; then
		OPT=${1%%=*} OPTARG=${1#*=}
	elif [[ ${2+.} ]]; then
		OPTARG=$2 OPTSHIFT=1
	else
		fail "No argument specified for '$1'."
	fi
	return 0
}
function show_usage_and_exit {
	local basename=${0##*/}

	echo " Some functions to be used in yaml files

First you have to modify with permission this file like chmod +x ${basename}

Usage: ${basename} [options]
       ${basename//?/ } -h|--help|-V|--version

Options:
  -h, --help     Show this usage info and exit
  -v, --verbose  Be verbose
  -p, --Return absolute path with dot|period value
  -V, --version  Show version and exit"

	exit 2
}

#if [ "$OPTION" = "" ]; then
#    echo "Option is required -o"
#    exit 1
#fi
#
#if [ "$VALUES" = "" ] && [ "$OPTION" != "p" ]; then
#    echo "VALUES is required -v"
#    exit 1
#fi

function get_abspath {
  # https://github.com/konsolebox/scripts
	local t=() i=0 IFS=/
	case $1 in
	/*)
		__=${1#/}
		;;
	*)
		__=${PWD#/}/$1
		;;
	esac
	case $- in
	*f*)
		set -- $__
		;;
	*)
		set -f
		set -- $__
		set +f
		;;
	esac
	for __; do
		case $__ in
		..)
			(( i )) && unset 't[--i]'
			continue
			;;
		.|'')
			continue
			;;
		esac
		t[i++]=$__
	done
	case $1 in
	*/)
		(( i )) && __="/${t[*]}/" || __=/
		;;
	*)
		(( i )) && __="/${t[*]}" || __=/.
		;;
	esac
}

function get_clean_path {
  # https://github.com/konsolebox/scripts
	local t=() i=0 IFS=/
	case $1 in
	/*)
		__=${1#/}
		;;
	*)
		__=${PWD#/}/$1
		;;
	esac
	case $- in
	*f*)
		set -- $__
		;;
	*)
		set -f
		set -- $__
		set +f
		;;
	esac
	for __; do
		case $__ in
		..)
			(( i )) && unset 't[--i]'
			continue
			;;
		.|'')
			continue
			;;
		esac
		t[i++]=$__
	done
	__="/${t[*]}"
}
#
#if [ "$OPTION" = "p" ]; then
#    get_abspath "${VALUES}"
#    echo "$__"
#fi

function cd {
  	local args=() opts=() __

	while [[ $# -gt 0 ]]; do
		case $1 in
		--)
			args+=("${@:2}")
			break
			;;
		-?*)
			opts+=("$1")
			;;
		*)
			args+=("$1")
			;;
		esac

		shift
	done

	set -- "${args[@]}"

	{
		if [[ $# -gt 1 && $- == *i* && -t 0 && -t 2 ]]; then
			echo "Choose a directory." >&2

			select __; do
				if [[ $__ ]]; then
					set -- "$__"
					break
				fi
			done
		fi

		if [[ $# -gt 1 ]]; then
			echo "Too many directory argmuments specified." >&2
		elif [[ ${1-} == - && ${#DIRSTACK[@]} -ge 2 ]]; then
			if builtin cd -P "${opts[@]}" -- "${DIRSTACK[1]}"; then
				popd -n
				return 0
			fi

			echo "Run 'popd -n' to exclude directory from the stack if it has issues." >&2
		else
			pushd -n -- "${PWD}"
			[[ ${1-} == . ]] && set -- "${PWD}"

			if builtin cd -P "${opts[@]}" -- "$@"; then
				[[ ${DIRSTACK[0]} == "${DIRSTACK[1]}" ]] && popd -n
				return 0
			fi

			popd -n
		fi
	} > /dev/null

	return 1
}
function main {
  local options=()
  while [[ $# -gt 0 ]]; do
		case $1 in
		-h|--help)
			show_usage_and_exit
			;;
	  -p|--path)
			get_abspath "$2"
      echo "$__"
			break
			;;
		-v|--verbose)
			_VERBOSE=true
			;;
		-V|--version)
			echo "${_VERSION}"
			return 2
			;;
		--)
			options+=("${@:2}")
			break
			;;
		-[!-][!-]*)
			set -- "${1:0:2}" "-${1:2}" "${@:2}"
			continue
			;;
	  -?*)
			die "Invalid option: $1"
			;;
		*)
			options+=("$1")
			;;
		esac

		shift
	done

}

main "$@"