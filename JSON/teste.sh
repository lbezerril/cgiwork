#!/bin/bash

GIT_BRANCHES=( "\"A\"," "\"B\"" );
PROFILES_NAME=( "\"AppSrv01\"" "\"AppSrv02\"" );
PROFILES_ON=( "true" "false" );
PROFILES_CONSOLE_PORT=( "9060" "9061" );
PROFILES_APPLICATION_PORT=( "9080" "9081" );
PROFILES_MODULES=( "null" "null" );
PROFILES_MOCKS=( "[\"GetListDriver\",\"UpdateDriver\",\"AddDriver\"]" "[\"GetListDriver\",\"UpdateDriver\",\"AddDriver\"]" );
PROFILES_TEMP_SIZE=( 25 0 );
MODULES_NAME=();
MODULES_ON=();
MODULES_SHARED_LIB=();
SERVICES_NAME=( "\"GetListDriver\"" "\"AddDriver\"" "\"UpdateDriver\"" );
SERVICES_ON=( "true" "true" "false" );

declare -A ROOT=( ["class.json"]="root" ["applications"]="[class.json]=applications.0" ["web_service"]="[class.json]=web_service.0" );
declare -A APPLICATIONS=( ["class.json"]="applications" ["git"]="[class.json]=git.0" ["was"]="[class.json]=was.0" );
declare -A GIT=( ["class.json"]="git" ["current_branch"]="\"master\"" ["branches"]="[${GIT_BRANCHES[@]}]" );
declare -A WAS=( ["class.json"]="was" ["was_home"]="\"/opt/IBM/WebSphere/AppServer\"" ["profiles"]="[class.json]=profiles.${#PROFILES_NAME[@]}" );
declare -A PROFILES=( ["class.json"]="profiles" ["name"]=PROFILES_NAME ["on"]=PROFILES_ON ["console_port"]=PROFILES_CONSOLE_PORT ["application_port"]=PROFILES_APPLICATION_PORT ["modules"]=PROFILES_MODULES ["mocks"]=PROFILES_MOCKS ["temp_size"]=PROFILES_TEMP_SIZE );

declare -A MODULES=( ["class.json"]="modules" ["name"]=MODULES_NAME ["on"]=MODULES_ON ["shared_lib"]=MODULES_SHARED_LIB );

declare -A WEB_SERVICE=( ["class.json"]="web_service" ["endpoint"]="\"http://service.com/\"" ["on"]="true" ["services"]="[class.json]=services.${#SERVICES_NAME[@]}" );
declare -A SERVICES=( ["class.json"]="services" ["name"]=SERVICES_NAME ["on"]=SERVICES_ON );

. ./framework.v2.sh ROOT APPLICATIONS GIT WAS PROFILES MODULES WEB_SERVICE SERVICES;
