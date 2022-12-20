# Legal Notice: (C)2022 Altera Corporation. All rights reserved.  Your
# use of Altera Corporation's design tools, logic functions and other
# software and tools, and its AMPP partner logic functions, and any
# output files any of the foregoing (including device programming or
# simulation files), and any associated documentation or information are
# expressly subject to the terms and conditions of the Altera Program
# License Subscription Agreement or other applicable license agreement,
# including, without limitation, that your use is for the sole purpose
# of programming logic devices manufactured by Altera and sold by Altera
# or its authorized distributors.  Please refer to the applicable
# agreement for further details.

#**************************************************************
# Timequest JTAG clock definition
#   Uncommenting the following lines will define the JTAG
#   clock in TimeQuest Timing Analyzer
#**************************************************************

#create_clock -period 10MHz {altera_reserved_tck}
#set_clock_groups -asynchronous -group {altera_reserved_tck}

#**************************************************************
# Set TCL Path Variables 
#**************************************************************

set 	system_t1_nios2_gen2_0_cpu 	system_t1_nios2_gen2_0_cpu:*
set 	system_t1_nios2_gen2_0_cpu_oci 	system_t1_nios2_gen2_0_cpu_nios2_oci:the_system_t1_nios2_gen2_0_cpu_nios2_oci
set 	system_t1_nios2_gen2_0_cpu_oci_break 	system_t1_nios2_gen2_0_cpu_nios2_oci_break:the_system_t1_nios2_gen2_0_cpu_nios2_oci_break
set 	system_t1_nios2_gen2_0_cpu_ocimem 	system_t1_nios2_gen2_0_cpu_nios2_ocimem:the_system_t1_nios2_gen2_0_cpu_nios2_ocimem
set 	system_t1_nios2_gen2_0_cpu_oci_debug 	system_t1_nios2_gen2_0_cpu_nios2_oci_debug:the_system_t1_nios2_gen2_0_cpu_nios2_oci_debug
set 	system_t1_nios2_gen2_0_cpu_wrapper 	system_t1_nios2_gen2_0_cpu_debug_slave_wrapper:the_system_t1_nios2_gen2_0_cpu_debug_slave_wrapper
set 	system_t1_nios2_gen2_0_cpu_jtag_tck 	system_t1_nios2_gen2_0_cpu_debug_slave_tck:the_system_t1_nios2_gen2_0_cpu_debug_slave_tck
set 	system_t1_nios2_gen2_0_cpu_jtag_sysclk 	system_t1_nios2_gen2_0_cpu_debug_slave_sysclk:the_system_t1_nios2_gen2_0_cpu_debug_slave_sysclk
set 	system_t1_nios2_gen2_0_cpu_oci_path 	 [format "%s|%s" $system_t1_nios2_gen2_0_cpu $system_t1_nios2_gen2_0_cpu_oci]
set 	system_t1_nios2_gen2_0_cpu_oci_break_path 	 [format "%s|%s" $system_t1_nios2_gen2_0_cpu_oci_path $system_t1_nios2_gen2_0_cpu_oci_break]
set 	system_t1_nios2_gen2_0_cpu_ocimem_path 	 [format "%s|%s" $system_t1_nios2_gen2_0_cpu_oci_path $system_t1_nios2_gen2_0_cpu_ocimem]
set 	system_t1_nios2_gen2_0_cpu_oci_debug_path 	 [format "%s|%s" $system_t1_nios2_gen2_0_cpu_oci_path $system_t1_nios2_gen2_0_cpu_oci_debug]
set 	system_t1_nios2_gen2_0_cpu_jtag_tck_path 	 [format "%s|%s|%s" $system_t1_nios2_gen2_0_cpu_oci_path $system_t1_nios2_gen2_0_cpu_wrapper $system_t1_nios2_gen2_0_cpu_jtag_tck]
set 	system_t1_nios2_gen2_0_cpu_jtag_sysclk_path 	 [format "%s|%s|%s" $system_t1_nios2_gen2_0_cpu_oci_path $system_t1_nios2_gen2_0_cpu_wrapper $system_t1_nios2_gen2_0_cpu_jtag_sysclk]
set 	system_t1_nios2_gen2_0_cpu_jtag_sr 	 [format "%s|*sr" $system_t1_nios2_gen2_0_cpu_jtag_tck_path]

