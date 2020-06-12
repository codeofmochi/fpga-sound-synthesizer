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
 * MIDI STATUS BYTES
 * These codes define the action type such as note on and note
 * off. They are already shifted to the correct offset in a
 * MIDI message for painless composition
 */
#define MIDI_STATUS_BYTES_OFFSET 16
#define NOTE_STOP 0x80 << MIDI_STATUS_BYTES_OFFSET
#define NOTE_START 0x90 << MIDI_STATUS_BYTES_OFFSET

/**
 * MIDI NOTES
 * These definitions map the notes A0 - C8 to the MIDI note
 * codes 21 - 108. They are already shifted to the correct
 * offset in a MIDI message for painless composition
 */
#define MIDI_NOTE_OFFSET 8
#define A0 21 << MIDI_NOTE_OFFSET
#define As0 22 << MIDI_NOTE_OFFSET
#define B0 23 << MIDI_NOTE_OFFSET
#define C1 24 << MIDI_NOTE_OFFSET
#define Cs1 25 << MIDI_NOTE_OFFSET
#define D1 26 << MIDI_NOTE_OFFSET
#define Ds1 27 << MIDI_NOTE_OFFSET
#define E1 28 << MIDI_NOTE_OFFSET
#define F1 29 << MIDI_NOTE_OFFSET
#define Fs1 30 << MIDI_NOTE_OFFSET
#define G1 31 << MIDI_NOTE_OFFSET
#define Gs1 32 << MIDI_NOTE_OFFSET
#define A1 33 << MIDI_NOTE_OFFSET
#define As1 34 << MIDI_NOTE_OFFSET
#define B1 35 << MIDI_NOTE_OFFSET
#define C2 36 << MIDI_NOTE_OFFSET
#define Cs2 37 << MIDI_NOTE_OFFSET
#define D2 38 << MIDI_NOTE_OFFSET
#define Ds2 39 << MIDI_NOTE_OFFSET
#define E2 40 << MIDI_NOTE_OFFSET
#define F2 41 << MIDI_NOTE_OFFSET
#define Fs2 42 << MIDI_NOTE_OFFSET
#define G2 43 << MIDI_NOTE_OFFSET
#define Gs2 44 << MIDI_NOTE_OFFSET
#define A2 45 << MIDI_NOTE_OFFSET
#define As2 46 << MIDI_NOTE_OFFSET
#define B2 47 << MIDI_NOTE_OFFSET
#define C3 48 << MIDI_NOTE_OFFSET
#define Cs3 49 << MIDI_NOTE_OFFSET
#define D3 50 << MIDI_NOTE_OFFSET
#define Ds3 51 << MIDI_NOTE_OFFSET
#define E3 52 << MIDI_NOTE_OFFSET
#define F3 53 << MIDI_NOTE_OFFSET
#define Fs3 54 << MIDI_NOTE_OFFSET
#define G3 55 << MIDI_NOTE_OFFSET
#define Gs3 56 << MIDI_NOTE_OFFSET
#define A3 57 << MIDI_NOTE_OFFSET
#define As3 58 << MIDI_NOTE_OFFSET
#define B3 59 << MIDI_NOTE_OFFSET
#define C4 60 << MIDI_NOTE_OFFSET
#define Cs4 61 << MIDI_NOTE_OFFSET
#define D4 62 << MIDI_NOTE_OFFSET
#define Ds4 63 << MIDI_NOTE_OFFSET
#define E4 64 << MIDI_NOTE_OFFSET
#define F4 65 << MIDI_NOTE_OFFSET
#define Fs4 66 << MIDI_NOTE_OFFSET
#define G4 67 << MIDI_NOTE_OFFSET
#define Gs4 68 << MIDI_NOTE_OFFSET
#define A4 69 << MIDI_NOTE_OFFSET
#define As4 70 << MIDI_NOTE_OFFSET
#define B4 71 << MIDI_NOTE_OFFSET
#define C5 72 << MIDI_NOTE_OFFSET
#define Cs5 73 << MIDI_NOTE_OFFSET
#define D5 74 << MIDI_NOTE_OFFSET
#define Ds5 75 << MIDI_NOTE_OFFSET
#define E5 76 << MIDI_NOTE_OFFSET
#define F5 77 << MIDI_NOTE_OFFSET
#define Fs5 78 << MIDI_NOTE_OFFSET
#define G5 79 << MIDI_NOTE_OFFSET
#define Gs5 80 << MIDI_NOTE_OFFSET
#define A5 81 << MIDI_NOTE_OFFSET
#define As5 82 << MIDI_NOTE_OFFSET
#define B5 83 << MIDI_NOTE_OFFSET
#define C6 84 << MIDI_NOTE_OFFSET
#define Cs6 85 << MIDI_NOTE_OFFSET
#define D6 86 << MIDI_NOTE_OFFSET
#define Ds6 87 << MIDI_NOTE_OFFSET
#define E6 88 << MIDI_NOTE_OFFSET
#define F6 89 << MIDI_NOTE_OFFSET
#define Fs6 90 << MIDI_NOTE_OFFSET
#define G6 91 << MIDI_NOTE_OFFSET
#define Gs6 92 << MIDI_NOTE_OFFSET
#define A6 93 << MIDI_NOTE_OFFSET
#define As6 94 << MIDI_NOTE_OFFSET
#define B6 95 << MIDI_NOTE_OFFSET
#define C7 96 << MIDI_NOTE_OFFSET
#define Cs7 97 << MIDI_NOTE_OFFSET
#define D7 98 << MIDI_NOTE_OFFSET
#define Ds7 99 << MIDI_NOTE_OFFSET
#define E7 100 << MIDI_NOTE_OFFSET
#define F7 101 << MIDI_NOTE_OFFSET
#define Fs7 102 << MIDI_NOTE_OFFSET
#define G7 103 << MIDI_NOTE_OFFSET
#define Gs7 104 << MIDI_NOTE_OFFSET
#define A7 105 << MIDI_NOTE_OFFSET
#define As7 106 << MIDI_NOTE_OFFSET
#define B7 107 << MIDI_NOTE_OFFSET
#define C8 108 << MIDI_NOTE_OFFSET

