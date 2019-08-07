#!/usr/bin/csh
#------------------------------------------------------------------------#
#  Command to run:                                                       #
#  cd /ubc/ece/home/ml/grads/aming/tmp/                                  #
#  bash runDC.csh                                                        #
#                                                                        #
#                                                                        #
#                                                                        #
#  Amin Ghasemazar - October 2016  contact:aming@ece.ubc.ca              #
#------------------------------------------------------------------------#


##########################################################################

#variables
#------------------------------------------------------------------------
#inFile="Yosys_to_DC.v"
workingFolder="/ubc/ece/home/ml/grads/aming/tmp"
outFolder="$workingFolder/outs"

timingFile="timing.rep" #** defined by DC
powerFile="power.rep" #** defined by DC
cellFile="cell.rep" #** defined by DC
netlistFile="netlist.v" #** defined by DC
vhFile="*.vh" #** defined by DC
adcFile="*.sdc" #** defined by DC

termianlOutFile="terminal_out.log"
CPATH_stsp_1="critical_path_startStop.stat";
CPATH_stsp_2="critical_path_stSp.txt"
CPATH_cellD="critical_path_cellsDup.txt"
#******
CPATH_cells="critical_path_cells.txt"

##########################################################################

#========================================================================
#                        RUN DC with Script
#========================================================================

dc_shell-xg-t -64bit -f $workingFolder/scripts/synth_DC.tcl | tee $outFolder/$termianlOutFile


#========================================================================
#               find Begin & End of the critical path
#========================================================================

#read timing report file
echo "find start and stop points";
## extract start and end points
cat $timingFile | grep point > $outFolder/$CPATH_stsp_1

## extract start and end point names
nets=('start' 'end')
#clear file content
> $outFolder/$CPATH_stsp_2
while IFS=' ' read -r col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11 col12
do 
	#append
    	echo $col2 >> $outFolder/$CPATH_stsp_2
done < $outFolder/$CPATH_stsp_1

COUNTER=0
while IFS='_reg' read -r col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11 col12
do 
    	COUNTER=$((COUNTER+1));
	nets[$COUNTER]=$col1;
done < $outFolder/$CPATH_stsp_2

# Start Point
bgn_point=${nets[1]}
# End Point
end_point=${nets[2]}

echo "The critical path, is: [$bgn_point >--//--> $end_point] **";


#========================================================================
#                   find cells on the critical path
#========================================================================

#init files (clear if excist)
echo "finding Cells...";
> $outFolder/$CPATH_cellD;
> $outFolder/$CPATH_cells;

while IFS='/' read -r col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11 col12
do 	
	echo $col1 | grep '_$mul\|_$add' >> $outFolder/$CPATH_cellD;
done <timing.rep

cat $outFolder/$CPATH_cellD | grep '_$mul\|_$add' > $outFolder/$CPATH_cellD;

echo "removing dupplicate names...";
awk ' ! seen[$0]++' $outFolder/$CPATH_cellD  >> $outFolder/$CPATH_cells;

#move DC files to outputlocations
mv $timingFile $outFolder/$timingFile
mv $powerFile $outFolder/$powerFile
#remove extra files
rm $outFolder/$CPATH_cellD
rm $outFolder/$CPATH_stsp_1

echo
echo "DONE!"
echo
#========================================================================
#                                  Done
#========================================================================

##########################################################################
