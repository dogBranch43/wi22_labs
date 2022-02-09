onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /instructionPath_testbench/CLOCK_PERIOD
add wave -noupdate /instructionPath_testbench/instruction
add wave -noupdate /instructionPath_testbench/clk
add wave -noupdate /instructionPath_testbench/BrTaken
add wave -noupdate /instructionPath_testbench/UncondBr
add wave -noupdate /instructionPath_testbench/PC
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
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