/**
 * Reserved MIDI definitions
 */
#define MIDI_VELOCITY_OFFSET 0
#define MIDI_TIMEDELTA_OFFSET 24

/**
 * This structure represents a note event in a music piece
 */
struct note
{
	uint32_t midi_msg;
	uint32_t duration_ms;
};

/**
 * This structure represents a music piece
 * Length is given in # of notes
 */
struct piece
{
	size_t length;
	struct note *sheet;
};

/**
 * Piece: base scale, notes from A4 to G5#, each 1 second
 */
#define BASE_SCALE_LENGTH 24
struct note base_scale[BASE_SCALE_LENGTH] = {
	{NOTE_START | A4, 1000},
	{NOTE_STOP | A4,  0},
	{NOTE_START | As4, 1000},
	{NOTE_STOP | As4,  0},
	{NOTE_START | B4, 1000},
	{NOTE_STOP | B4,  0},
	{NOTE_START | C5, 1000},
	{NOTE_STOP | C5,  0},
	{NOTE_START | Cs5, 1000},
	{NOTE_STOP | Cs5,  0},
	{NOTE_START | D5, 1000},
	{NOTE_STOP | D5,  0},
	{NOTE_START | Ds5, 1000},
	{NOTE_STOP | Ds5,  0},
	{NOTE_START | E5, 1000},
	{NOTE_STOP | E5,  0},
	{NOTE_START | F5, 1000},
	{NOTE_STOP | F5,  0},
	{NOTE_START | Fs5, 1000},
	{NOTE_STOP | Fs5,  0},
	{NOTE_START | G5, 1000},
	{NOTE_STOP | G5,  0},
	{NOTE_START | Gs5, 1000},
	{NOTE_STOP | Gs5,  0}
};

#include "bach_prelude_c.h"
#include "bach_prelude_c_poly.h"
#include "castlevania.h"
#include "mario_theme.h"
#include "wii_music.h"

/**
 * List of all available music pieces
 */
#define PIECES_LENGTH 6
struct piece pieces[PIECES_LENGTH] = {
	{BASE_SCALE_LENGTH, base_scale},
	{BACH_PRELUDE_C_LENGTH, bach_prelude_c},
	{BACH_PRELUDE_C_POLY_LENGTH, bach_prelude_c_poly},
	{CASTLEVANIA_LENGTH, castlevania},
	{MARIO_LENGTH, mario},
	{WII_MUSIC_LENGTH, wii_music}
};

#endif /* MUSIC_H_ */