set 	system_t1_nios2_gen2_0_cpu_oci_im 	system_t1_nios2_gen2_0_cpu_nios2_oci_im:the_system_t1_nios2_gen2_0_cpu_nios2_oci_im
set 	system_t1_nios2_gen2_0_cpu_oci_traceram 	system_t1_nios2_gen2_0_cpu_traceram_lpm_dram_bdp_component_module:system_t1_nios2_gen2_0_cpu_traceram_lpm_dram_bdp_component
set 	system_t1_nios2_gen2_0_cpu_oci_itrace 	system_t1_nios2_gen2_0_cpu_nios2_oci_itrace:the_system_t1_nios2_gen2_0_cpu_nios2_oci_itrace
set 	system_t1_nios2_gen2_0_cpu_oci_im_path 	 [format "%s|%s" $system_t1_nios2_gen2_0_cpu_oci_path $system_t1_nios2_gen2_0_cpu_oci_im]
set 	system_t1_nios2_gen2_0_cpu_oci_itrace_path 	 [format "%s|%s" $system_t1_nios2_gen2_0_cpu_oci_path $system_t1_nios2_gen2_0_cpu_oci_itrace]
set 	system_t1_nios2_gen2_0_cpu_traceram_path 	 [format "%s|%s" $system_t1_nios2_gen2_0_cpu_oci_im_path $system_t1_nios2_gen2_0_cpu_oci_traceram]

#**************************************************************
# Set False Paths
#**************************************************************

set_false_path -from [get_keepers *$system_t1_nios2_gen2_0_cpu_oci_break_path|break_readreg*] -to [get_keepers *$system_t1_nios2_gen2_0_cpu_jtag_sr*]
set_false_path -from [get_keepers *$system_t1_nios2_gen2_0_cpu_oci_debug_path|*resetlatch]     -to [get_keepers *$system_t1_nios2_gen2_0_cpu_jtag_sr[33]]
set_false_path -from [get_keepers *$system_t1_nios2_gen2_0_cpu_oci_debug_path|monitor_ready]  -to [get_keepers *$system_t1_nios2_gen2_0_cpu_jtag_sr[0]]
set_false_path -from [get_keepers *$system_t1_nios2_gen2_0_cpu_oci_debug_path|monitor_error]  -to [get_keepers *$system_t1_nios2_gen2_0_cpu_jtag_sr[34]]
set_false_path -from [get_keepers *$system_t1_nios2_gen2_0_cpu_ocimem_path|*MonDReg*] -to [get_keepers *$system_t1_nios2_gen2_0_cpu_jtag_sr*]
set_false_path -from *$system_t1_nios2_gen2_0_cpu_jtag_sr*    -to *$system_t1_nios2_gen2_0_cpu_jtag_sysclk_path|*jdo*
set_false_path -from sld_hub:*|irf_reg* -to *$system_t1_nios2_gen2_0_cpu_jtag_sysclk_path|ir*
set_false_path -from sld_hub:*|sld_shadow_jsm:shadow_jsm|state[1] -to *$system_t1_nios2_gen2_0_cpu_oci_debug_path|monitor_go

set_false_path -from [get_keepers *$system_t1_nios2_gen2_0_cpu_traceram_path*address*] -to [get_keepers *$system_t1_nios2_gen2_0_cpu_jtag_sr*]
set_false_path -from [get_keepers *$system_t1_nios2_gen2_0_cpu_traceram_path*we_reg*] -to [get_keepers *$system_t1_nios2_gen2_0_cpu_jtag_sr*]
set_false_path -from [get_keepers *$system_t1_nios2_gen2_0_cpu_oci_im_path|*trc_im_addr*] -to [get_keepers *$system_t1_nios2_gen2_0_cpu_jtag_sr*]
set_false_path -from [get_keepers *$system_t1_nios2_gen2_0_cpu_oci_im_path|*trc_wrap] -to [get_keepers *$system_t1_nios2_gen2_0_cpu_jtag_sr*]
set_false_path -from [get_keepers *$system_t1_nios2_gen2_0_cpu_oci_itrace_path|trc_ctrl_reg*] -to [get_keepers *$system_t1_nios2_gen2_0_cpu_jtag_sr*]
set_false_path -from [get_keepers *$system_t1_nios2_gen2_0_cpu_oci_itrace_path|debugack] -to [get_keepers *$system_t1_nios2_gen2_0_cpu_jtag_sr*]
