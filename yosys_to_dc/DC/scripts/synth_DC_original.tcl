# Compile script for synopsys
#------------------------------------------------------------------------#
#  Command to run:                                                       #
#  cd /ubc/ece/home/ml/grads/aming/tmp/                                  #
#  dc_shell-xg-t -64bit -f /scripts/synth_DC.tcl                         #
#                                                                        #
#  OSU FreePDK 45nm                                                      #
#                                                                        #
#  Amin Ghasemazar - October 2016  contact:aming@ece.ubc.ca              #
#------------------------------------------------------------------------#


##########################################################################

#variables
#------------------------------------------------------------------------

# .v files, separated by spaces
set my_verilog_files [list inFiles/Yosys_to_DC.v inFiles/ETAIIM_parameter.v ]
#/* Top-level Module                               	*/
set my_toplevel ff_mult16appx
#/* The name of the clock pin. If no clock-pin exists, pick anything */
set my_clock_pin clk
#/* Target frequency in MHz for optimization       	*/
set my_clk_freq_MHz 600.0
#/* Delay of input signals (Clock-to-Q, Package etc.)  	*/
set my_input_delay_ns 0.1
#/* Reserved time for output signals (Holdtime etc.)   	*/
set my_output_delay_ns 0.1

set_host_options -max_cores 2


##########################################################################

#========================================================================
#                             INITIALIZE
#------------------------------------------------------------------------

# path 
#------------------------------------------------------------------------

## These point to the freePDK libraries. 
set PDK_DIR FreePDK45/
set OSU_FREEPDK [format "%s%s"  $PDK_DIR "/osu_soc/lib/files"]
set search_path [concat  $search_path $OSU_FREEPDK]

# search path 
#------------------------------------------------------------------------

# Can add to the search path if you have files in different directories (e.g. below)
#set search_path [concat  $search_path <path_to_dir1> <path_to_dir2>]

set alib_library_analysis_path $OSU_FREEPDK

## set the actual tech libraries (uses the search path)
set link_library [set target_library [concat  [list gscl45nm.db] [list dw_foundation.sldb]]]
set target_library "gscl45nm.db"

define_design_lib WORK -path ./WORK

#========================================================================
#                             ELABORATION
#------------------------------------------------------------------------

analyze -format verilog $my_verilog_files
elaborate $my_toplevel
current_design $my_toplevel

link
uniquify

# clk 
#------------------------------------------------------------------------

# set the period based off of your clock frequency. 
set my_period [expr 1000.0 / $my_clk_freq_MHz]

# creates the clock
set find_clock [ find port [list $my_clock_pin] ]
if {  $find_clock != [list] } {
   set clk_name $my_clock_pin
   create_clock -period $my_period $clk_name
} else {
   set clk_name vclk
   create_clock -period $my_period -name $clk_name
}

puts -nonewline "Clk freq: "
puts -nonewline $my_clk_freq_MHz
puts " MHz"

puts -nonewline "Clk period: "
puts -nonewline $my_period
puts " ns"

# Set switching activities for initial power estimation
# Set the switching activities for all of your input signals. Uses the clock instead of a custom period. 

set_switching_activity -static_probability 0.5 -toggle_rate 0.5 -base_clock $my_clock_pin aa
set_switching_activity -static_probability 0.5 -toggle_rate 0.5 -base_clock $my_clock_pin bb

# Don't touch the clock networks
set_dont_touch_network clk

#========================================================================
#                             COMPILATION
#------------------------------------------------------------------------

# Compile design - Ultra optimizations (see manpages for the parameters I used)
compile

# Check the design
check_design
report_constraint -all_violators

#========================================================================
#                             WRITE OUTPUT
#------------------------------------------------------------------------

# Dump output files
#------------------------------------------------------------------------
set filename [format "%s%s"  $my_toplevel ".vh"]
write -f verilog -output $filename

set sdcOutFile [format "%s%s"  $my_toplevel ".sdc"]
write_sdc $sdcOutFile

# amin eddit
#set filename [format "%s%s"  $my_toplevel ".db"]
#write -f db -hier -output $filename -xg_force_db

# Create netlist
#------------------------------------------------------------------------
write -hierarchy -format verilog -output netlist.v

# Write out the actual timing, area, and power estimates
#------------------------------------------------------------------------
redirect timing.rep { report_timing }
redirect cell.rep { report_cell }
redirect power.rep { report_power }

# Just lists the units used. Time is in ns, area is in um^2, and the power unit is explicitly stated
report_units

quit

#========================================================================
#                               DONE!
#------------------------------------------------------------------------

##########################################################################
