set arg1=%1
iverilog -o %arg1% "%arg1%.v"
vvp %arg1%
gtkwave "%arg1%.vcd"