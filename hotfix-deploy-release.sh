#!/bin/bash
# Die if issue :
set -e
# get commit from cli :
commit=$1
# Shift $1 out of the stack
shift
# Patch frenzy :
for to_patch in $@; do
	git checkout ${to_patch} 
	git cherry-pick ${commit} # merge patch
	git push origin :${to_patch} # delete remote tag
	git tag -d ${to_patch} # delete local tag
	git tag ${to_patch} # local tag
	git push origin ${to_patch} # push new tag
done
