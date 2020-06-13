/*
 * FPGA sound synthesizer main program
 * Main NIOS II entry point to play music with the FPGA sound synthesizer
 *
 * file: main.c
 * author: Alexandre CHAU & Loïc DROZ
 * date: June 9, 2020
 */

#include <stdio.h>
#include <unistd.h>
#include <sys/alt_irq.h>

#include "peripherals.h"
#include "music.h"

#define DEFAULT_VOLUME 0b1111001

// current music piece
struct piece* music = NULL;
// current song index
uint32_t music_index = 0;
// cursor into the notes of the current song
size_t music_cursor = 0;
// mute control
uint8_t is_mute = 0;
// volume control
uint8_t volume = DEFAULT_VOLUME;

/**
 * Plays the current piece
 */
void play_music() {
	// start oscillator
	sound_osc_start();

	music_cursor = 0;
	while (music_cursor < music->length) {
		sound_set_note(music->sheet[music_cursor].midi_msg);
		// save wait time to increment cursor
		uint32_t wait_time = music->sheet[music_cursor].duration_ms;
		// cursor is incremented before sleep to avoid skipping first note when changing song
		music_cursor++;
		usleep(wait_time * 1000);
	}

	// stop oscillator
	sound_osc_stop();
}

/**
 * Skips to next song
 */
void skip_music() {
	sound_osc_stop();
	music_index = (music_index + 1) % PIECES_LENGTH;
	music_cursor = 0;
	music = &pieces[music_index];
	sound_osc_start();
}

/**
 * Restarts the current song
 */
void restart_music() {
	sound_osc_stop();
	music_cursor = 0;
	music = &pieces[music_index];
	sound_osc_start();
}

/**
 * Toggle mute
 */
void toggle_mute() {
	is_mute = is_mute ? 0 : 1;
	if (is_mute) {
		sound_osc_stop();
	} else {
		sound_osc_start();
	}
}

/**
 * Volume control
 */
void volume_up() {
	// if max reached, do nothing
	if (volume == 0b1111111) { return; }
	volume += 1;
	set_volume(volume);
}

void volume_down() {
	// if min reached, do nothing
	if (volume == 0b0110000) { return; }
	volume -= 1;
	set_volume(volume);
}

void volume_reset() {
	volume = DEFAULT_VOLUME;
	set_volume(volume);
}

/**
 * Oscillator type
 */
void set_osc_saw() {
	// set oscillator to saw wave (default)
	sound_set_osc_type(0);
}

void set_osc_square() {
	// set oscillator to square wave
	sound_set_osc_type(1);
}

static void controls_isr(void* context) {
	// handle buttons + switch
	uint32_t status = controls_read_status();
	uint8_t buttons = ~status & 0b111; // buttons are KEY_N, so invert first
	uint16_t mode = (status >> 3) & 0x3FF;

	// test mode value
	switch (mode) {
		// playback controls mode
		case 0:
			if ((buttons & 0b001) != 0) {
				// KEY_N[1] (second from right) button is pressed
				// skip to next song
				skip_music();
			} else if ((buttons & 0b010) != 0) {
				// KEY_N[2] (second from left) button is pressed
				// restart current song
				restart_music();
			} else if ((buttons & 0b100) != 0) {
				// KEY_N[3] (leftmost) button is pressed
				// toggle mute
				toggle_mute();
			}
			break;
		// volume control mode
		case 1:
			if ((buttons & 0b001) != 0) {
				// KEY_N[1] (second from right) button is pressed
				volume_reset();
			} else if ((buttons & 0b010) != 0) {
				// KEY_N[2] (second from left) button is pressed
				volume_up();
			} else if ((buttons & 0b100) != 0) {
				// KEY_N[3] (leftmost) button is pressed
				volume_down();
			}
			break;
		// oscillator type mode
		case 2:
			if ((buttons & 0b001) != 0) {
				// KEY_N[1] (second from right) button is pressed
				// reserved for future osc type
			} else if ((buttons & 0b010) != 0) {
				// KEY_N[2] (second from left) button is pressed
				set_osc_square();
			} else if ((buttons & 0b100) != 0) {
				// KEY_N[3] (leftmost) button is pressed
				set_osc_saw();
			}
			break;
	}

	// clear IRQ
	controls_clear_irq();
}

int main() {
  printf("Hello from Nios II!\n");

  // Register interrupt handler
  alt_ic_isr_register(BUTTONS_CONTROLLER_0_IRQ_INTERRUPT_CONTROLLER_ID, BUTTONS_CONTROLLER_0_IRQ, controls_isr, NULL, NULL);

  printf("Configuring audio codec...\n");
  setup_audio_codec();

  do {
	  // Waiting for music
	  printf("Waiting for user input...");
	  while(music == NULL);

	  // Play selected song
	  printf("Playing music...\n");
	  play_music();
	  music = NULL;
  } while(1);

  return 0;
}
