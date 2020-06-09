--
-- Linear diff lookup table
-- This entity is a combinatorial lookup table that provides the linear
-- difference between 2 samples at 48000 Hz and 16-bit depth
-- given a MIDI note code, computed from the frequency mapping of each note
--
-- file:                linear_diff.vhd
-- auto-generated from: linear_diff.py
-- author:              Alexandre CHAU
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity linear_diff is
    port (
        midi_note_code   : in std_logic_vector(7 downto 0);
        note_linear_diff : out unsigned(16 - 1 downto 0)
    );
end entity linear_diff;

architecture lut of linear_diff is
begin
    mux : process (midi_note_code)
    begin
        case to_integer(unsigned(midi_note_code)) is

            when 21 =>
                -- Note code 21 is A0 at 27.5 Hz
                note_linear_diff <= to_unsigned(38, note_linear_diff'length);

            when 22 =>
                -- Note code 22 is A#0 at 29.14 Hz
                note_linear_diff <= to_unsigned(40, note_linear_diff'length);

            when 23 =>
                -- Note code 23 is B0 at 30.87 Hz
                note_linear_diff <= to_unsigned(42, note_linear_diff'length);

            when 24 =>
                -- Note code 24 is C1 at 32.7 Hz
                note_linear_diff <= to_unsigned(45, note_linear_diff'length);

            when 25 =>
                -- Note code 25 is C#1 at 34.65 Hz
                note_linear_diff <= to_unsigned(47, note_linear_diff'length);

            when 26 =>
                -- Note code 26 is D1 at 36.71 Hz
                note_linear_diff <= to_unsigned(50, note_linear_diff'length);

            when 27 =>
                -- Note code 27 is D#1 at 38.89 Hz
                note_linear_diff <= to_unsigned(53, note_linear_diff'length);

            when 28 =>
                -- Note code 28 is E1 at 41.2 Hz
                note_linear_diff <= to_unsigned(56, note_linear_diff'length);

            when 29 =>
                -- Note code 29 is F1 at 43.65 Hz
                note_linear_diff <= to_unsigned(60, note_linear_diff'length);

            when 30 =>
                -- Note code 30 is F#1 at 46.25 Hz
                note_linear_diff <= to_unsigned(63, note_linear_diff'length);

            when 31 =>
                -- Note code 31 is G1 at 49.0 Hz
                note_linear_diff <= to_unsigned(67, note_linear_diff'length);

            when 32 =>
                -- Note code 32 is G#1 at 51.91 Hz
                note_linear_diff <= to_unsigned(71, note_linear_diff'length);

            when 33 =>
                -- Note code 33 is A1 at 55.0 Hz
                note_linear_diff <= to_unsigned(75, note_linear_diff'length);

            when 34 =>
                -- Note code 34 is A#1 at 58.27 Hz
                note_linear_diff <= to_unsigned(80, note_linear_diff'length);

            when 35 =>
                -- Note code 35 is B1 at 61.74 Hz
                note_linear_diff <= to_unsigned(84, note_linear_diff'length);

            when 36 =>
                -- Note code 36 is C2 at 65.41 Hz
                note_linear_diff <= to_unsigned(89, note_linear_diff'length);

            when 37 =>
                -- Note code 37 is C#2 at 69.3 Hz
                note_linear_diff <= to_unsigned(95, note_linear_diff'length);

            when 38 =>
                -- Note code 38 is D2 at 73.42 Hz
                note_linear_diff <= to_unsigned(100, note_linear_diff'length);

            when 39 =>
                -- Note code 39 is D#2 at 77.78 Hz
                note_linear_diff <= to_unsigned(106, note_linear_diff'length);

            when 40 =>
                -- Note code 40 is E2 at 82.41 Hz
                note_linear_diff <= to_unsigned(113, note_linear_diff'length);

            when 41 =>
                -- Note code 41 is F2 at 87.31 Hz
                note_linear_diff <= to_unsigned(119, note_linear_diff'length);

            when 42 =>
                -- Note code 42 is F#2 at 92.5 Hz
                note_linear_diff <= to_unsigned(126, note_linear_diff'length);

            when 43 =>
                -- Note code 43 is G2 at 98.0 Hz
                note_linear_diff <= to_unsigned(134, note_linear_diff'length);

            when 44 =>
                -- Note code 44 is G#2 at 103.83 Hz
                note_linear_diff <= to_unsigned(142, note_linear_diff'length);

            when 45 =>
                -- Note code 45 is A2 at 110.0 Hz
                note_linear_diff <= to_unsigned(150, note_linear_diff'length);

            when 46 =>
                -- Note code 46 is A#2 at 116.54 Hz
                note_linear_diff <= to_unsigned(159, note_linear_diff'length);

            when 47 =>
                -- Note code 47 is B2 at 123.47 Hz
                note_linear_diff <= to_unsigned(169, note_linear_diff'length);

            when 48 =>
                -- Note code 48 is C3 at 130.81 Hz
                note_linear_diff <= to_unsigned(179, note_linear_diff'length);

            when 49 =>
                -- Note code 49 is C#3 at 138.59 Hz
                note_linear_diff <= to_unsigned(189, note_linear_diff'length);

            when 50 =>
                -- Note code 50 is D3 at 146.83 Hz
                note_linear_diff <= to_unsigned(200, note_linear_diff'length);

            when 51 =>
                -- Note code 51 is D#3 at 155.56 Hz
                note_linear_diff <= to_unsigned(212, note_linear_diff'length);

            when 52 =>
                -- Note code 52 is E3 at 164.81 Hz
                note_linear_diff <= to_unsigned(225, note_linear_diff'length);

            when 53 =>
                -- Note code 53 is F3 at 174.61 Hz
                note_linear_diff <= to_unsigned(238, note_linear_diff'length);

            when 54 =>
                -- Note code 54 is F#3 at 185.0 Hz
                note_linear_diff <= to_unsigned(253, note_linear_diff'length);

            when 55 =>
                -- Note code 55 is G3 at 196.0 Hz
                note_linear_diff <= to_unsigned(268, note_linear_diff'length);

            when 56 =>
                -- Note code 56 is G#3 at 207.65 Hz
                note_linear_diff <= to_unsigned(284, note_linear_diff'length);

            when 57 =>
                -- Note code 57 is A3 at 220.0 Hz
                note_linear_diff <= to_unsigned(300, note_linear_diff'length);

            when 58 =>
                -- Note code 58 is A#3 at 233.08 Hz
                note_linear_diff <= to_unsigned(318, note_linear_diff'length);

            when 59 =>
                -- Note code 59 is B3 at 246.94 Hz
                note_linear_diff <= to_unsigned(337, note_linear_diff'length);

            when 60 =>
                -- Note code 60 is C4 at 261.63 Hz
                note_linear_diff <= to_unsigned(357, note_linear_diff'length);

            when 61 =>
                -- Note code 61 is C#4 at 277.18 Hz
                note_linear_diff <= to_unsigned(378, note_linear_diff'length);

            when 62 =>
                -- Note code 62 is D4 at 293.66 Hz
                note_linear_diff <= to_unsigned(401, note_linear_diff'length);

            when 63 =>
                -- Note code 63 is D#4 at 311.13 Hz
                note_linear_diff <= to_unsigned(425, note_linear_diff'length);

            when 64 =>
                -- Note code 64 is E4 at 329.63 Hz
                note_linear_diff <= to_unsigned(450, note_linear_diff'length);

            when 65 =>
                -- Note code 65 is F4 at 349.23 Hz
                note_linear_diff <= to_unsigned(477, note_linear_diff'length);

            when 66 =>
                -- Note code 66 is F#4 at 369.99 Hz
                note_linear_diff <= to_unsigned(505, note_linear_diff'length);

            when 67 =>
                -- Note code 67 is G4 at 392.0 Hz
                note_linear_diff <= to_unsigned(535, note_linear_diff'length);

            when 68 =>
                -- Note code 68 is G#4 at 415.3 Hz
                note_linear_diff <= to_unsigned(567, note_linear_diff'length);

            when 69 =>
                -- Note code 69 is A4 at 440.0 Hz
                note_linear_diff <= to_unsigned(601, note_linear_diff'length);

            when 70 =>
                -- Note code 70 is A#4 at 466.16 Hz
                note_linear_diff <= to_unsigned(636, note_linear_diff'length);

            when 71 =>
                -- Note code 71 is B4 at 493.88 Hz
                note_linear_diff <= to_unsigned(674, note_linear_diff'length);

            when 72 =>
                -- Note code 72 is C5 at 523.25 Hz
                note_linear_diff <= to_unsigned(714, note_linear_diff'length);

            when 73 =>
                -- Note code 73 is C#5 at 554.37 Hz
                note_linear_diff <= to_unsigned(757, note_linear_diff'length);

            when 74 =>
                -- Note code 74 is D5 at 587.33 Hz
                note_linear_diff <= to_unsigned(802, note_linear_diff'length);

            when 75 =>
                -- Note code 75 is D#5 at 622.25 Hz
                note_linear_diff <= to_unsigned(850, note_linear_diff'length);

            when 76 =>
                -- Note code 76 is E5 at 659.26 Hz
                note_linear_diff <= to_unsigned(900, note_linear_diff'length);

            when 77 =>
                -- Note code 77 is F5 at 698.46 Hz
                note_linear_diff <= to_unsigned(954, note_linear_diff'length);

            when 78 =>
                -- Note code 78 is F#5 at 739.99 Hz
                note_linear_diff <= to_unsigned(1010, note_linear_diff'length);

            when 79 =>
                -- Note code 79 is G5 at 783.99 Hz
                note_linear_diff <= to_unsigned(1070, note_linear_diff'length);

            when 80 =>
                -- Note code 80 is G#5 at 830.61 Hz
                note_linear_diff <= to_unsigned(1134, note_linear_diff'length);

            when 81 =>
                -- Note code 81 is A5 at 880.0 Hz
                note_linear_diff <= to_unsigned(1201, note_linear_diff'length);

            when 82 =>
                -- Note code 82 is A#5 at 932.33 Hz
                note_linear_diff <= to_unsigned(1273, note_linear_diff'length);

            when 83 =>
                -- Note code 83 is B5 at 987.77 Hz
                note_linear_diff <= to_unsigned(1349, note_linear_diff'length);

            when 84 =>
                -- Note code 84 is C6 at 1046.5 Hz
                note_linear_diff <= to_unsigned(1429, note_linear_diff'length);

            when 85 =>
                -- Note code 85 is C#6 at 1108.73 Hz
                note_linear_diff <= to_unsigned(1514, note_linear_diff'length);

            when 86 =>
                -- Note code 86 is D6 at 1174.66 Hz
                note_linear_diff <= to_unsigned(1604, note_linear_diff'length);

            when 87 =>
                -- Note code 87 is D#6 at 1244.51 Hz
                note_linear_diff <= to_unsigned(1699, note_linear_diff'length);

            when 88 =>
                -- Note code 88 is E6 at 1318.51 Hz
                note_linear_diff <= to_unsigned(1800, note_linear_diff'length);

            when 89 =>
                -- Note code 89 is F6 at 1396.91 Hz
                note_linear_diff <= to_unsigned(1907, note_linear_diff'length);

            when 90 =>
                -- Note code 90 is F#6 at 1479.98 Hz
                note_linear_diff <= to_unsigned(2021, note_linear_diff'length);

            when 91 =>
                -- Note code 91 is G6 at 1567.98 Hz
                note_linear_diff <= to_unsigned(2141, note_linear_diff'length);

            when 92 =>
                -- Note code 92 is G#6 at 1661.22 Hz
                note_linear_diff <= to_unsigned(2268, note_linear_diff'length);

            when 93 =>
                -- Note code 93 is A6 at 1760.0 Hz
                note_linear_diff <= to_unsigned(2403, note_linear_diff'length);

            when 94 =>
                -- Note code 94 is A#6 at 1864.66 Hz
                note_linear_diff <= to_unsigned(2546, note_linear_diff'length);

            when 95 =>
                -- Note code 95 is B6 at 1975.53 Hz
                note_linear_diff <= to_unsigned(2697, note_linear_diff'length);

            when 96 =>
                -- Note code 96 is C7 at 2093.0 Hz
                note_linear_diff <= to_unsigned(2858, note_linear_diff'length);

            when 97 =>
                -- Note code 97 is C#7 at 2217.46 Hz
                note_linear_diff <= to_unsigned(3028, note_linear_diff'length);

            when 98 =>
                -- Note code 98 is D7 at 2349.32 Hz
                note_linear_diff <= to_unsigned(3208, note_linear_diff'length);

            when 99 =>
                -- Note code 99 is D#7 at 2489.02 Hz
                note_linear_diff <= to_unsigned(3398, note_linear_diff'length);

            when 100 =>
                -- Note code 100 is E7 at 2637.02 Hz
                note_linear_diff <= to_unsigned(3600, note_linear_diff'length);

            when 101 =>
                -- Note code 101 is F7 at 2793.83 Hz
                note_linear_diff <= to_unsigned(3814, note_linear_diff'length);

            when 102 =>
                -- Note code 102 is F#7 at 2959.96 Hz
                note_linear_diff <= to_unsigned(4041, note_linear_diff'length);

            when 103 =>
                -- Note code 103 is G7 at 3135.96 Hz
                note_linear_diff <= to_unsigned(4282, note_linear_diff'length);

            when 104 =>
                -- Note code 104 is G#7 at 3322.44 Hz
                note_linear_diff <= to_unsigned(4536, note_linear_diff'length);

            when 105 =>
                -- Note code 105 is A7 at 3520.0 Hz
                note_linear_diff <= to_unsigned(4806, note_linear_diff'length);

            when 106 =>
                -- Note code 106 is A#7 at 3729.31 Hz
                note_linear_diff <= to_unsigned(5092, note_linear_diff'length);

            when 107 =>
                -- Note code 107 is B7 at 3951.07 Hz
                note_linear_diff <= to_unsigned(5394, note_linear_diff'length);

            when 108 =>
                -- Note code 108 is C8 at 4186.01 Hz
                note_linear_diff <= to_unsigned(5715, note_linear_diff'length);

            when others =>
                -- note is out of range, default to 0
                note_linear_diff <= (others => '0');
        end case;
    end process mux;
end architecture lut;