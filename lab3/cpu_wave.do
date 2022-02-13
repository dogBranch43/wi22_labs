onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /cpu_test/delay
add wave -noupdate /cpu_test/clk
add wave -noupdate /cpu_test/rst
add wave -noupdate /cpu_test/cpu1/PC
add wave -noupdate /cpu_test/cpu1/ALUResult
add wave -noupdate /cpu_test/cpu1/read_data
add wave -noupdate /cpu_test/cpu1/ALUOp
add wave -noupdate /cpu_test/cpu1/writeEnable
add wave -noupdate /cpu_test/cpu1/ALUSrc
add wave -noupdate /cpu_test/cpu1/MemToReg
add wave -noupdate /cpu_test/cpu1/MemWrite
add wave -noupdate /cpu_test/cpu1/RegWrite
add wave -noupdate /cpu_test/cpu1/Reg2Loc
add wave -noupdate /cpu_test/cpu1/Rd
add wave -noupdate /cpu_test/cpu1/Rm
add wave -noupdate /cpu_test/cpu1/Rn
add wave -noupdate /cpu_test/cpu1/writeData
add wave -noupdate /cpu_test/cpu1/instruction
add wave -noupdate /cpu_test/cpu1/ip1/instruction
add wave -noupdate /cpu_test/cpu1/dp1/instruction
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4055872642 ps} 0}
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
WaveRestoreZoom {0 ps} {22627500 ns}
