#!/usr/bin/tclsh

#------------------------------------------------------------------------#
#  Command to run:                                                       #
#  yosys>tcl /data/git/repos/Yosys/yosysCommands_Repalce_add_original.tcl#
#                                                                        #
#                                                                        #
#                                                                        #
#  Amin Ghasemazar - October 2016  contact:aming@ece.ubc.ca              #
#------------------------------------------------------------------------#


##########################################################################


#imports yosys commands to tcl **{Except: cd, eval, rename, trace} & **{proc is procs in TCL Script!!}
yosys -import


#variables
#------------------------------------------------------------------------
set toolsFolder "/data/git/repos/Yosys"
set inputFile "/data/tmp/Yosys_to_DC.v"
set workFolder "/data/tmp"
set DCfileName "Yosys_to_DC.v"

set brk "------------------------------------------------------------------------"

set loopIdx 1

##########################################################################

#extract file name
set inFile [split $inputFile '/']
set fileEX [lindex $inFile end]
set fileName [split $fileEX '.']
set fileName [lindex $fileName 0]
puts "Input verilog file name is: [lindex $fileName 0]"


##########################################################################

#========================================================================
#                        READ and  PREPARE input
#------------------------------------------------------------------------
read_verilog {*}$inputFile
prep
#write_verilog -noattr
write_verilog $workFolder/out_Yosys/$fileName\_loop$loopIdx\_before.v

#------------------------------------------------------------------------
puts "\n\n\n\n\n========================================================================"
puts "                         >> tcl_to_Yosys <<"
puts "========================================================================\n\n\n\n\n\n"


#========================================================================
#                         SELECTION - LOOP COUNT
#------------------------------------------------------------------------
puts "(Selection)"
puts "$brk\n"

#init
select *

#ADD[+++++++++++++++++++++]
#selects all additions & print number of them to a file

tcl  $toolsFolder/moduleSelection.tcl

puts "$brk\n"
puts ">>>>> These are going to be mapped:"
select -list

puts "$brk\n"

#========================================================================
#                               REPLACE
#------------------------------------------------------------------------
puts "\n\n\n\n\n"
puts "(Replace)"

#setparam -type "ETAIIM32"
techmap -map $toolsFolder/add_map.v

puts $brk

#------------------------------------------------------------------------
#write_verilog -noattr
write_verilog $workFolder/out_Yosys/$fileName\_loop$loopIdx.v
write_verilog -noattr $workFolder/$DCfileName

#========================================================================
#                                  Done
#========================================================================

##########################################################################

#exit yosis
exit
