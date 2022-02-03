onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /nor_in64_testbench/in
add wave -noupdate /nor_in64_testbench/dut/zeroFlag
add wave -noupdate -expand /nor_in64_testbench/dut/temp
add wave -noupdate /nor_in64_testbench/dut/norCheck
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {18292 ps} 0}
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
WaveRestoreZoom {0 ps} {178500 ps}
