onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /controlSignals_testbench/instruction
add wave -noupdate /controlSignals_testbench/zero
add wave -noupdate /controlSignals_testbench/negative
add wave -noupdate /controlSignals_testbench/carry_out
add wave -noupdate /controlSignals_testbench/overflow
add wave -noupdate /controlSignals_testbench/Reg2Loc
add wave -noupdate /controlSignals_testbench/ALUSrc
add wave -noupdate /controlSignals_testbench/MemToReg
add wave -noupdate /controlSignals_testbench/RegWrite
add wave -noupdate /controlSignals_testbench/MemWrite
add wave -noupdate /controlSignals_testbench/BrTaken
add wave -noupdate /controlSignals_testbench/UncondBr
add wave -noupdate /controlSignals_testbench/ALUOp
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
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
WaveRestoreZoom {0 ps} {1 ns}
