# ----------------------------------------------------------------------------------------------------
# Copyright (c) 2023 by Enclustra GmbH, Switzerland.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this hardware, software, firmware, and associated documentation files (the
# "Product"), to deal in the Product without restriction, including without
# limitation the rights to use, copy, modify, merge, publish, distribute,
# sublicense, and/or sell copies of the Product, and to permit persons to whom the
# Product is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Product.
#
# THE PRODUCT IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
# PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
# HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# PRODUCT OR THE USE OR OTHER DEALINGS IN THE PRODUCT.
# ----------------------------------------------------------------------------------------------------

create_bd_design $module


create_bd_cell -type ip -vlnv xilinx.com:ip:zynq_ultra_ps_e zynq_ultra_ps_e
set_property -dict [ list \
  CONFIG.PSU_BANK_0_IO_STANDARD {LVCMOS18} \
  CONFIG.PSU_BANK_1_IO_STANDARD {LVCMOS18} \
  CONFIG.PSU_BANK_2_IO_STANDARD {LVCMOS18} \
  CONFIG.PSU_BANK_3_IO_STANDARD {LVCMOS18} \
] [get_bd_cells zynq_ultra_ps_e]
set_property -dict [ list \
  CONFIG.PSU__QSPI__PERIPHERAL__ENABLE {1} \
  CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__FREQMHZ {200} \
  CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__SRCSEL {RPLL} \
  CONFIG.PSU__QSPI__PERIPHERAL__DATA_MODE {x4} \
  CONFIG.PSU__SD0__PERIPHERAL__ENABLE {1} \
  CONFIG.PSU__SD0__SLOT_TYPE {eMMC} \
  CONFIG.PSU__SD0__PERIPHERAL__IO {MIO 13 .. 22} \
  CONFIG.PSU__SD0__DATA_TRANSFER_MODE {8Bit} \
  CONFIG.PSU__SD1__PERIPHERAL__ENABLE {1} \
  CONFIG.PSU__SD1__SLOT_TYPE {SD 2.0} \
  CONFIG.PSU__SD1__PERIPHERAL__IO {MIO 46 .. 51} \
  CONFIG.PSU__SD1__GRP_CD__ENABLE {1} \
  CONFIG.PSU__I2C0__PERIPHERAL__ENABLE {1} \
  CONFIG.PSU__I2C0__PERIPHERAL__IO {EMIO} \
  CONFIG.PSU__I2C1__PERIPHERAL__ENABLE {1} \
  CONFIG.PSU__I2C1__PERIPHERAL__IO {MIO 24 .. 25} \
  CONFIG.PSU__SPI1__PERIPHERAL__ENABLE {1} \
  CONFIG.PSU__UART0__PERIPHERAL__ENABLE {1} \
  CONFIG.PSU__UART0__PERIPHERAL__IO {MIO 38 .. 39} \
  CONFIG.PSU__TTC0__PERIPHERAL__ENABLE {1} \
  CONFIG.PSU__ENET0__GRP_MDIO__ENABLE {1} \
  CONFIG.PSU__ENET0__PERIPHERAL__ENABLE {1} \
  CONFIG.PSU__FPGA_PL1_ENABLE {1} \
  CONFIG.PSU__CRL_APB__PL1_REF_CTRL__FREQMHZ {50} \
  CONFIG.PSU__GPIO0_MIO__PERIPHERAL__ENABLE {1} \
  CONFIG.PSU__GPIO1_MIO__PERIPHERAL__ENABLE {1} \
  CONFIG.PSU__GPIO2_MIO__PERIPHERAL__ENABLE {1} \
  CONFIG.PSU_MIO_12_PULLUPDOWN {disable} \
] [get_bd_cells zynq_ultra_ps_e]

if { $PS_LPDDR == "PS_D9"} {
  set_property -dict [ list \
    CONFIG.PSU__DDRC__MEMORY_TYPE {LPDDR 4} \
    CONFIG.PSU__DDRC__SPEED_BIN {LPDDR4_2400} \
    CONFIG.PSU__DDRC__DEVICE_CAPACITY {4096 MBits} \
    CONFIG.PSU__DDRC__ROW_ADDR_COUNT {14} \
    CONFIG.PSU__DDRC__ENABLE_LP4_HAS_ECC_COMP {0} \
    CONFIG.PSU__DDRC__T_RCD {22} \
    CONFIG.PSU__DDRC__T_RP {26} \
    CONFIG.PSU__DDRC__T_RC {63} \
    CONFIG.PSU__DDRC__T_RAS_MIN {42} \
    CONFIG.PSU__DDRC__T_FAW {40} \
  ] [get_bd_cells zynq_ultra_ps_e]
}

if { $PS_LPDDR == "PS_D11"} {
  set_property -dict [ list \
    CONFIG.PSU__DDRC__MEMORY_TYPE {LPDDR 4} \
    CONFIG.PSU__DDRC__SPEED_BIN {LPDDR4_2400} \
    CONFIG.PSU__DDRC__DEVICE_CAPACITY {16384 MBits} \
    CONFIG.PSU__DDRC__ROW_ADDR_COUNT {16} \
    CONFIG.PSU__DDRC__ENABLE_LP4_HAS_ECC_COMP {0} \
    CONFIG.PSU__DDRC__T_RCD {22} \
    CONFIG.PSU__DDRC__T_RP {26} \
    CONFIG.PSU__DDRC__T_RC {63} \
    CONFIG.PSU__DDRC__T_RAS_MIN {42} \
    CONFIG.PSU__DDRC__T_FAW {40} \
  ] [get_bd_cells zynq_ultra_ps_e]
}

