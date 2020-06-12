/*
 * FPGA sound synthesizer peripherals header file
 * Prototypes to interface the NIOS II slaves
 *
 * file: peripherals.h
 * author: Alexandre CHAU & Loïc DROZ
 * date: June 9, 2020
 */

#ifndef PERIPHERALS_H_
#define PERIPHERALS_H_

#include <inttypes.h>

#include "system.h"
#include "io.h"

#define WM8731_I2C_ADDRESS 0x34

#define I2C_REG_ADDRESS	0
#define I2C_REG_DATA	4
#define I2C_REG_SEND	8
#define I2C_REG_BUSY	12

#define SOUND_GEN_REG_START 0
#define SOUND_GEN_REG_STOP	4
#define SOUND_GEN_REG_NOTE	8

#define CONTROLS_REG_STATUS	0
#define CONTROLS_REG_IRQ	4

/**
 * Configures an I2C peripheral on the FPGA
 * @param address: I2C address of the device
 * @param data: I2C 16-bit data to send to the device
 */
void i2c_configure(uint8_t address, uint16_t data);

/**
 * Configures the WM8731 audio codec through I2C
 * Once this function completes, the DAC is ready for the synthesizer
 */
void setup_audio_codec();

/**
 * Volume control
 */
void set_volume(uint8_t volume);

/**
 * Starts the sound oscillator
 */
void sound_osc_start();

/**
 * Stops the sound oscillator
 */
void sound_osc_stop();

/**
 * Sends a note to play to the oscillator.
 * The oscillator must be started beforehand
 * @param note note to play on the oscillator
 * 			[Pad with zeroes][3-bit scale number][4-bit tone identifier (as defined in music.h)]
 * 			Example: A4 at 440Hz is 0b 0000 0000 0000 0000 0000 0000 0100 0000
 * 			Use the note abstractions provided in music.h
 */
void sound_set_note(uint32_t note);

/**
 * Reads the controls status register
 */
uint32_t controls_read_status();

/**
 * Clears the controls IRQ register
 */
void controls_clear_irq();

#endif /* PERIPHERALS_H_ */
