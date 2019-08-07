#!/usr/bin/bash
#------------------------------------------------------------------------#
#  Command to run:                                                       #
#  cd /data/git/repos/DC                                                 #
#  bash DC_flow.sh                                                       #
#                                                                        #
#                                                                        #
#                                                                        #
#  Amin Ghasemazar - October 2016  contact:aming@ece.ubc.ca              #
#------------------------------------------------------------------------#


##########################################################################

#variables
#------------------------------------------------------------------------
RED='\033[0;31m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color
YELLOW='\e[1;33m'

BOLD=$(tput bold)
NORM=$(tput sgr0)

brk="------------------------------------------------------------------------"


tmpFolder="/data/tmp"
toolsFolder="/data/git/repos"
workingFolder="/ubc/ece/home/ml/grads/aming/tmp"
loopIndx=0;

##########################################################################

#===============================INDEX====================================
# get loop index
#------------------------------------------------------------------------

if [ -z "$1" ] && [ -z "$2" ]; then
	echo -e "${BLUE}running with default loop itteration 0 ${NC}"
else
	echo "$1 $2"
	if [ "$1" == "-indx" ];then
		loopIndx=$2
	fi

fi

#========================================================================
#                               RUN DC
#------------------------------------------------------------------------

#run remote DC and log output
#------------------------------------------------------------------------

printf  "${YELLOW}$brk\n${NC}" #break
bash $toolsFolder/DC/remoteDC.sh 2>&1 | tee $tmpFolder/DC_flow_$loopIndx.log | tee -a $tmpFolder/DC_flow.log 

#check for Error, if any!
#------------------------------------------------------------------------

printf  "${YELLOW}$brk${NC}" #break
printf  "${NC}\n\n\n\n\n${RED}"
echo "****DC_flow Errors:"

cat  $tmpFolder/DC_flow_$loopIndx.log | grep 'ERROR\|error\|Error'

printf  "\n\n${YELLOW}$brk\n${NC}" #break

##########################################################################
