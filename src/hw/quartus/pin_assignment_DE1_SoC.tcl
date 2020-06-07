###############################################################################
# pin_assignment_DE1_SoC.tcl
#
# BOARD         : DE1-SoC from Terasic
# Author        : Sahand Kashani-Akhavan from Terasic documentation
# Revision      : 1.2
# Creation date : 04/02/2015
# Modification	 : 06/04/2017 RB Change xx_[b] --> xx[b] OR xx_D[b] for GPIO_0_D[b] and GPIO_1_D[b]
#                               depending on the tools single bit should be:  xxxb or xxx[b], thus both names are provided in this file
#
# Syntax Rule : GROUP_NAME_N[bit]
#
# GROUP  : specify a particular interface (ex: SDR_)
# NAME   : signal name (ex: CONFIG, D, ...)
# bit    : signal index
# _N     : to specify an active-low signal
#
# You can run this script from Quartus by observing the following steps:
# 1. Place this TCL script in your project directory
# 2. Open your project in Quartus
# 3. Go to the View > Utility Windows -> Tcl Console
# 4. In the Tcl Console type:
#        source pin_assignment_DE1_SoC.tcl
#
# 5. The script will assign pins and return an "assignment made" message.
###############################################################################

set_global_assignment -name FAMILY "Cyclone V"
set_global_assignment -name DEVICE 5CSEMA5F31C6
set_global_assignment -name DEVICE_FILTER_PACKAGE FBGA
set_global_assignment -name DEVICE_FILTER_PIN_COUNT 896
set_global_assignment -name DEVICE_FILTER_SPEED_GRADE 6


#============================================================
# CLOCK
#============================================================
set_location_assignment PIN_AF14 -to CLOCK_50
set_location_assignment PIN_AA16 -to CLOCK2_50
set_location_assignment PIN_Y26  -to CLOCK3_50
set_location_assignment PIN_K14  -to CLOCK4_50

set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CLOCK_50
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CLOCK2_50
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CLOCK3_50
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CLOCK4_50

#============================================================
# ADC, SPI
#============================================================
set_location_assignment PIN_AJ4 -to ADC_CS_N
set_location_assignment PIN_AK4 -to ADC_DIN
set_location_assignment PIN_AK3 -to ADC_DOUT
set_location_assignment PIN_AK2 -to ADC_SCLK

set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to ADC_CS_N
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to ADC_DIN
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to ADC_DOUT
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to ADC_SCLK

#============================================================
# Audio
#============================================================
set_location_assignment PIN_K7 -to AUD_ADCDAT
set_location_assignment PIN_K8 -to AUD_ADCLRCK
set_location_assignment PIN_H7 -to AUD_BCLK
set_location_assignment PIN_J7 -to AUD_DACDAT
set_location_assignment PIN_H8 -to AUD_DACLRCK
set_location_assignment PIN_G7 -to AUD_XCK

set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to AUD_ADCDAT
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to AUD_ADCLRCK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to AUD_BCLK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to AUD_DACDAT
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to AUD_DACLRCK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to AUD_XCK

#============================================================
# SDRAM on the board, from FPGA part, need a softcore controller
#============================================================
set_location_assignment PIN_AH12 -to DRAM_CLK
set_location_assignment PIN_AK13 -to DRAM_CKE

set_location_assignment PIN_AG11 -to DRAM_CS_N
set_location_assignment PIN_AE13 -to DRAM_RAS_N
set_location_assignment PIN_AF11 -to DRAM_CAS_N
set_location_assignment PIN_AA13 -to DRAM_WE_N
set_location_assignment PIN_AB13 -to DRAM_LDQM
set_location_assignment PIN_AK12 -to DRAM_UDQM

set_location_assignment PIN_AK14 -to DRAM_ADDR[0]
set_location_assignment PIN_AK14 -to DRAM_ADDR0
set_location_assignment PIN_AH14 -to DRAM_ADDR[1]
set_location_assignment PIN_AH14 -to DRAM_ADDR1
set_location_assignment PIN_AG15 -to DRAM_ADDR[2]
set_location_assignment PIN_AG15 -to DRAM_ADDR2
set_location_assignment PIN_AE14 -to DRAM_ADDR[3]
set_location_assignment PIN_AE14 -to DRAM_ADDR3
set_location_assignment PIN_AB15 -to DRAM_ADDR[4]
set_location_assignment PIN_AB15 -to DRAM_ADDR4
set_location_assignment PIN_AC14 -to DRAM_ADDR[5]
set_location_assignment PIN_AC14 -to DRAM_ADDR5
set_location_assignment PIN_AD14 -to DRAM_ADDR[6]
set_location_assignment PIN_AD14 -to DRAM_ADDR6
set_location_assignment PIN_AF15 -to DRAM_ADDR[7]
set_location_assignment PIN_AF15 -to DRAM_ADDR7
set_location_assignment PIN_AH15 -to DRAM_ADDR[8]
set_location_assignment PIN_AH15 -to DRAM_ADDR8
set_location_assignment PIN_AG13 -to DRAM_ADDR[9]
set_location_assignment PIN_AG13 -to DRAM_ADDR9
set_location_assignment PIN_AG12 -to DRAM_ADDR[10]
set_location_assignment PIN_AG12 -to DRAM_ADDR10
set_location_assignment PIN_AH13 -to DRAM_ADDR[11]
set_location_assignment PIN_AH13 -to DRAM_ADDR11
set_location_assignment PIN_AJ14 -to DRAM_ADDR[12]
set_location_assignment PIN_AJ14 -to DRAM_ADDR12
set_location_assignment PIN_AF13 -to DRAM_BA[0]
set_location_assignment PIN_AF13 -to DRAM_BA0
set_location_assignment PIN_AJ12 -to DRAM_BA[1]
set_location_assignment PIN_AJ12 -to DRAM_BA1

