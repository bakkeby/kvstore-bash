#
# Zsh completion for kvstore
#
# Copyright (c) 2019, Stein Gunnar Bakkeby
# All rights reserved.
#

function _kvstorecomp {
	if [[ "${#words[*]}" == "2" ]]; then
		if [[ "${words[CURRENT]}" == '-'* ]]; then
			reply=($(kvstore -o))
		else
			reply=($(kvstore -k))
		fi
	else
		case ${words[2]} in
			-r|--remove)
				reply=($(kvstore -k))
				;;
		esac
	fi
	return 0
}
    
compctl -K _kvstorecomp + -x \
'c[-1,-l],c[-1,--list],c[-1,--clear],c[-1,--purge],c[-1,-h],c[-1,--help],c[-1,-k],c[-1,--keys],c[-1,--locate]' -k "()" - \
's[prj/]' -s 'path/to/file' - \
's[]' -/ -- \
kvstore