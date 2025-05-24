#!/usr/bin/env bash

gitUser="PFleur"
branch="main"

mkdir ./archer

curl -sL https://raw.githubusercontent.com/PFleur/archer-archinstaller/main/0-0_archLiveEnvironment.sh > ./archer/0-0_archLiveEnvironment.sh
curl -sL https://raw.githubusercontent.com/PFleur/archer-archinstaller/main/0-1_rootInitialSetup.sh > ./archer/0-1_rootInitialSetup.sh
curl -sL https://raw.githubusercontent.com/PFleur/archer-archinstaller/main/1_gitPrograms.sh > ./archer/1_gitPrograms.sh
curl -sL https://raw.githubusercontent.com/PFleur/archer-archinstaller/main/2_xorgSetup.sh > ./archer/2_xorgSetup.sh
curl -sL https://raw.githubusercontent.com/PFleur/archer-archinstaller/main/3_pacmanPackages.sh > ./archer/3_pacmanPackages.sh
curl -sL https://raw.githubusercontent.com/PFleur/archer-archinstaller/main/4_aur.sh > ./archer/4_aur.sh
