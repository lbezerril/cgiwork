#!/bin/bash
# Quanto menos nomes de variaveis, melhor! (por causa do . ./framework.sh)
DEFAULT_ROOT_CLASS_NAME="root";
DEFAULT_CLASS_NAME_KEY="class.json";

JSON_CLASSES_ARRAYS=( $@ );

function find_array_by_name() {
	for JSON_CLASS_ARRAY in ${JSON_CLASSES_ARRAYS[@]}; do
		DECLARE_EXPRESSION=$(declare -p $JSON_CLASS_ARRAY);
		eval "declare -A CURRENT_ASSOCIATIVE_ARRAY="${DECLARE_EXPRESSION#*=};
		if [[ "${CURRENT_ASSOCIATIVE_ARRAY[$DEFAULT_CLASS_NAME_KEY]}" == "$1" ]]; then
			echo "$JSON_CLASS_ARRAY";
			break;
		fi;
	done;
}

CURRENT_ARRAY_NAME="$(find_array_by_name $DEFAULT_ROOT_CLASS_NAME)";

function has_comma() {
	#if [[ "$1" == "$(declare -p CURRENT_ASSOCIATIVE_ARRAY)" ]]; then echo TRUEEEEE; else echo "FALSEEE"; fi;

	if [[ "$1" == ${#CURRENT_ASSOCIATIVE_ARRAY[@]} ]]; then
		echo ","; else echo ",";
	fi;
}

function replace_values_by_class() {
	DECLARE_EXPRESSION=$(declare -p $1);
	eval "declare -A CURRENT_ASSOCIATIVE_ARRAY="${DECLARE_EXPRESSION#*=}
	
	USE_ARRAYS=$(if [[ "$2" != "" ]]; then echo true; else echo false; fi);
	echo "{";
	for i in ${!CURRENT_ASSOCIATIVE_ARRAY[@]}; do
		if [[ "$i" == "$DEFAULT_CLASS_NAME_KEY" ]]; then continue; fi;
		
		if echo "${CURRENT_ASSOCIATIVE_ARRAY[$i]}" | grep -q "\[$DEFAULT_CLASS_NAME_KEY\]=[a-Z 0-9]"; then
			CURRENT_CLASS_NAME=$(echo "${CURRENT_ASSOCIATIVE_ARRAY[$i]}" | cut -d'=' -f2- | rev | cut -d'.' -f2- | rev);
			CURRENT_ARRAY_SIZE=$(echo "${CURRENT_ASSOCIATIVE_ARRAY[$i]}" | cut -d'=' -f2- | rev | cut -d'.' -f-1 | rev);
			CURRENT_ARRAY_NAME="$(find_array_by_name $CURRENT_CLASS_NAME)";
			echo "\"$i\":";
			#Se tiver array no elemento json..:
			if [[ $CURRENT_ARRAY_SIZE -gt 0 ]]; then
				echo "[";
				for i in $(seq 0 $[$CURRENT_ARRAY_SIZE-1]); do
					replace_values_by_class $CURRENT_ARRAY_NAME $i;
				done;
				echo "]$(has_comma $i)";
			else
				replace_values_by_class $CURRENT_ARRAY_NAME;
			fi;
			USE_ARRAYS=false;
			continue;
		fi;
		if $USE_ARRAYS; then
			echo "\"$i\":"$(eval "echo \${${CURRENT_ASSOCIATIVE_ARRAY[$i]}[$2]}")"$(has_comma $i)";
		else
			echo "\"$i\":"${CURRENT_ASSOCIATIVE_ARRAY[$i]}"$(has_comma $i)";
		fi;
	done;
	echo "}$(has_comma $i)";
}

replace_values_by_class $CURRENT_ARRAY_NAME | tr '\n' ' ' | sed 's/, }/}/g;s/, ]/]/g;s/..$//;' | python -m json.tool;
# Remover espaços desnecessarios para o json final ficar o mais enxuto possivel.
# Dica no README: use python -m json.tool para validar e identar seu json gerado
