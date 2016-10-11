#!/bin/bash
echo -e "Content-type: application/json\n"

# Add to PATH

#export CGIVAR_git_status=$(get_status "git");
#export CGIVAR_applications_git_branch=$(get_status "git");

# Listar branches: git fetch && git branch

# Path to var???:
cgiwork "../templates/json/status.json"
