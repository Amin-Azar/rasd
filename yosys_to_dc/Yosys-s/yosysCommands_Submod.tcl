#!/usr/bin/tclsh
#------------------------------------------------------------------------#
#  Command to run:                                                       #
#  yosys> tcl /data/tmp/yosysCommands_Submod_original.tcl                #
#                                                                        #
#                                                                        #
#                                                                        #
#  Amin Ghasemazar - October 2016  contact:aming@ece.ubc.ca              #
#------------------------------------------------------------------------#


##########################################################################


#script starts here!
#------------------------------------------------------------------------

#imports yosys commands to tcl **{Except: cd, eval, rename, trace} & **{proc is procs in TCL Script!!}
yosys -import

#variables
#------------------------------------------------------------------------
set inputFile "/data/git/repos/benchmarks/custom/mult16appx/ff_mult16appx_2.v"
set workFolder "/data/tmp"
set DCfileName "Yosys_to_DC.v"
set mulsFile "muls.cnt"
set addsFile "adds.cnt"
set statFile "$workFolder/stats.log"
set statFileId [open $statFile "a"]

set brk "------------------------------------------------------------------------"


##########################################################################

#extract file name
#------------------------------------------------------------------------
set inFile [split $inputFile '/']
set fileEX [lindex $inFile end]
set fileName [split $fileEX '.']
set fileName [lindex $fileName 0]
puts "Input verilog file name is: [lindex $fileName 0]"


##########################################################################

#========================================================================
#                        READ and  PREPARE input
#------------------------------------------------------------------------
puts "read_verilog $inputFile"

read_verilog {*}$inputFile
prep -flatten
#write_verilog -noattr
write_verilog $workFolder/out_Yosys/$fileName\_flattened.v

# shell 
#------------------------------------------------------------------------
puts "\n\n\n\n\n========================================================================"
puts "                       >> Extraction - Yosys <<"
puts "========================================================================\n\n\n\n\n\n"


#========================================================================
#                       IDENTIFICATION - LOOP COUNT
#------------------------------------------------------------------------

puts "(Extract modules)"
puts "$brk\n"

#init
select *
#select -list


#ADD[+++++++++++++++++++++]
#selects all additions & print number of them to a file
select -set adds t:\$add
select -list @adds
tee -o $workFolder/out_Yosys/$addsFile select -count @adds
#read from file
set fp [open "$workFolder/out_Yosys/$addsFile" r]
set ad [read $fp]
close $fp
set splitted [split $ad]
set _adds_count [lindex $splitted 0]
puts "\nNumber of **adders** in design: $_adds_count"
puts -nonewline $statFileId "\nNumber of **adders** in design: $_adds_count"
puts "$brk"


#MUL[xxxxxxxxxxxxxxxxxxxxx]
#selects all multiplications & print number of them to afile
select -set muls t:\$mul
select -list @muls
tee -o $workFolder/out_Yosys/$mulsFile select -count @muls
#read from file
set fp [open "$workFolder/out_Yosys/$mulsFile" r]
set ml [read $fp]
close $fp
set splitted [split $ml]
set _muls_count [lindex $splitted 0]
puts "\nNumber of **multipliers** in design: $_muls_count"
puts -nonewline $statFileId "\nNumber of **multipliers** in design: $_muls_count"
puts "$brk\n"


#========================================================================
#                               SUBMODEULES
#------------------------------------------------------------------------
puts "\n\n\n\n\n"
puts "(Submodules)"


#ADD[+++++++++++++++++++++]
set i 0
while {$i < $_adds_count} {

puts $brk
puts "add_i= $i"
select @adds %R
select -list
#naming style
submod -name _\$add_$i\_
incr i
}

#MUL[xxxxxxxxxxxxxxxxxxxxx]
set j 0
while {$j < $_muls_count} {

puts $brk
puts "mul_i= $j"
select @muls %R
select -list
#naming style
submod -name _\$mul_$j\_
incr j
}

close $statFileId
puts $brk

#------------------------------------------------------------------------
#write_verilog -noattr
write_verilog $workFolder/out_Yosys/$fileName\_flattened_submod.v
write_verilog -noattr $workFolder/$DCfileName


#========================================================================
#                                  Done
#========================================================================

##########################################################################

#exit yosis
exit
