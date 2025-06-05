set_property PACKAGE_PIN D4 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]

set_property PACKAGE_PIN N11      [get_ports buz]
set_property IOSTANDARD LVCMOS33 [get_ports buz]
set_property PACKAGE_PIN T7      [get_ports beep_e]
set_property IOSTANDARD LVCMOS33 [get_ports beep_e]

set_property PACKAGE_PIN R5      [get_ports interesting]
set_property IOSTANDARD LVCMOS33 [get_ports interesting]

set_property PACKAGE_PIN T5      [get_ports random_sw]
set_property IOSTANDARD LVCMOS33 [get_ports random_sw]

set_property PACKAGE_PIN P4      [get_ports {speed[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {speed[1]}]

set_property PACKAGE_PIN N6      [get_ports {speed[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {speed[0]}]

## 行输出约束（低有效）##
# Row0
set_property PACKAGE_PIN N12      [get_ports {row_out[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {row_out[0]}]

# Row1
set_property PACKAGE_PIN P13      [get_ports {row_out[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {row_out[1]}]

# Row2
set_property PACKAGE_PIN T13      [get_ports {row_out[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {row_out[2]}]

# Row3
set_property PACKAGE_PIN R13      [get_ports {row_out[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {row_out[3]}]

## 列输入约束（上拉）##
# Col0
set_property PACKAGE_PIN T12      [get_ports {col_in[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {col_in[0]}]
set_property PULLUP true         [get_ports {col_in[0]}]

# Col1
set_property PACKAGE_PIN R12      [get_ports {col_in[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {col_in[1]}]
set_property PULLUP true         [get_ports {col_in[1]}]

# Col2
set_property PACKAGE_PIN P11      [get_ports {col_in[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {col_in[2]}]
set_property PULLUP true         [get_ports {col_in[2]}]

# Col3
set_property PACKAGE_PIN R11      [get_ports {col_in[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {col_in[3]}]
set_property PULLUP true         [get_ports {col_in[3]}]

## LED输出约束 ##
set_property IOSTANDARD LVCMOS33 [get_ports {led[*]}]
set_property PACKAGE_PIN M5      [get_ports {led[0]}]
set_property PACKAGE_PIN M4      [get_ports {led[1]}]
set_property PACKAGE_PIN M1      [get_ports {led[2]}]
set_property PACKAGE_PIN M2      [get_ports {led[3]}]
set_property PACKAGE_PIN N2      [get_ports {led[4]}]
set_property PACKAGE_PIN N1      [get_ports {led[5]}]
set_property PACKAGE_PIN N3      [get_ports {led[6]}]
set_property PACKAGE_PIN N4      [get_ports {led[7]}]
set_property PACKAGE_PIN P1      [get_ports {led[8]}]
set_property PACKAGE_PIN R1      [get_ports {led[9]}]
set_property PACKAGE_PIN R2      [get_ports {led[10]}]
set_property PACKAGE_PIN T2      [get_ports {led[11]}]
set_property PACKAGE_PIN P5      [get_ports {led[12]}]
set_property PACKAGE_PIN R3      [get_ports {led[13]}]
set_property PACKAGE_PIN T3      [get_ports {led[14]}]
set_property PACKAGE_PIN P3      [get_ports {led[15]}]

set_property PACKAGE_PIN G12 [get_ports {dig[5]}]
set_property PACKAGE_PIN K12 [get_ports {dig[4]}]
set_property PACKAGE_PIN K13 [get_ports {dig[3]}]
set_property PACKAGE_PIN C13 [get_ports {dig[0]}]
set_property PACKAGE_PIN L13 [get_ports {dig[1]}]
set_property PACKAGE_PIN L14 [get_ports {dig[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {dig[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {dig[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {dig[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {dig[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {dig[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {dig[5]}]
set_property PACKAGE_PIN G14 [get_ports {seg[0]}]
set_property PACKAGE_PIN G11 [get_ports {seg[1]}]
set_property PACKAGE_PIN H12 [get_ports {seg[2]}]
set_property PACKAGE_PIN H13 [get_ports {seg[3]}]
set_property PACKAGE_PIN H16 [get_ports {seg[4]}]
set_property PACKAGE_PIN H14 [get_ports {seg[5]}]
set_property PACKAGE_PIN J15 [get_ports {seg[6]}]
set_property PACKAGE_PIN J16 [get_ports {seg[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[0]}]

set_property PACKAGE_PIN R10 [get_ports CLR_L]
set_property PACKAGE_PIN P9 [get_ports start_stop]
set_property IOSTANDARD LVCMOS33 [get_ports CLR_L]
set_property IOSTANDARD LVCMOS33 [get_ports start_stop]
