# 8-bit ALU Physical Design

Gate-level netlist of an 8-bit ALU taken through floorplan, placement and routing
in OpenROAD using the ORFS sky130hd platform.

## Files
- alu8.v: RTL
- alu8_netlist.v: gate-level netlist (sky130hd)
- tb_alu8.v: testbench
- run.tcl: OpenROAD script (if present)

## Flow
Load LEF/liberty, read_verilog, link_design, floorplan, pdngen, placement, routing.
