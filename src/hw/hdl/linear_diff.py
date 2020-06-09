#
# This file is a helper to generate the linear diff lookup table VHDL component
# a combinatorial lookup table that provides the linear difference between 2
# samples at {DAC_FREQ} Hz and {PCM_DEPTH}-bit depth given a MIDI note code,
# computed from the frequency mapping of each note
#
# file:         linear_diff.py
# generates:    linear_diff.vhd
# author:       Alexandre CHAU

# Configure DAC properties here
DAC_FREQ = 48000
PCM_DEPTH = 16

# Compute frequencies from MIDI note number
# From https://www.audiolabs-erlangen.de/resources/MIR/FMP/C1/C1S3_CenterFrequencyMIDI.html
PCM_MAX_INT = 2 ** PCM_DEPTH - 1
DAC_DELTA = 1 / DAC_FREQ

midi_range = range(21, 109)
pitch = lambda p: 440 * 2 ** ((p - 69) / 12)
freqs = [pitch(m) for m in midi_range]
periods = [1 / f for f in freqs]
periods_in_samples = [p / DAC_DELTA for p in periods]
chroma = ['A', 'A#', 'B', 'C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#']
tones = [chroma[(note-69) % 12] + str(note//12-1) for note in midi_range]

# Compute linear difference for each sample to iterate 0 to PCM_MAX_INT at the note frequency
# Useful to compute saw tooth wave for instance
linear_diffs = [int(round(PCM_MAX_INT / ps)) for ps in periods_in_samples]


# From here: section to generate VHDL code
pretty_freqs = [str(round(f,2)) for f in freqs]
midi_tone_diffs = list(zip(midi_range, tones, pretty_freqs, linear_diffs))

header = f"""--
-- Linear diff lookup table
-- This entity is a combinatorial lookup table that provides the linear
-- difference between 2 samples at {DAC_FREQ} Hz and {PCM_DEPTH}-bit depth
-- given a MIDI note code, computed from the frequency mapping of each note
--
-- DO NOT CHANGE THIS FILE DIRECTLY, INSTEAD CHANGE linear_diff.py.
--
-- file:                linear_diff.vhd
-- auto-generated from: linear_diff.py
-- author:              Alexandre CHAU
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
"""

entity = f"""
entity linear_diff is
    port (
        midi_note_code   : in std_logic_vector(7 downto 0);
        note_linear_diff : out unsigned({PCM_DEPTH - 1} downto 0)
    );
end entity linear_diff;
"""

cases = [f"""
            when {midi} =>
                -- Note code {midi} is {tone} at {freq} Hz
                note_linear_diff <= to_unsigned({diff}, note_linear_diff'length);
""" for (midi, tone, freq, diff) in midi_tone_diffs]

architecture = f"""
architecture lut of linear_diff is
begin
    mux : process (midi_note_code)
    begin
        case to_integer(unsigned(midi_note_code)) is
{"".join(cases)}
            when others =>
                -- note is out of range, default to 0
                note_linear_diff <= (others => '0');
        end case;
    end process mux;
end architecture lut;

-- DO NOT CHANGE THIS FILE DIRECTLY, INSTEAD CHANGE linear_diff.py."""

vhdl = header + entity + architecture

FILENAME = "linear_diff.vhd"
with open(FILENAME, "w") as file:
    file.write(vhdl)
    print(f"Wrote generated linear_diff component to {FILENAME}")