set_location_assignment PIN_AK6  -to DRAM_DQ[0]
set_location_assignment PIN_AK6  -to DRAM_DQ0
set_location_assignment PIN_AJ7  -to DRAM_DQ[1]
set_location_assignment PIN_AJ7  -to DRAM_DQ1
set_location_assignment PIN_AK7  -to DRAM_DQ[2]
set_location_assignment PIN_AK7  -to DRAM_DQ2
set_location_assignment PIN_AK8  -to DRAM_DQ[3]
set_location_assignment PIN_AK8  -to DRAM_DQ3
set_location_assignment PIN_AK9  -to DRAM_DQ[4]
set_location_assignment PIN_AK9  -to DRAM_DQ4
set_location_assignment PIN_AG10 -to DRAM_DQ[5]
set_location_assignment PIN_AG10 -to DRAM_DQ5
set_location_assignment PIN_AK11 -to DRAM_DQ[6]
set_location_assignment PIN_AK11 -to DRAM_DQ6
set_location_assignment PIN_AJ11 -to DRAM_DQ[7]
set_location_assignment PIN_AJ11 -to DRAM_DQ7
set_location_assignment PIN_AH10 -to DRAM_DQ[8]
set_location_assignment PIN_AH10 -to DRAM_DQ8
set_location_assignment PIN_AJ10 -to DRAM_DQ[9]
set_location_assignment PIN_AJ10 -to DRAM_DQ9
set_location_assignment PIN_AJ9  -to DRAM_DQ[10]
set_location_assignment PIN_AJ9  -to DRAM_DQ10
set_location_assignment PIN_AH9  -to DRAM_DQ[11]
set_location_assignment PIN_AH9  -to DRAM_DQ11
set_location_assignment PIN_AH8  -to DRAM_DQ[12]
set_location_assignment PIN_AH8  -to DRAM_DQ12
set_location_assignment PIN_AH7  -to DRAM_DQ[13]
set_location_assignment PIN_AH7  -to DRAM_DQ13
set_location_assignment PIN_AJ6  -to DRAM_DQ[14]
set_location_assignment PIN_AJ6  -to DRAM_DQ14
set_location_assignment PIN_AJ5  -to DRAM_DQ[15]
set_location_assignment PIN_AJ5  -to DRAM_DQ15


set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_CLK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_CKE

set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_CS_N
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_RAS_N
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_CAS_N
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_WE_N
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_LDQM
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_UDQM

