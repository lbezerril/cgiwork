#!/bin/bash

ARRAY=();

ARRAY+=("string1=\"Eu sei que hoje. já é Domingo!!!\"");
ARRAY+=("string2=\"Eu sei que depois de amanhã já é segunda-feira :=\"");
ARRAY+=("string3=");

ARRAY+=("valor=\"valor.para.testes =.teste=ando.\"");
ARRAY+=("array.0.0=\"Array Inside\"");
ARRAY+=("array.0.1=null");
ARRAY+=("array.1=null");
ARRAY+=("applications.git.current_branch=\"master\"");
ARRAY+=("applications.git.branches.0=\"A\"");
ARRAY+=("applications.git.branches.1=\"B\"");
ARRAY+=("applications.was.was_home=\"/opt/IBM/WebSphere/AppServer\"");
ARRAY+=("applications.was.profiles.0.name=\"AppSrv01\"");
ARRAY+=("applications.was.profiles.0.on=true");
ARRAY+=("applications.was.profiles.0.console_port=9060");
ARRAY+=("applications.was.profiles.0.application_port=9080");
ARRAY+=("applications.was.profiles.0.modules.0.name=\"Module-A\"");
ARRAY+=("applications.was.profiles.0.modules.0.on=true");
ARRAY+=("applications.was.profiles.0.modules.0.shared_lib=false");
ARRAY+=("applications.was.profiles.0.modules.1.name=\"Module-B\"");
ARRAY+=("applications.was.profiles.0.modules.1.on=false");
ARRAY+=("applications.was.profiles.0.modules.1.shared_lib=true");
ARRAY+=("applications.was.profiles.0.mocks.0=\"GetListDriver\"");
ARRAY+=("applications.was.profiles.0.mocks.1=\"UpdateDriver\"");
ARRAY+=("applications.was.profiles.0.mocks.2=\"AddDriver\"");
ARRAY+=("applications.was.profiles.0.temp_size=25");
ARRAY+=("applications.was.profiles.1.name=\"AppSrv02\"");
ARRAY+=("applications.was.profiles.1.on=false");
ARRAY+=("applications.was.profiles.1.console_port=9061");
ARRAY+=("applications.was.profiles.1.application_port=9081");
ARRAY+=("applications.was.profiles.1.modules.0.name=\"Module-A\"");
ARRAY+=("applications.was.profiles.1.modules.0.on=true");
ARRAY+=("applications.was.profiles.1.modules.0.shared_lib=false");
ARRAY+=("applications.was.profiles.1.modules.1.name=\"Module-B\"");
ARRAY+=("applications.was.profiles.1.modules.1.on=false");
ARRAY+=("applications.was.profiles.1.modules.1.shared_lib=true");
ARRAY+=("applications.was.profiles.1.mocks.0=\"GetListDriver\"");
ARRAY+=("applications.was.profiles.1.mocks.1=\"UpdateDriver\"");
ARRAY+=("applications.was.profiles.1.mocks.2=\"AddDriver\"");
ARRAY+=("applications.was.profiles.1.temp_size=0");
ARRAY+=("web_service.endpoint=\"http://service.com/\"");
ARRAY+=("web_service.on=true");
ARRAY+=("web_service.services.0.name=\"GetListDriver\"");
ARRAY+=("web_service.services.0.on=true");
ARRAY+=("web_service.services.1.name=\"AddDriver\"");
ARRAY+=("web_service.services.1.on=true");
ARRAY+=("web_service.services.2.name=\"UpdateDriver\"");
ARRAY+=("web_service.services.2.on=false");

./cgi.sh "${ARRAY[@]}";
