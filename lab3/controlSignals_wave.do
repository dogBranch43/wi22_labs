onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /controlSignals_testbench/instruction
add wave -noupdate /controlSignals_testbench/dut/LDUR
add wave -noupdate /controlSignals_testbench/dut/ADDI
add wave -noupdate /controlSignals_testbench/dut/B
add wave -noupdate /controlSignals_testbench/dut/SUBS
add wave -noupdate /controlSignals_testbench/dut/EOR
add wave -noupdate /controlSignals_testbench/dut/CBZ
add wave -noupdate /controlSignals_testbench/dut/STUR
add wave -noupdate /controlSignals_testbench/dut/ADDS
add wave -noupdate /controlSignals_testbench/dut/LSR
add wave -noupdate /controlSignals_testbench/dut/AND
add wave -noupdate /controlSignals_testbench/dut/BLT
add wave -noupdate /controlSignals_testbench/zero
add wave -noupdate /controlSignals_testbench/negative
add wave -noupdate /controlSignals_testbench/carry_out
add wave -noupdate /controlSignals_testbench/overflow
add wave -noupdate /controlSignals_testbench/dut/Reg2Loc
add wave -noupdate /controlSignals_testbench/dut/ALUSrc
add wave -noupdate /controlSignals_testbench/dut/MemToReg
add wave -noupdate /controlSignals_testbench/dut/RegWrite
add wave -noupdate /controlSignals_testbench/dut/MemWrite
add wave -noupdate /controlSignals_testbench/dut/BrTaken
add wave -noupdate /controlSignals_testbench/dut/UncondBr
add wave -noupdate /controlSignals_testbench/dut/ALUOp
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
WaveRestoreZoom {0 ps} {33684 ps}
