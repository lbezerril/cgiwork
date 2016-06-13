#!/bin/bash

# http://stackoverflow.com/questions/4069188/how-to-pass-an-associative-array-as-argument-to-a-function-in-bash
# http://stackoverflow.com/questions/6790631/use-the-contents-of-a-file-to-replace-a-string-using-sed
function replace_values() {
	for i in "${!CURRENT[@]}"; do
		FIND="\${"$i"}"; echo "FIND=$FIND";
		REPLACE="${CURRENT["$i"]}"; echo "REPLACE=$REPLACE";
	
		cat "${CURRENT["file_name"]}" | sed "s/$FIND/$REPLACE/g";
	done;
}


# Procura pelo array associativo raiz:
# Verificar se parametro recebido são todos arrays associativos.
for i in $@; do
	echo $i;
	DECLARE=$(declare -p $i 2>/dev/null || echo no);
	#echo ${DECLARE#*=}
	eval "declare -A CURRENT="${DECLARE#*=}
	echo ${CURRENT["file_name"]};

	replace_values;
done;
exit 1;


function validate_json_includes() {
	# ex root.json
	# verifica se o arquivo existe e se tem permissão de leitura... (centralizar o codigo com o do cgiwork)
	echo;
}


#http://stackoverflow.com/questions/4668640/how-to-execute-command-stored-in-a-variable
