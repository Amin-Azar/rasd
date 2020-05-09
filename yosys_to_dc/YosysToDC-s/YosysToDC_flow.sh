#! /bin/bash

initial="
#------------------------------------------------------------------------#
#  Command to run:                                                       #
#  cd /data/git/repos/                                                   #
#  bash YosysToDC_flow.sh [-top ff_mult16appx]                           #
#  or bash YosysToDC_flow.sh  [-off] [DC]                                #
#                                                                        #
#                                                                        #
#  Amin Ghasemazar - June  2016  contact:aming@ece.ubc.ca                #
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

toolsFolder="/data/git/repos"
tmpFolder="/data/tmp"
workingFolder="/ubc/ece/home/ml/grads/aming/tmp"

topModule="ff_mult16appx"

statFile="stats.log"
yosysInitFile="Yosys_init.log"
yosysFlowFile="Yosys_flow.log"
dcFlowFile="DC_flow.log"

timingFile="timing.rep" #** defined by DC
powerFile="power.rep" #** defined by DC
cellFile="cell.rep" #** defined by DC
netlistFile="netlist.v" #** defined by DC
vhFile="*.vh" #** defined by DC
adcFile="*.sdc" #** defined by DC
terminalLogFile="terminal_out.log" #** defined by DC
cellSelectionFile="selection.tmp"

CPATH_cells="critical_path_cells.txt"
CPATH_stsp_2="critical_path_stSp.txt"

errKeys='ERROR\|error\|Error\|such\|directory\|Cannot\|cannot'
warningKeys='Warning\|warning'
#Hides them from the main terminal
filter=".*0.0.*\|.*0:0.*"


loopIndx=0
DC_flag=1


##########################################################################

reportFunc ()
{

> $tmpFolder/cpath_$loopIndx.rep
cat $tmpFolder/out_DC/$timingFile | grep -v '.*_$.*' 	| tee -a $tmpFolder/cpath_$loopIndx.rep
echo -e "\npath is:" 					| tee -a $tmpFolder/cpath_$loopIndx.rep
cat $tmpFolder/out_DC/critical_path_cells.txt 		| tee -a $tmpFolder/cpath_$loopIndx.rep

}

indexFunc ()
{
mv $tmpFolder/out_DC/$timingFile	$tmpFolder/out_DC/timing_$loopIndx.rep
mv $tmpFolder/out_DC/$powerFile		$tmpFolder/out_DC/power_$loopIndx.rep
mv $tmpFolder/out_DC/$netlistFile	$tmpFolder/out_DC/netlist_$loopIndx.v
mv $tmpFolder/out_DC/$cellFile		$tmpFolder/out_DC/cell_$loopIndx.rep
mv $tmpFolder/out_DC/$terminalLogFile	$tmpFolder/out_DC/terminal_out_$loopIndx.log
cp $tmpFolder/out_DC/$CPATH_cells	$tmpFolder/out_DC/cpath_cells_$loopIndx.log
mv $tmpFolder/out_DC/$CPATH_stsp_2	$tmpFolder/out_DC/cpath_stSp_$loopIndx.log

}

##########################################################################

#========================================================================
#                           GET PARAMETERS
#========================================================================

#get top module name | run DC or no (DEBUGGING)
#------------------------------------------------------------------------

if [ -z "$1" ] && [ -z "$2" ]; then
	echo -e "${BLUE}running with default -top $topModule${NC}"
else
	echo "$1 $2"
	if [ "$1" == "-top" ];then
		topModule=$2
	fi

	if [ "$1" == "-off" ];then
		if [ "$2" == "DC" ];then
		DC_flag=0;
	fi
	fi

fi

#========================================================================
#                             LOG FILES
#========================================================================

#create files
#------------------------------------------------------------------------

> $tmpFolder/$statFile
> $tmpFolder/$yosysInitFile
> $tmpFolder/$yosysFlowFile
> $tmpFolder/$dcFlowFile


#========================================================================
#                            INPUT FILES
#========================================================================

# file selection
#------------------------------------------------------------------------

cd $toolsFolder/benchmarks/custom/mult16appx/
verilogFile=$(zenity --file-selection --multiple --separator=' ')
echo -e "${BLUE}running for $verilogFile -top $topModule${NC}" #| tee -a $tmpFolder/$statFile
echo "running for $verilogFile -top $topModule" > $tmpFolder/$statFile
cd $tmpFolder

# path justifications
# replace top mulde (path & names) with selected
#------------------------------------------------------------------------

#yosys
cat $toolsFolder/Yosys/yosysCommands_Submod_original.tcl | sed -e 's,set inputFile.*,set inputFile "'"$verilogFile"'",' > $toolsFolder/Yosys/yosysCommands_Submod.tcl
#cat $toolsFolder/Yosys/yosysCommands_Submod.tcl

