#
# Bash completion for kvstore
#
# Copyright (c) 2019, Stein Gunnar Bakkeby
# All rights reserved.
#

function _kvstorecomp {
	if [[ "${#COMP_WORDS[@]}" == "2" ]]; then
		if [[ "${COMP_WORDS[COMP_CWORD]}" == '-'* ]]; then
			COMPREPLY=($(compgen -W '$(kvstore -o)' -- ${COMP_WORDS[COMP_CWORD]}))
		else
			COMPREPLY=($(compgen -W '$(kvstore -k)' -- ${COMP_WORDS[COMP_CWORD]}))
		fi
	else
		case ${COMP_WORDS[1]} in
			-l|--list|--clear|--purge|-h|--help|-k|--keys|--locate|--hostname|-q|-quiet)
				COMPREPLY=($'\0'); # no further suggestions
				;;
			-r|--remove)
				COMPREPLY=($(compgen -W '$(kvstore -k)' -- ${COMP_WORDS[COMP_CWORD]}))
				;;
			-a|--add|-u|--update)
				COMPREPLY=($'\0'); # no further suggestions
				;;
			*)
				COMPREPLY=()
				;;
		esac
	fi
	return 0
}
shopt -s progcomp
complete -o dirnames -F _kvstorecomp kvstore