set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR0
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR1
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR2
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR3
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR4
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR5
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR6
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR7
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR[8]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR8
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR[9]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR9
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR[10]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR10
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR[11]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR11
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR[12]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR12
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_BA[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_BA0
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_BA[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_BA1

set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ0
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ1
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ2
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ3
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ4
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ5
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ6
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ7
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[8]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ8
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[9]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ9
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[10]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ10
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[11]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ11
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[12]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ12
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[13]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ13
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[14]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ14
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[15]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ15


#============================================================
# I2C for Audio and Video-In  on the board
#============================================================
set_location_assignment PIN_J12 -to FPGA_I2C_SCLK
set_location_assignment PIN_K12 -to FPGA_I2C_SDAT

set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FPGA_I2C_SCLK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FPGA_I2C_SDAT

#============================================================
# SEG7  on the board
#============================================================
set_location_assignment PIN_AE26 -to HEX0_N[0]
set_location_assignment PIN_AE26 -to HEX0_N0
set_location_assignment PIN_AE27 -to HEX0_N[1]
set_location_assignment PIN_AE27 -to HEX0_N1
set_location_assignment PIN_AE28 -to HEX0_N[2]
set_location_assignment PIN_AE28 -to HEX0_N2
set_location_assignment PIN_AG27 -to HEX0_N[3]
set_location_assignment PIN_AG27 -to HEX0_N3
set_location_assignment PIN_AF28 -to HEX0_N[4]
set_location_assignment PIN_AF28 -to HEX0_N4
set_location_assignment PIN_AG28 -to HEX0_N[5]
set_location_assignment PIN_AG28 -to HEX0_N5
set_location_assignment PIN_AH28 -to HEX0_N[6]
set_location_assignment PIN_AH28 -to HEX0_N6
set_location_assignment PIN_AJ29 -to HEX1_N[0]
set_location_assignment PIN_AJ29 -to HEX1_N0
set_location_assignment PIN_AH29 -to HEX1_N[1]
set_location_assignment PIN_AH29 -to HEX1_N1
set_location_assignment PIN_AH30 -to HEX1_N[2]
set_location_assignment PIN_AH30 -to HEX1_N2
set_location_assignment PIN_AG30 -to HEX1_N[3]
set_location_assignment PIN_AG30 -to HEX1_N3
set_location_assignment PIN_AF29 -to HEX1_N[4]
set_location_assignment PIN_AF29 -to HEX1_N4
set_location_assignment PIN_AF30 -to HEX1_N[5]
set_location_assignment PIN_AF30 -to HEX1_N5
set_location_assignment PIN_AD27 -to HEX1_N[6]
set_location_assignment PIN_AD27 -to HEX1_N6
set_location_assignment PIN_AB23 -to HEX2_N[0]
set_location_assignment PIN_AB23 -to HEX2_N0
set_location_assignment PIN_AE29 -to HEX2_N[1]
set_location_assignment PIN_AE29 -to HEX2_N1
set_location_assignment PIN_AD29 -to HEX2_N[2]
set_location_assignment PIN_AD29 -to HEX2_N2
set_location_assignment PIN_AC28 -to HEX2_N[3]
set_location_assignment PIN_AC28 -to HEX2_N3
set_location_assignment PIN_AD30 -to HEX2_N[4]
set_location_assignment PIN_AD30 -to HEX2_N4
set_location_assignment PIN_AC29 -to HEX2_N[5]
set_location_assignment PIN_AC29 -to HEX2_N5
set_location_assignment PIN_AC30 -to HEX2_N[6]
set_location_assignment PIN_AC30 -to HEX2_N6
set_location_assignment PIN_AD26 -to HEX3_N[0]
set_location_assignment PIN_AD26 -to HEX3_N0
set_location_assignment PIN_AC27 -to HEX3_N[1]
set_location_assignment PIN_AC27 -to HEX3_N1
set_location_assignment PIN_AD25 -to HEX3_N[2]
set_location_assignment PIN_AD25 -to HEX3_N2
set_location_assignment PIN_AC25 -to HEX3_N[3]
set_location_assignment PIN_AC25 -to HEX3_N3
set_location_assignment PIN_AB28 -to HEX3_N[4]
set_location_assignment PIN_AB28 -to HEX3_N4
set_location_assignment PIN_AB25 -to HEX3_N[5]
set_location_assignment PIN_AB25 -to HEX3_N5
set_location_assignment PIN_AB22 -to HEX3_N[6]
set_location_assignment PIN_AB22 -to HEX3_N6
set_location_assignment PIN_AA24 -to HEX4_N[0]
set_location_assignment PIN_AA24 -to HEX4_N0
set_location_assignment PIN_Y23  -to HEX4_N[1]
set_location_assignment PIN_Y23  -to HEX4_N1
set_location_assignment PIN_Y24  -to HEX4_N[2]
set_location_assignment PIN_Y24  -to HEX4_N2
set_location_assignment PIN_W22  -to HEX4_N[3]
set_location_assignment PIN_W22  -to HEX4_N3
set_location_assignment PIN_W24  -to HEX4_N[4]
set_location_assignment PIN_W24  -to HEX4_N4
set_location_assignment PIN_V23  -to HEX4_N[5]
set_location_assignment PIN_V23  -to HEX4_N5
set_location_assignment PIN_W25  -to HEX4_N[6]
set_location_assignment PIN_W25  -to HEX4_N6
set_location_assignment PIN_V25  -to HEX5_N[0]
set_location_assignment PIN_V25  -to HEX5_N0
set_location_assignment PIN_AA28 -to HEX5_N[1]
set_location_assignment PIN_AA28 -to HEX5_N1
set_location_assignment PIN_Y27  -to HEX5_N[2]
set_location_assignment PIN_Y27  -to HEX5_N2
set_location_assignment PIN_AB27 -to HEX5_N[3]
set_location_assignment PIN_AB27 -to HEX5_N3
set_location_assignment PIN_AB26 -to HEX5_N[4]
set_location_assignment PIN_AB26 -to HEX5_N4
set_location_assignment PIN_AA26 -to HEX5_N[5]
set_location_assignment PIN_AA26 -to HEX5_N5
set_location_assignment PIN_AA25 -to HEX5_N[6]
set_location_assignment PIN_AA25 -to HEX5_N6

set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX0_N[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX0_N0
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX0_N[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX0_N1
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX0_N[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX0_N2
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX0_N[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX0_N3
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX0_N[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX0_N4
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX0_N[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX0_N5
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX0_N[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX0_N6
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX1_N[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX1_N0
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX1_N[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX1_N1
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX1_N[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX1_N2
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX1_N[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX1_N3
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX1_N[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX1_N4
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX1_N[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX1_N5
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX1_N[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX1_N6
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX2_N[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX2_N0
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX2_N[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX2_N1
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX2_N[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX2_N2
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX2_N[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX2_N3
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX2_N[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX2_N4
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX2_N[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX2_N5
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX2_N[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX2_N6
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX3_N[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX3_N0
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX3_N[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX3_N1
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX3_N[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX3_N2
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX3_N[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX3_N3
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX3_N[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX3_N4
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX3_N[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX3_N5
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX3_N[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX3_N6
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX4_N[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX4_N0
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX4_N[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX4_N1
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX4_N[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX4_N2
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX4_N[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX4_N3
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX4_N[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX4_N4
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX4_N[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX4_N5
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX4_N[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX4_N6
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX5_N[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX5_N0
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX5_N[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX5_N1
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX5_N[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX5_N2
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX5_N[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX5_N3
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX5_N[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX5_N4
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX5_N[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX5_N5
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX5_N[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX5_N6

#============================================================
# IR on the board
#============================================================
set_location_assignment PIN_AA30 -to IRDA_RXD
set_location_assignment PIN_AB30 -to IRDA_TXD

set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to IRDA_RXD
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to IRDA_TXD

#============================================================
# KEY_N on the board
#============================================================
set_location_assignment PIN_AA14 -to KEY_N[0]
set_location_assignment PIN_AA14 -to KEY_N0
set_location_assignment PIN_AA15 -to KEY_N[1]
set_location_assignment PIN_AA15 -to KEY_N1
set_location_assignment PIN_W15  -to KEY_N[2]
set_location_assignment PIN_W15  -to KEY_N2
set_location_assignment PIN_Y16  -to KEY_N[3]
set_location_assignment PIN_Y16  -to KEY_N3

set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to KEY_N[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to KEY_N0
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to KEY_N[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to KEY_N1
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to KEY_N[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to KEY_N2
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to KEY_N[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to KEY_N3

#============================================================
# LEDs on the board
#============================================================
set_location_assignment PIN_V16 -to LEDR[0]
set_location_assignment PIN_V16 -to LEDR_0
set_location_assignment PIN_W16 -to LEDR[1]
set_location_assignment PIN_W16 -to LEDR_1
set_location_assignment PIN_V17 -to LEDR[2]
set_location_assignment PIN_V17 -to LEDR_2
set_location_assignment PIN_V18 -to LEDR[3]
set_location_assignment PIN_V18 -to LEDR_3
set_location_assignment PIN_W17 -to LEDR[4]
set_location_assignment PIN_W17 -to LEDR_4
set_location_assignment PIN_W19 -to LEDR[5]
set_location_assignment PIN_W19 -to LEDR_5
set_location_assignment PIN_Y19 -to LEDR[6]
set_location_assignment PIN_Y19 -to LEDR_6
set_location_assignment PIN_W20 -to LEDR[7]
set_location_assignment PIN_W20 -to LEDR_7
set_location_assignment PIN_W21 -to LEDR[8]
set_location_assignment PIN_W21 -to LEDR_8
set_location_assignment PIN_Y21 -to LEDR[9]
set_location_assignment PIN_Y21 -to LEDR_9

set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR_0
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR_1
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR_2
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR_3
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR_4
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR_5
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR_6
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR_7
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[8]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR_8
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[9]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR_9

#============================================================
# PS2 on the board
#============================================================
set_location_assignment PIN_AD7 -to PS2_CLK
set_location_assignment PIN_AD9 -to PS2_CLK2
set_location_assignment PIN_AE7 -to PS2_DAT
set_location_assignment PIN_AE9 -to PS2_DAT2

set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to PS2_CLK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to PS2_CLK2
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to PS2_DAT
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to PS2_DAT2

#============================================================
# SW  on the board
#============================================================
set_location_assignment PIN_AB12 -to SW[0]
set_location_assignment PIN_AB12 -to SW_0
set_location_assignment PIN_AC12 -to SW[1]
set_location_assignment PIN_AC12 -to SW_1
set_location_assignment PIN_AF9  -to SW[2]
set_location_assignment PIN_AF9  -to SW_2
set_location_assignment PIN_AF10 -to SW[3]
set_location_assignment PIN_AF10 -to SW_3
set_location_assignment PIN_AD11 -to SW[4]
set_location_assignment PIN_AD11 -to SW_4
set_location_assignment PIN_AD12 -to SW[5]
set_location_assignment PIN_AD12 -to SW_5
set_location_assignment PIN_AE11 -to SW[6]
set_location_assignment PIN_AE11 -to SW_6
set_location_assignment PIN_AC9  -to SW[7]
set_location_assignment PIN_AC9  -to SW_7
set_location_assignment PIN_AD10 -to SW[8]
set_location_assignment PIN_AD10 -to SW_8
set_location_assignment PIN_AE12 -to SW[9]
set_location_assignment PIN_AE12 -to SW_9

set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW_0
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW_1
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW_2
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW_3
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW_4
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW_5
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW_6
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW_7
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[8]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW_8
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[9]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW_9

#============================================================
# Video-In on the board
#============================================================
set_location_assignment PIN_H15 -to TD_CLK27
set_location_assignment PIN_D2  -to TD_DATA[0]
set_location_assignment PIN_D2  -to TD_DATA0
set_location_assignment PIN_B1  -to TD_DATA[1]
set_location_assignment PIN_B1  -to TD_DATA1
set_location_assignment PIN_E2  -to TD_DATA[2]
set_location_assignment PIN_E2  -to TD_DATA2
set_location_assignment PIN_B2  -to TD_DATA[3]
set_location_assignment PIN_B2  -to TD_DATA3
set_location_assignment PIN_D1  -to TD_DATA[4]
set_location_assignment PIN_D1  -to TD_DATA4
set_location_assignment PIN_E1  -to TD_DATA[5]
set_location_assignment PIN_E1  -to TD_DATA5
set_location_assignment PIN_C2  -to TD_DATA[6]
set_location_assignment PIN_C2  -to TD_DATA6
set_location_assignment PIN_B3  -to TD_DATA[7]
set_location_assignment PIN_B3  -to TD_DATA7
set_location_assignment PIN_A5  -to TD_HS
set_location_assignment PIN_F6  -to TD_RESET_N
set_location_assignment PIN_A3  -to TD_VS

set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TD_CLK27
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TD_DATA[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TD_DATA0
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TD_DATA[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TD_DATA1
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TD_DATA[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TD_DATA2
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TD_DATA[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TD_DATA3
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TD_DATA[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TD_DATA4
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TD_DATA[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TD_DATA5
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TD_DATA[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TD_DATA6
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TD_DATA[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TD_DATA7
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TD_HS
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TD_RESET_N
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TD_VS

#============================================================
# VGA
#============================================================
set_location_assignment PIN_B13 -to VGA_B[0]
set_location_assignment PIN_B13 -to VGA_B_0
set_location_assignment PIN_G13 -to VGA_B[1]
set_location_assignment PIN_G13 -to VGA_B_1
set_location_assignment PIN_H13 -to VGA_B[2]
set_location_assignment PIN_H13 -to VGA_B_2
set_location_assignment PIN_F14 -to VGA_B[3]
set_location_assignment PIN_F14 -to VGA_B_3
set_location_assignment PIN_H14 -to VGA_B[4]
set_location_assignment PIN_H14 -to VGA_B_4
set_location_assignment PIN_F15 -to VGA_B[5]
set_location_assignment PIN_F15 -to VGA_B_5
set_location_assignment PIN_G15 -to VGA_B[6]
set_location_assignment PIN_G15 -to VGA_B_6
set_location_assignment PIN_J14 -to VGA_B[7]
set_location_assignment PIN_J14 -to VGA_B_7
set_location_assignment PIN_F10 -to VGA_BLANK_N
set_location_assignment PIN_A11 -to VGA_CLK
set_location_assignment PIN_J9  -to VGA_G[0]
set_location_assignment PIN_J9  -to VGA_G_0
set_location_assignment PIN_J10 -to VGA_G[1]
set_location_assignment PIN_J10 -to VGA_G_1
set_location_assignment PIN_H12 -to VGA_G[2]
set_location_assignment PIN_H12 -to VGA_G_2
set_location_assignment PIN_G10 -to VGA_G[3]
set_location_assignment PIN_G10 -to VGA_G_3
set_location_assignment PIN_G11 -to VGA_G[4]
set_location_assignment PIN_G11 -to VGA_G_4
set_location_assignment PIN_G12 -to VGA_G[5]
set_location_assignment PIN_G12 -to VGA_G_5
set_location_assignment PIN_F11 -to VGA_G[6]
set_location_assignment PIN_F11 -to VGA_G_6
set_location_assignment PIN_E11 -to VGA_G[7]
set_location_assignment PIN_E11 -to VGA_G_7
set_location_assignment PIN_B11 -to VGA_HS
set_location_assignment PIN_A13 -to VGA_R[0]
set_location_assignment PIN_A13 -to VGA_R_0
set_location_assignment PIN_C13 -to VGA_R[1]
set_location_assignment PIN_C13 -to VGA_R_1
set_location_assignment PIN_E13 -to VGA_R[2]
set_location_assignment PIN_E13 -to VGA_R_2
set_location_assignment PIN_B12 -to VGA_R[3]
set_location_assignment PIN_B12 -to VGA_R_3
set_location_assignment PIN_C12 -to VGA_R[4]
set_location_assignment PIN_C12 -to VGA_R_4
set_location_assignment PIN_D12 -to VGA_R[5]
set_location_assignment PIN_D12 -to VGA_R_5
set_location_assignment PIN_E12 -to VGA_R[6]
set_location_assignment PIN_E12 -to VGA_R_6
set_location_assignment PIN_F13 -to VGA_R[7]
set_location_assignment PIN_F13 -to VGA_R_7
set_location_assignment PIN_C10 -to VGA_SYNC_N
set_location_assignment PIN_D11 -to VGA_VS

set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_B[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_B_0
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_B[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_B_1
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_B[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_B_2
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_B[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_B_3
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_B[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_B_4
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_B[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_B_5
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_B[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_B_6
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_B[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_B_7
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_BLANK_N
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_CLK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_G[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_G_0
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_G[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_G_1
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_G[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_G_2
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_G[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_G_3
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_G[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_G_4
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_G[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_G_5
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_G[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_G_6
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_G[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_G_7
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_HS
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_R[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_R_0
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_R[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_R_1
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_R[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_R_2
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_R[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_R_3
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_R[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_R_4
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_R[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_R_5
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_R[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_R_6
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_R[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_R_7
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_SYNC_N
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_VS

#============================================================
# HPS
#============================================================
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[0]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[1]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR1
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[2]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR2
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[3]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR3
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[4]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR4
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[5]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR5
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[6]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR6
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[7]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR7
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[8]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR8
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[9]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR9
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[10]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR10
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[11]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR11
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[12]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR12
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[13]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR13
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[14]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR14
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_BA[0]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_BA_0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_BA[1]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_BA_1
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_BA[2]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_BA_2
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DM[0]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DM_0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DM[1]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DM_1
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DM[2]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DM_2
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DM[3]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DM_3
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[0]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[1]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ1
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[2]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ2
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[3]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ3
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[4]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ4
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[5]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ5
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[6]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ6
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[7]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ7
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[8]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ8
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[9]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ9
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[10]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ10
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[11]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ11
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[12]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ12
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[13]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ13
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[14]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ14
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[15]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ15
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[16]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ16
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[17]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ17
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[18]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ18
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[19]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ19
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[20]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ20
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[21]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ21
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[22]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ22
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[23]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ23
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[24]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ24
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[25]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ25
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[26]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ26
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[27]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ27
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[28]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ28
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[29]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ29
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[30]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ30
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[31]
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ31
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_CAS_N
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_CKE
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_CS_N
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ODT
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_RAS_N
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_WE_N
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_RESET_N
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_RZQ
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to HPS_DDR3_DQS_P[0]
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to HPS_DDR3_DQS_P0
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to HPS_DDR3_DQS_N[0]
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to HPS_DDR3_DQS_N0
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to HPS_DDR3_DQS_P[1]
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to HPS_DDR3_DQS_P1
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to HPS_DDR3_DQS_N[1]
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to HPS_DDR3_DQS_N1
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to HPS_DDR3_DQS_P[2]
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to HPS_DDR3_DQS_P2
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to HPS_DDR3_DQS_N[2]
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to HPS_DDR3_DQS_N2
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to HPS_DDR3_DQS_P[3]
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to HPS_DDR3_DQS_P3
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to HPS_DDR3_DQS_N[3]
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to HPS_DDR3_DQS_N3
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to HPS_DDR3_CK_P
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to HPS_DDR3_CK_N
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_GTX_CLK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_INT_N
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_MDC
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_MDIO
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_RX_CLK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_RX_DATA[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_RX_DATA0
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_RX_DATA[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_RX_DATA1
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_RX_DATA[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_RX_DATA2
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_RX_DATA[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_RX_DATA3
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_RX_DV
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_TX_DATA[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_TX_DATA0
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_TX_DATA[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_TX_DATA1
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_TX_DATA[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_TX_DATA2
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_TX_DATA[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_TX_DATA3
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_TX_EN
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_FLASH_DATA[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_FLASH_DATA0
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_FLASH_DATA[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_FLASH_DATA1
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_FLASH_DATA[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_FLASH_DATA2
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_FLASH_DATA[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_FLASH_DATA3
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_FLASH_DCLK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_FLASH_NCSO
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_GPIO[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_GPIO_0_D
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_GPIO[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_GPIO_1_D
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_GSENSOR_INT
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_I2C1_SCLK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_I2C1_SDAT
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_I2C2_SCLK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_I2C2_SDAT
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_I2C_CONTROL
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_KEY
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_LED
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_SD_CLK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_SD_CMD
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_SD_DATA[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_SD_DATA0
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_SD_DATA[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_SD_DATA1
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_SD_DATA[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_SD_DATA2
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_SD_DATA[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_SD_DATA3
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_SPIM_CLK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_SPIM_MISO
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_SPIM_MOSI
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_SPIM_SS
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_UART_RX
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_UART_TX
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_USB_CLKOUT
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_USB_DATA[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_USB_DATA0
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_USB_DATA[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_USB_DATA1
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_USB_DATA[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_USB_DATA2
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_USB_DATA[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_USB_DATA3
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_USB_DATA[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_USB_DATA4
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_USB_DATA[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_USB_DATA5
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_USB_DATA[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_USB_DATA6
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_USB_DATA[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_USB_DATA7
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_USB_DIR
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_USB_NXT
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_USB_STP
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_CONV_USB_N

#============================================================
# GPIO_0_D, GPIO_0_D connect to GPIO Default
#============================================================
set_location_assignment PIN_AC18 -to GPIO_0_D[0]
set_location_assignment PIN_AC18 -to GPIO_0_D0
set_location_assignment PIN_Y17  -to GPIO_0_D[1]
set_location_assignment PIN_Y17  -to GPIO_0_D1
set_location_assignment PIN_AD17 -to GPIO_0_D[2]
set_location_assignment PIN_AD17 -to GPIO_0_D2
set_location_assignment PIN_Y18  -to GPIO_0_D[3]
set_location_assignment PIN_Y18  -to GPIO_0_D3
set_location_assignment PIN_AK16 -to GPIO_0_D[4]
set_location_assignment PIN_AK16 -to GPIO_0_D4
set_location_assignment PIN_AK18 -to GPIO_0_D[5]
set_location_assignment PIN_AK18 -to GPIO_0_D5
set_location_assignment PIN_AK19 -to GPIO_0_D[6]
set_location_assignment PIN_AK19 -to GPIO_0_D6
set_location_assignment PIN_AJ19 -to GPIO_0_D[7]
set_location_assignment PIN_AJ19 -to GPIO_0_D7
set_location_assignment PIN_AJ17 -to GPIO_0_D[8]
set_location_assignment PIN_AJ17 -to GPIO_0_D8
set_location_assignment PIN_AJ16 -to GPIO_0_D[9]
set_location_assignment PIN_AJ16 -to GPIO_0_D9
set_location_assignment PIN_AH18 -to GPIO_0_D[10]
set_location_assignment PIN_AH18 -to GPIO_0_D10
set_location_assignment PIN_AH17 -to GPIO_0_D[11]
set_location_assignment PIN_AH17 -to GPIO_0_D11
set_location_assignment PIN_AG16 -to GPIO_0_D[12]
set_location_assignment PIN_AG16 -to GPIO_0_D12
set_location_assignment PIN_AE16 -to GPIO_0_D[13]
set_location_assignment PIN_AE16 -to GPIO_0_D13
set_location_assignment PIN_AF16 -to GPIO_0_D[14]
set_location_assignment PIN_AF16 -to GPIO_0_D14
set_location_assignment PIN_AG17 -to GPIO_0_D[15]
set_location_assignment PIN_AG17 -to GPIO_0_D15
set_location_assignment PIN_AA18 -to GPIO_0_D[16]
set_location_assignment PIN_AA18 -to GPIO_0_D16
set_location_assignment PIN_AA19 -to GPIO_0_D[17]
set_location_assignment PIN_AA19 -to GPIO_0_D17
set_location_assignment PIN_AE17 -to GPIO_0_D[18]
set_location_assignment PIN_AE17 -to GPIO_0_D18
set_location_assignment PIN_AC20 -to GPIO_0_D[19]
set_location_assignment PIN_AC20 -to GPIO_0_D19
set_location_assignment PIN_AH19 -to GPIO_0_D[20]
set_location_assignment PIN_AH19 -to GPIO_0_D20
set_location_assignment PIN_AJ20 -to GPIO_0_D[21]
set_location_assignment PIN_AJ20 -to GPIO_0_D21
set_location_assignment PIN_AH20 -to GPIO_0_D[22]
set_location_assignment PIN_AH20 -to GPIO_0_D22
set_location_assignment PIN_AK21 -to GPIO_0_D[23]
set_location_assignment PIN_AK21 -to GPIO_0_D23
set_location_assignment PIN_AD19 -to GPIO_0_D[24]
set_location_assignment PIN_AD19 -to GPIO_0_D24
set_location_assignment PIN_AD20 -to GPIO_0_D[25]
set_location_assignment PIN_AD20 -to GPIO_0_D25
set_location_assignment PIN_AE18 -to GPIO_0_D[26]
set_location_assignment PIN_AE18 -to GPIO_0_D26
set_location_assignment PIN_AE19 -to GPIO_0_D[27]
set_location_assignment PIN_AE19 -to GPIO_0_D27
set_location_assignment PIN_AF20 -to GPIO_0_D[28]
set_location_assignment PIN_AF20 -to GPIO_0_D28
set_location_assignment PIN_AF21 -to GPIO_0_D[29]
set_location_assignment PIN_AF21 -to GPIO_0_D29
set_location_assignment PIN_AF19 -to GPIO_0_D[30]
set_location_assignment PIN_AF19 -to GPIO_0_D30
set_location_assignment PIN_AG21 -to GPIO_0_D[31]
set_location_assignment PIN_AG21 -to GPIO_0_D31
set_location_assignment PIN_AF18 -to GPIO_0_D[32]
set_location_assignment PIN_AF18 -to GPIO_0_D32
set_location_assignment PIN_AG20 -to GPIO_0_D[33]
set_location_assignment PIN_AG20 -to GPIO_0_D33
set_location_assignment PIN_AG18 -to GPIO_0_D[34]
set_location_assignment PIN_AG18 -to GPIO_0_D34
set_location_assignment PIN_AJ21 -to GPIO_0_D[35]
set_location_assignment PIN_AJ21 -to GPIO_0_D35

set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D0
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D1
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D2
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D3
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D4
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D5
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D6
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D7
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D[8]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D8
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D[9]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D9
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D[10]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D10
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D[11]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D11
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D[12]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D12
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D[13]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D13
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D[14]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D14
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D[15]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D15
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D[16]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D16
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D[17]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D17
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D[18]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D18
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D[19]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D19
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D[20]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D20
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D[21]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D21
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D[22]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D22
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D[23]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D23
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D[24]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D24
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D[25]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D25
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D[26]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D26
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D[27]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D27
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D[28]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D28
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D[29]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D29
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D[30]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D30
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D[31]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D31
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D[32]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D32
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D[33]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D33
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D[34]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D34
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D[35]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0_D35

#============================================================
# GPIO_1_D, GPIO_1_D connect to GPIO Default
#============================================================
set_location_assignment PIN_AB17 -to GPIO_1_D[0]
set_location_assignment PIN_AB17 -to GPIO_1_D0
set_location_assignment PIN_AA21 -to GPIO_1_D[1]
set_location_assignment PIN_AA21 -to GPIO_1_D1
set_location_assignment PIN_AB21 -to GPIO_1_D[2]
set_location_assignment PIN_AB21 -to GPIO_1_D2
set_location_assignment PIN_AC23 -to GPIO_1_D[3]
set_location_assignment PIN_AC23 -to GPIO_1_D3
set_location_assignment PIN_AD24 -to GPIO_1_D[4]
set_location_assignment PIN_AD24 -to GPIO_1_D4
set_location_assignment PIN_AE23 -to GPIO_1_D[5]
set_location_assignment PIN_AE23 -to GPIO_1_D5
set_location_assignment PIN_AE24 -to GPIO_1_D[6]
set_location_assignment PIN_AE24 -to GPIO_1_D6
set_location_assignment PIN_AF25 -to GPIO_1_D[7]
set_location_assignment PIN_AF25 -to GPIO_1_D7
set_location_assignment PIN_AF26 -to GPIO_1_D[8]
set_location_assignment PIN_AF26 -to GPIO_1_D8
set_location_assignment PIN_AG25 -to GPIO_1_D[9]
set_location_assignment PIN_AG25 -to GPIO_1_D9
set_location_assignment PIN_AG26 -to GPIO_1_D[10]
set_location_assignment PIN_AG26 -to GPIO_1_D10
set_location_assignment PIN_AH24 -to GPIO_1_D[11]
set_location_assignment PIN_AH24 -to GPIO_1_D11
set_location_assignment PIN_AH27 -to GPIO_1_D[12]
set_location_assignment PIN_AH27 -to GPIO_1_D12
set_location_assignment PIN_AJ27 -to GPIO_1_D[13]
set_location_assignment PIN_AJ27 -to GPIO_1_D13
set_location_assignment PIN_AK29 -to GPIO_1_D[14]
set_location_assignment PIN_AK29 -to GPIO_1_D14
set_location_assignment PIN_AK28 -to GPIO_1_D[15]
set_location_assignment PIN_AK28 -to GPIO_1_D15
set_location_assignment PIN_AK27 -to GPIO_1_D[16]
set_location_assignment PIN_AK27 -to GPIO_1_D16
set_location_assignment PIN_AJ26 -to GPIO_1_D[17]
set_location_assignment PIN_AJ26 -to GPIO_1_D17
set_location_assignment PIN_AK26 -to GPIO_1_D[18]
set_location_assignment PIN_AK26 -to GPIO_1_D18
set_location_assignment PIN_AH25 -to GPIO_1_D[19]
set_location_assignment PIN_AH25 -to GPIO_1_D19
set_location_assignment PIN_AJ25 -to GPIO_1_D[20]
set_location_assignment PIN_AJ25 -to GPIO_1_D20
set_location_assignment PIN_AJ24 -to GPIO_1_D[21]
set_location_assignment PIN_AJ24 -to GPIO_1_D21
set_location_assignment PIN_AK24 -to GPIO_1_D[22]
set_location_assignment PIN_AK24 -to GPIO_1_D22
set_location_assignment PIN_AG23 -to GPIO_1_D[23]
set_location_assignment PIN_AG23 -to GPIO_1_D23
set_location_assignment PIN_AK23 -to GPIO_1_D[24]
set_location_assignment PIN_AK23 -to GPIO_1_D24
set_location_assignment PIN_AH23 -to GPIO_1_D[25]
set_location_assignment PIN_AH23 -to GPIO_1_D25
set_location_assignment PIN_AK22 -to GPIO_1_D[26]
set_location_assignment PIN_AK22 -to GPIO_1_D26
set_location_assignment PIN_AJ22 -to GPIO_1_D[27]
set_location_assignment PIN_AJ22 -to GPIO_1_D27
set_location_assignment PIN_AH22 -to GPIO_1_D[28]
set_location_assignment PIN_AH22 -to GPIO_1_D28
set_location_assignment PIN_AG22 -to GPIO_1_D[29]
set_location_assignment PIN_AG22 -to GPIO_1_D29
set_location_assignment PIN_AF24 -to GPIO_1_D[30]
set_location_assignment PIN_AF24 -to GPIO_1_D30
set_location_assignment PIN_AF23 -to GPIO_1_D[31]
set_location_assignment PIN_AF23 -to GPIO_1_D31
set_location_assignment PIN_AE22 -to GPIO_1_D[32]
set_location_assignment PIN_AE22 -to GPIO_1_D32
set_location_assignment PIN_AD21 -to GPIO_1_D[33]
set_location_assignment PIN_AD21 -to GPIO_1_D33
set_location_assignment PIN_AA20 -to GPIO_1_D[34]
set_location_assignment PIN_AA20 -to GPIO_1_D34
set_location_assignment PIN_AC22 -to GPIO_1_D[35]
set_location_assignment PIN_AC22 -to GPIO_1_D35

set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D0
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D1
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D2
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D3
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D4
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D5
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D6
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D7
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D[8]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D8
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D[9]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D9
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D[10]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D10
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D[11]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D11
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D[12]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D12
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D[13]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D13
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D[14]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D14
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D[15]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D15
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D[16]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D16
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D[17]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D17
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D[18]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D18
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D[19]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D19
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D[20]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D20
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D[21]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D21
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D[22]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D22
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D[23]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D23
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D[24]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D24
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D[25]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D25
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D[26]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D26
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D[27]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D27
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D[28]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D28
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D[29]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D29
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D[30]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D30
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D[31]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D31
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D[32]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D32
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D[33]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D33
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D[34]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D34
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D[35]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1_D35
