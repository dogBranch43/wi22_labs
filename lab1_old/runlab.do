# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.
vlog "./multiplexor2to1.sv"
vlog "./multiplexor4to1.sv"
vlog "./multiplexor16to1.sv"
vlog "./multiplexor32to1.sv"
vlog "./multiplexor64of32to1.sv"
vlog "./decoder1to2.sv"
vlog "./decoder2to4.sv"
vlog "./decoder4to16.sv"
vlog "./decoder5to32.sv"
vlog "./D_FF.sv"
vlog "./regfile.sv"
vlog "./regstim.sv"

# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
vsim -voptargs="+acc" -t 1ps -lib work regstim

# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
do regstim_wave.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End
