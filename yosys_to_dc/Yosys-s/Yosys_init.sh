#!/usr/bin/bash

initial="
#------------------------------------------------------------------------#
#  Command to run:                                                       #
#  cd /data/tmp                                                          #
#  bash Yosys_init.sh                                                    #
#                                                                        #
#                                                                        #
#                                                                        #
#  Amin Ghasemazar - October 2016  contact:aming@ece.ubc.ca              #
#------------------------------------------------------------------------#
"


##########################################################################

#variables
#------------------------------------------------------------------------

RED='\033[0;31m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color
YELLOW='\e[1;33m'

bg_GREEN='\e[115m'
bg_YELLOW='\e[43m'

BOLD=$(tput bold)
NORM=$(tput sgr0)

brk="------------------------------------------------------------------------"

tmpFolder="/data/tmp"
toolsFolder="/data/git/repos"
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
#                              RUN Yosys
#------------------------------------------------------------------------

#run Yosys and log output
#------------------------------------------------------------------------
echo "Yosis init flow"
bash $toolsFolder/Yosys/runYosys_init.sh 2>&1 | tee $tmpFolder/Yosys_init_$loopIndx.log | tee -a $tmpFolder/Yosys_init.log


#========================================================================
#                            ERROR CHECKING
#------------------------------------------------------------------------

#check for Error, if any!
#------------------------------------------------------------------------

printf  "${YELLOW}$brk${NC}" #break
printf  "${NC}\n\n\n\n\n${RED}"
echo "****Yosys_init Errors:"

cat  $tmpFolder/Yosys_init_$loopIndx.log | grep 'ERROR\|error\|Error'

printf  "\n\n${YELLOW}$brk\n${NC}" #break

##########################################################################
