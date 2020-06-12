/*
 * FPGA sound synthesizer peripherals source file
 * Implementations to interface the NIOS II slaves
 *
 * file: peripherals.h
 * author: Alexandre CHAU & Loïc DROZ
 * date: June 9, 2020
 */

#include "peripherals.h"

/* Refer to the documentation in peripherals.h */

void i2c_configure(uint8_t address, uint16_t data) {
	IOWR_32DIRECT(I2C_SLAVE_0_BASE, I2C_REG_ADDRESS, address);
	IOWR_32DIRECT(I2C_SLAVE_0_BASE, I2C_REG_DATA, data);
	IOWR_32DIRECT(I2C_SLAVE_0_BASE, I2C_REG_SEND, 1);
	while(IORD_32DIRECT(I2C_SLAVE_0_BASE, I2C_REG_BUSY));
}

void setup_audio_codec() {
	// reset
	i2c_configure(WM8731_I2C_ADDRESS, 0b0001111000000000);
	// activate interface
	i2c_configure(WM8731_I2C_ADDRESS, 0b0001001111111111);
	// ADC off, DAC on, Line Out on, Power on
	i2c_configure(WM8731_I2C_ADDRESS, 0b0000110000000111);
	// DSP, 32-bit depth, slave mode
	i2c_configure(WM8731_I2C_ADDRESS, 0b0000111000011111);
	// Headphone volume
	i2c_configure(WM8731_I2C_ADDRESS, 0b0000010101111001);
	// USB mode, 96 KHz sample rate
	i2c_configure(WM8731_I2C_ADDRESS, 0b0001000000011101);
	// DAC to Line Out
	i2c_configure(WM8731_I2C_ADDRESS, 0b0000100000010010);
	// unmute DAC
	i2c_configure(WM8731_I2C_ADDRESS, 0b0000101000000000);
}

void sound_osc_start() {
	IOWR_32DIRECT(SOUND_GEN_0_BASE, SOUND_GEN_REG_START, 1);
}

void sound_osc_stop() {
	IOWR_32DIRECT(SOUND_GEN_0_BASE, SOUND_GEN_REG_STOP, 1);
}

void sound_set_note(uint32_t note) {
	IOWR_32DIRECT(SOUND_GEN_0_BASE, SOUND_GEN_REG_NOTE, note);
}


uint32_t controls_read_status() {
	return IORD_32DIRECT(BUTTONS_CONTROLLER_0_BASE, CONTROLS_REG_STATUS);
}


void controls_clear_irq() {
	IOWR_32DIRECT(BUTTONS_CONTROLLER_0_BASE, CONTROLS_REG_IRQ, 1);
}