if { $USB == "USB"} {
  set_property -dict [ list \
    CONFIG.PSU__USB0__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__USB__RESET__MODE {Disable} \
    CONFIG.PSU__USB1__PERIPHERAL__ENABLE {1} \
  ] [get_bd_cells zynq_ultra_ps_e]
}

create_bd_cell -type ip -vlnv xilinx.com:ip:system_management_wiz system_management_wiz
set_property -dict [ list \
  CONFIG.TEMPERATURE_ALARM_OT_TRIGGER {85} \
  CONFIG.CHANNEL_ENABLE_VP_VN {false} \
] [get_bd_cells system_management_wiz]
set_property -dict [ list \
  CONFIG.PSU_MIO_13_PULLUPDOWN {disable} \
  CONFIG.PSU_MIO_14_PULLUPDOWN {disable} \
  CONFIG.PSU_MIO_15_PULLUPDOWN {disable} \
  CONFIG.PSU_MIO_16_PULLUPDOWN {disable} \
  CONFIG.PSU_MIO_17_PULLUPDOWN {disable} \
  CONFIG.PSU_MIO_18_PULLUPDOWN {disable} \
  CONFIG.PSU_MIO_19_PULLUPDOWN {disable} \
  CONFIG.PSU_MIO_20_PULLUPDOWN {disable} \
  CONFIG.PSU_MIO_21_PULLUPDOWN {disable} \
  CONFIG.PSU__SD0__PERIPHERAL__IO {MIO 13 .. 22} \
  CONFIG.PSU__SD0__DATA_TRANSFER_MODE {8Bit} \
] [get_bd_cells zynq_ultra_ps_e]
set_property -dict [ list \
  CONFIG.PSU__I2C0__PERIPHERAL__ENABLE {1} \
  CONFIG.PSU__I2C0__PERIPHERAL__IO {EMIO} \
] [get_bd_cells zynq_ultra_ps_e]

create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio led
set_property -dict [ list \
  CONFIG.C_GPIO_WIDTH {1} \
  CONFIG.C_ALL_OUTPUTS {1} \
  CONFIG.C_DOUT_DEFAULT {0x00000001} \
] [get_bd_cells led]

connect_bd_net [get_bd_pins zynq_ultra_ps_e/maxihpm0_lpd_aclk] [get_bd_pins zynq_ultra_ps_e/pl_clk0]
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 ps_sys_rst
connect_bd_net [get_bd_pins ps_sys_rst/slowest_sync_clk] [get_bd_pins zynq_ultra_ps_e/pl_clk0]
connect_bd_net [get_bd_pins ps_sys_rst/ext_reset_in] [get_bd_pins zynq_ultra_ps_e/pl_resetn0]
set IIC [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 IIC ]
connect_bd_intf_net [get_bd_intf_ports IIC] [get_bd_intf_pins zynq_ultra_ps_e/IIC_0]

create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect smartconnect_00
set_property -dict [list CONFIG.NUM_MI {2} CONFIG.NUM_CLKS {1} CONFIG.NUM_SI {1}] [get_bd_cells smartconnect_00]
connect_bd_intf_net [get_bd_intf_pins zynq_ultra_ps_e/M_AXI_HPM0_LPD] [get_bd_intf_pins smartconnect_00/S00_AXI]
connect_bd_net [get_bd_pins zynq_ultra_ps_e/pl_clk0] [get_bd_pins smartconnect_00/aclk]
connect_bd_net [get_bd_pins ps_sys_rst/interconnect_aresetn] [get_bd_pins smartconnect_00/aresetn]
connect_bd_intf_net [get_bd_intf_pins smartconnect_00/M00_AXI ] [get_bd_intf_pins system_management_wiz/S_AXI_LITE]
connect_bd_intf_net [get_bd_intf_pins smartconnect_00/M01_AXI ] [get_bd_intf_pins led/S_AXI]

connect_bd_net [get_bd_pins ps_sys_rst/peripheral_aresetn] [get_bd_pins system_management_wiz/s_axi_aresetn]
connect_bd_net [get_bd_pins zynq_ultra_ps_e/pl_clk0] [get_bd_pins system_management_wiz/s_axi_aclk]
connect_bd_net [get_bd_pins ps_sys_rst/peripheral_aresetn] [get_bd_pins led/s_axi_aresetn]
connect_bd_net [get_bd_pins zynq_ultra_ps_e/pl_clk0] [get_bd_pins led/s_axi_aclk]

set Clk100 [ create_bd_port -dir O -type clk Clk100]
connect_bd_net [get_bd_ports Clk100] [get_bd_pins zynq_ultra_ps_e/pl_clk0]
set Clk50 [ create_bd_port -dir O -type clk Clk50]
connect_bd_net [get_bd_ports Clk50] [get_bd_pins zynq_ultra_ps_e/pl_clk1]
set Rst_N [ create_bd_port -dir O -type rst Rst_N]
connect_bd_net [get_bd_ports Rst_N] [get_bd_pins zynq_ultra_ps_e/pl_resetn0]
set LED_N [ create_bd_port -dir O -from 0 -to 0 LED_N]
connect_bd_net [get_bd_ports LED_N] [get_bd_pins LED/gpio_io_o]
assign_bd_address
save_bd_design
validate_bd_design
save_bd_design
