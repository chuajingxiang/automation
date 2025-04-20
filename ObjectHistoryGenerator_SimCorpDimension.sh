#!/bin/bash
#************************************************************************************************************
# MODULE NAME       : ObjectHistoryGenerator
# MODULE DESCRIPTION: Generate objects history based on branch.
#
# USAGE             : 
# DATE CREATED      : 01 Apr 2021
# ORIGINAL AUTHOR   : Jing Xiang
#************************************************************************************************************
# MODIFICATION HISTORY
#************************************************************************************************************
# DATE MODIFIED         MODIFIED BY             COMMENTS
#************************************************************************************************************
#
#************************************************************************************************************
#set -x
ScriptTempFolder='xx'

REPOBASEPATH='xx'
CEIFOLDER='xx'
cd $REPOBASEPATH

echo "Ensuring git repo is up to date..."
#git checkout develop
#git pull origin develop


for eachfolder in "$CEIFOLDER"/*
do
  eachfolder_final=$(echo $eachfolder | sed 's/\\/\//g')
  objects=$(find $eachfolder_final \( -iname "*.obj" ! -iname "[A-z]*_Z*.*" \))
    for eachobject in $objects
	do
	  #echo $eachobject
	  CEIObjectPath=`echo $eachobject | sed 's/C:\/Users\/Snake\/Documents\/ceicompare_developv2\///g'`
	  #echo $CEIObjectPath
	  CEIObjectName=`echo $CEIObjectPath | cut -d'/' -f3`
	  echo $CEIObjectName >> testing12345.txt
	  #git log --follow --pretty=format:"%hai %s%x0D%x0A" "$CEIObjectPath"
	  CURCEIObjectHistoryList=`git log --follow --pretty=format:%h "$CEIObjectPath"` 
	  #echo $CURCEIObjectHistoryList
	  # >> $ScriptTempFolder\$CEIObjectName'.tmp'
	  for eachid in $CURCEIObjectHistoryList
	  do
	    eachidDetails=`git log --format='Author: %an%nCommit Date: %cd%nCommit Message: %B' $eachid^!`
	    echo CommitID:$eachid '|' $eachidDetails >> testing12345.txt
	done
	  
	done
