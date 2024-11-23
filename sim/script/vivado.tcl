set PROJECT_NAME            FIR_filter
set DIR_OUTPUT              work

set COMMON_FILESET          src_common
set SIM_FILESET             src_sim

# Crate project directory
file mkdir $DIR_OUTPUT

# Crate project
create_project -force $PROJECT_NAME $DIR_OUTPUT/$PROJECT_NAME -part xc7a15tcsg324-3

# add source
create_fileset $COMMON_FILESET
add_files -norecurse ../../src/FIR.sv

add_files -norecurse ../../src/coe.txt
set coe_file [get_files ../../src/coe.txt]
set_property FILE_TYPE "Memory Initialization Files" $coe_file

# add simulation source
create_fileset $SIM_FILESET
add_files -norecurse ../src/tb.sv

set_property top tb [get_filesets sim_1]

# launch simulation
launch_simulation
start_gui