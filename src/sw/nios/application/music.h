/*
 * FPGA sound synthesizer music header file
 * Music data and abstractions to compose and play pieces
 *
 * file: music.h
 * author: Alexandre CHAU & Loïc DROZ
 * date: June 9, 2020
 */

#ifndef MUSIC_H_
#define MUSIC_H_

#include <inttypes.h>
#include <stdlib.h>

/**
 * This enumeration maps the base scale A - G# to integers 0 - 11
 */
enum TONES {
	A, As, B, C, Cs, D, Ds, E, F, Fs, G, Gs
};

/**
 * This structure represents a note in a music piece
 * For instance, A4 played for 1 second is {A, 4, 1000}
 */
struct note {
	enum TONES tone;
	uint8_t scale;
	uint32_t duration_ms;
};

/**
 * This structure represents a music piece
 * Length is given in # of notes
 */
struct piece {
	size_t length;
	struct note* sheet;
};

/**
 * Piece: base scale, notes from A4 to G5#, each 1 second
 */
#define BASE_SCALE_LENGTH 12
struct note base_scale[BASE_SCALE_LENGTH] = {
		{A, 4, 1000},
		{As, 4, 1000},
		{B, 4, 1000},
		{C, 5, 1000},
		{Cs, 5, 1000},
		{D, 5, 1000},
		{Ds, 5, 1000},
		{E, 5, 1000},
		{F, 5, 1000},
		{Fs, 5, 1000},
		{G, 5, 1000},
		{Gs, 5, 1000}
};

/**
 * List of all available music pieces
 */
#define PIECES_LENGTH 1
struct piece pieces[PIECES_LENGTH] = {
		{BASE_SCALE_LENGTH, base_scale}
};

#endif /* MUSIC_H_ */
