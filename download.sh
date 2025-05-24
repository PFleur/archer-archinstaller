#!/usr/bin/env bash

gitUser="PFleur"
branch="main"

mkdir ./archer

curl -sL https://raw.githubusercontent.com/PFleur/archer-archinstaller/main/0-0_archLiveEnvironment.sh > ./archr/0-0_archLiveEnvironment.sh
curl -sL https://raw.githubusercontent.com/PFleur/archer-archinstaller/main/0-1_rootInitialSetup.sh > ./archr/0-1_rootInitialSetup.sh
curl -sL https://raw.githubusercontent.com/PFleur/archer-archinstaller/main/1_gitPrograms.sh > ./archr/1_gitPrograms.sh
curl -sL https://raw.githubusercontent.com/PFleur/archer-archinstaller/main/2_xorgSetup.sh > ./archr/2_xorgSetup.sh
curl -sL https://raw.githubusercontent.com/PFleur/archer-archinstaller/main/3_pacmanPackages.sh > ./archr/3_pacmanPackages.sh
curl -sL https://raw.githubusercontent.com/PFleur/archer-archinstaller/main/4_aur.sh > ./archr/4_aur.sh
