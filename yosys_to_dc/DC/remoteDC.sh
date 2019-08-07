#!/usr/bin/bash
#------------------------------------------------------------------------#
#  Command to run:                                                       # 
#  cd /data/git/repos/DC                                                 #
#  bash remoteDC.sh                                                      #
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
#toolsFolder="/data/git/repos"
workingFolder="/ubc/ece/home/ml/grads/aming/tmp"

##########################################################################


#copy to
#------------------------------------------------------------------------

#copy scripts from ~/tmp/scripts
cp -rf /data/git/repos/DC/scripts ~/tmp/
#copy verilog file from /data/tmp
cp $tmpFolder/Yosys_to_DC.v ~/tmp/inFiles/
#copy tachmap file
cp $tmpFolder/ETAIIM_parameter.v ~/tmp/inFiles/



#run DC
#------------------------------------------------------------------------

#ssh and run DC remotely
echo $brk
echo -e "${BLUE}${BOLD}running ssh${NORM}${NC}"
ssh ssh-soc 'cd tmp/;ls ./inFiles ;tcsh '"$workingFolder"'/scripts/initShell.csh'
echo -e "${BLUE}${BOLD}ssh DONE!${NORM}${NC}"


#copy from
#------------------------------------------------------------------------

#copy output files back to /data/tmp
echo $brk
cp -r ~/tmp/outs/* $tmpFolder/out_DC

#copy scripts from ~/tmp/scripts
cp -r ~/tmp/scripts /data/git/repos/DC/

##########################################################################
