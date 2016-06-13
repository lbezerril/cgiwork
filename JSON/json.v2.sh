#!/bin/bash

#declare -A ROOT=( ["class.json"]="root" ["date"]="\"25-03-2016\"" ["file"]="[class.json]=file.0" );
#declare -A FILE=( ["class.json"]="file" ["name"]="\"passwd\"" ["size"]=255 );

NAMES=( "\"groups\"" "\"passwd\"" "\"hosts\"" );
SIZES=( 144 255 1024 );
declare -A ROOT=( ["class.json"]="root" ["date"]="\"25-03-2016\"" ["files"]="[class.json]=files.${#NAMES[@]}" ["testandosealgo"]="\"sdf5sf+s4fs\"" );
declare -A FILES=( ["class.json"]="files" ["name"]=NAMES ["size"]=SIZES );
. ./framework.v2.sh ROOT FILES
