# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.
vlog "./controlSignals.sv"
vlog "./instructionPath.sv"
vlog "./signExtender.sv"
vlog "./DFFs_64.sv"
vlog "./mux64_2to1.sv"
vlog "./fullAdder_64bit.sv"
vlog "./multiplexor2to1.sv"
vlog "./fullAdder.sv"
vlog "./D_FF.sv"
vlog "./cpu.sv"
vlog "./zeroExtender.sv"
vlog "./fullAdder.sv"
vlog "./datamem.sv"
vlog "./dataPath.sv"


vlog "./registers/regfile.sv"

vlog "./multiplexors/multiplexor4to1.sv"
vlog "./multiplexors/multiplexor8to1.sv"
vlog "./multiplexors/multiplexor16to1.sv"
vlog "./multiplexors/multiplexor32to1.sv"
vlog "./multiplexors/multiplexor64of32to1.sv"

vlog "./alu/nor_in64.sv"
vlog "./alu/math.sv"
vlog "./alu/alu_1bit_slice.sv"
vlog "./alu/alu.sv"

vlog "./decoders/decoder5to32.sv"
vlog "./decoders/decoder4to16.sv"
vlog "./decoders/decoder2to4.sv"
vlog "./decoders/decoder1to2.sv"

# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
vsim -voptargs="+acc" -t 1ps -lib work cpu_test

# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
do cpu_wave.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End