onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /dataPath_testbench/dut/instruction
add wave -noupdate /dataPath_testbench/Rd
add wave -noupdate /dataPath_testbench/Rm
add wave -noupdate /dataPath_testbench/Rn
add wave -noupdate /dataPath_testbench/ALUSrc
add wave -noupdate /dataPath_testbench/Reg2Loc
add wave -noupdate /dataPath_testbench/RegWrite
add wave -noupdate /dataPath_testbench/MemWrite
add wave -noupdate /dataPath_testbench/MemToReg
add wave -noupdate /dataPath_testbench/ALUOp
add wave -noupdate /dataPath_testbench/WriteData
add wave -noupdate /dataPath_testbench/result
add wave -noupdate /dataPath_testbench/dut/dm1/address
add wave -noupdate /dataPath_testbench/dut/dm1/write_enable
add wave -noupdate /dataPath_testbench/dut/dm1/read_enable
add wave -noupdate /dataPath_testbench/dut/dm1/write_data
add wave -noupdate /dataPath_testbench/dut/dm1/clk
add wave -noupdate /dataPath_testbench/dut/dm1/xfer_size
add wave -noupdate /dataPath_testbench/dut/dm1/read_data
add wave -noupdate /dataPath_testbench/dut/dm1/aligned_address
add wave -noupdate /dataPath_testbench/dut/dm1/i
add wave -noupdate /dataPath_testbench/dut/dm1/j
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {11020047 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {52500 ns}
