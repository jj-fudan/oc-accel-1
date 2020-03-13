open_project "hlsUpperCase_xcvu33p-fsvh2104-2-e"

set_top hls_action

# Can that be a list?
foreach file [ list action_uppercase.cpp  ] {
  add_files ${file} -cflags " -I/home/jjiao/oc-accel/actions/include -I/home/jjiao/oc-accel/software/include -I../../../software/examples -I../include"
  add_files -tb ${file} -cflags " -DNO_SYNTH -I/home/jjiao/oc-accel/actions/include -I/home/jjiao/oc-accel/software/include -I../../../software/examples -I../include"
}

open_solution "helloworld"
set_part xcvu33p-fsvh2104-2-e

create_clock -period 4 -name default
config_interface -m_axi_addr64=true
#config_rtl -reset all -reset_level low

csynth_design
#export_design -format ip_catalog -rtl vhdl
exit