#DC
cat $workingFolder/scripts/synth_DC_original.tcl | sed -e 's,set my_toplevel.*,set my_toplevel '"$topModule"',' > $workingFolder/scripts/synth_DC.tcl
#cat $workingFolder/scripts/synth_DC.tcl


#========================================================================
#                      EXTRACTING SUB MODULES
#========================================================================

# (1) run Yosys init
#------------------------------------------------------------------------
echo -e "${BLUE}${BOLD}(1) run Yosys init${NORM}${NC}"
printf "${bg_YELLOW}"
bash $toolsFolder/Yosys/Yosys_init.sh "-indx" "$loopIndx"                                

# (2) run DC flow for the first time
#-----------------------------------------------------------------------
echo -e "${BLUE}${BOLD}(2) run DC flow${NORM}${NC}"
printf "${bg_GREEN}"
if [ $DC_flag != 0 ]; then
bash $toolsFolder/DC/DC_flow.sh "-indx" "$loopIndx" 	| grep -v $filter
fi

# report the path
#-----------------------------------------------------------------------
reportFunc

# index files
indexFunc
#-----------------------------------------------------------------------


#========================================================================
#                                LOOP
#========================================================================

#Loop indexing
loopIndx=$((loopIndx+1))
cat $toolsFolder/Yosys/yosysCommands_Replace_add_original.tcl | sed -e 's,set loopIdx.*,set loopIdx '"$loopIndx"',' > $toolsFolder/Yosys/yosysCommands_Replace_add.tcl
cat $toolsFolder/Yosys/yosysCommands_Replace_add.tcl


#Loop
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\
#^(3) optimization flow                                                  V
#^-----------------------------------------------------------------------V
#^                                                                       V
  echo -e "${BLUE}${BOLD}(3) run optimization flow${NORM}${NC}"   #      V
  printf "${bg_GREEN}"                                            #      V
  bash $toolsFolder/Optimize/Opt_flow.sh "-indx" "$loopIndx"      #      V 
#^                                                                       V
#^                                                                       V
#^(4) run Yosys flow                                                     V
#^-----------------------------------------------------------------------V
#^                                                                       V
  echo -e "${BLUE}${BOLD}(4) run Yosys flow${NORM}${NC}"          #      V
  printf "${bg_GREEN}"                                            #      V
  bash $toolsFolder/Yosys/Yosys_flow.sh  "-indx" "$loopIndx"      #      V 
#^                                                                       V
#^                                                                       V
#^(5) run DC flow                                                        V
#^ ----------------------------------------------------------------------V
#^                                                                       V
  echo -e "${BLUE}${BOLD}(5) run DC flow${NORM}${NC}"     	  #      V 
  if [ $DC_flag != 0 ]; then                              	  #      V
  bash $toolsFolder/DC/DC_flow.sh "-indx" "$loopIndx" | grep -v $filter #V 
  fi                                                      	  #      V
#^                                                                       V
#^<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<</

#report the path
#-----------------------------------------------------------------------
reportFunc

# index files
indexFunc
cp $tmpFolder/$cellSelectionFile	$tmpFolder/out_Opt/selection_$loopIndx.tmp
#-----------------------------------------------------------------------


##########################################################################

#========================================================================
#                             REPORTS
#========================================================================

printf  "${YELLOW}$brk${NC}" #break
printf "\n=================================LOGs================================\n"

#Errors
#------------------------------------------------------------------------
printf  "${YELLOW}$brk${NC}" #break
printf  "${NC}\n${RED}"
echo "****Errors:"
printf  "${NC}\n\n\n\n\n${RED}"
cat  $tmpFolder/$yosysInitFile 	| grep $errKeys
printf  "${NC}\n\n\n\n\n${RED}"
cat  $tmpFolder/$dcFlowFile 	| grep $errKeys
printf  "${NC}\n\n\n\n\n${RED}"
cat  $tmpFolder/$yosysFlowFile 	| grep $errKeys
printf  "${NC}"

#warnings
#------------------------------------------------------------------------
printf  "${YELLOW}$brk${NC}" #break
printf  "${NC}\n${RED}"
echo "****Warnings:"
printf  "${NC}\n\n\n\n\n${RED}${bg_YELLOW}"
cat  $tmpFolder/$yosysInitFile 	| grep $warningKeys
printf  "${NC}\n\n\n\n\n${RED}${bg_YELLOW}"
cat  $tmpFolder/$dcFlowFile 	| grep $warningKeys
printf  "${NC}\n\n\n\n\n${RED}${bg_YELLOW}"
cat  $tmpFolder/$yosysFlowFile 	| grep $warningKeys
printf  "${NC}"

#Stats
#------------------------------------------------------------------------
printf  "\n\n${YELLOW}$brk\n${NC}" #break
printf  "\n\n${RED}****stats:\n${GREEN}" #break
cat $tmpFolder/$statFile

#organizing
mv $tmpFolder/*.log $tmpFolder/logs/
#------------------------------------------------------------------------
printf  "\n\n${RED}****Finish!:\n${NC}" #break
exit;


##########################################################################
