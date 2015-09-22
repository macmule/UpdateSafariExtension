#!/bin/bash
####################################################################################################
#
# More information: 
#
# GitRepo: https://github.com/macmule/UpdateSafariExtension
#
# License: https://macmule.com/license/
#
####################################################################################################
#
####################################################################################################
#
# DEFINE VARIABLES & READ IN PARAMETERS
#
####################################################################################################

# HARDCODED VALUE FOR "PATHTOEXTENSION" IS SET HERE
pathToExtension=""
extensionRegex=""

# CHECK TO SEE IF A VALUE WAS PASSED IN PARAMETER 4 AND, IF SO, ASSIGN TO "PATHTOEXTENSION"
if [ "$4" != "" ] && [ "$pathToExtension" == "" ];then
    pathToExtension=$4
fi

# Error if variable appName is empty
if [ "$pathToExtension" == "" ]; then
	echo "Error:  No value was specified for the pathToExtension variable..."
	exit 1
fi

# CHECK TO SEE IF A VALUE WAS PASSED IN PARAMETER 5 AND, IF SO, ASSIGN TO "extensionRegex"
if [ "$5" != "" ] && [ "$extensionRegex" == "" ];then
    extensionRegex=$4
fi

# Error if variable appName is empty
if [ "$extensionRegex" == "" ]; then
	echo "Error:  No value was specified for the extensionRegex variable..."
	exit 1
fi

####################################################################################################

## Increments for echo at end
extensionCount=0

## Echo what we're doing
echo "Updating extensions with $4..."

## Check for home folders under /Users/
for userHome in /Users/*; do
	## If the below folder exists
  	if [ -d "${userHome}/Library/Safari/Extensions" ]; then
  		## Check for the Extension, using the regex as specified at $5 then replace with the Extension at path $4
    	find "${userHome}/Library/Safari/Extensions" -type f -regex '.*$5.*' -exec cp -v "${4}" "{}" \;
		## Increments
		extensionCount=$((extensionCount+1))
  	fi
done

## If we've not incremented this variable, then no extensions found
if [ $extensionCount == 0 ]; then
	echo "No Extensions found to update in any Home folders..."
## Echo number of home folders we've updated extensions in
else
	echo "Extensions updated in $extensionCount Home folders..."
fi
