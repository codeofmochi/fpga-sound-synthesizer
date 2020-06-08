/*
 * "Hello World" example.
 *
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example
 * designs. It runs with or without the MicroC/OS-II RTOS and requires a STDOUT
 * device in your system's hardware.
 * The memory footprint of this hosted application is ~69 kbytes by default
 * using the standard reference design.
 *
 * For a reduced footprint version of this template, and an explanation of how
 * to reduce the memory footprint for a given application, see the
 * "small_hello_world" template.
 *
 */

#include <stdio.h>
#include <inttypes.h>

#include "system.h"
#include "io.h"

#define WM8731_I2C_ADDRESS 0x34

void i2c_configure(uint8_t address, uint16_t data) {
	IOWR_32DIRECT(I2C_SLAVE_0_BASE, 0, address);
	IOWR_32DIRECT(I2C_SLAVE_0_BASE, 4, data);
	IOWR_32DIRECT(I2C_SLAVE_0_BASE, 8, 1);
	int busy;
	do {
		busy = IORD_32DIRECT(I2C_SLAVE_0_BASE, 12);
		printf(busy ? "busy " : "free\n");
	} while (busy);
}

void sound_set_period(uint32_t period) {
	IOWR_32DIRECT(SOUND_GEN_0_BASE, 8, period);
}

void sound_start() {
	IOWR_32DIRECT(SOUND_GEN_0_BASE, 0, 1);
}

void setup_audio_codec() {
	// reset
	i2c_configure(WM8731_I2C_ADDRESS, 0b0001111000000000);
	// activate interface
	i2c_configure(WM8731_I2C_ADDRESS, 0b0001001111111111);
	// ADC off, DAC on, Line Out on, Power on
	i2c_configure(WM8731_I2C_ADDRESS, 0b0000110000000111);
	// DSP, 16-bit, slave mode
	i2c_configure(WM8731_I2C_ADDRESS, 0b0000111000010011);
	// Headphone volume
	i2c_configure(WM8731_I2C_ADDRESS, 0b0000010101111111);
	// USB mode
	i2c_configure(WM8731_I2C_ADDRESS, 0b0001000000000001);
	// DAC to Line Out
	i2c_configure(WM8731_I2C_ADDRESS, 0b0000100000010010);
	// unmute DAC
	i2c_configure(WM8731_I2C_ADDRESS, 0b0000101000000000);
}

int main()
{
  printf("Hello from Nios II!\n");

  printf("Configuring audio codec...\n");
  setup_audio_codec();

  printf("Starting oscillator...\n");
  sound_set_period(108);
  sound_start();

  while(1);

  return 0;
}
