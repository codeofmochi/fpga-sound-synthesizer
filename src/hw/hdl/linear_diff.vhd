--
-- Linear diff lookup table
-- This entity is a combinatorial lookup table that provides the linear
-- difference between 2 samples at 96000 Hz and 268435455 range
-- given a MIDI note code, computed from the frequency mapping of each note
--
-- DO NOT CHANGE THIS FILE DIRECTLY, INSTEAD CHANGE linear_diff.py.
--
-- file:                linear_diff.vhd
-- auto-generated from: linear_diff.py
-- last generated:      2020-06-14
-- author:              Alexandre CHAU
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity linear_diff is
    port (
        midi_note_code      : in std_logic_vector(7 downto 0);
        note_linear_diff    : out unsigned(31 downto 0);
        note_period_samples : out unsigned(31 downto 0)
    );
end entity linear_diff;

architecture lut of linear_diff is
begin
    mux : process (midi_note_code)
    begin
        case to_integer(unsigned(midi_note_code)) is

            when 21 =>
                -- Note code 21 is A0 at 27.5 Hz
                note_linear_diff    <= to_unsigned(76896, note_linear_diff'length);
                note_period_samples <= to_unsigned(3491, note_period_samples'length);

            when 22 =>
                -- Note code 22 is A#0 at 29.14 Hz
                note_linear_diff    <= to_unsigned(81468, note_linear_diff'length);
                note_period_samples <= to_unsigned(3295, note_period_samples'length);

            when 23 =>
                -- Note code 23 is B0 at 30.87 Hz
                note_linear_diff    <= to_unsigned(86312, note_linear_diff'length);
                note_period_samples <= to_unsigned(3110, note_period_samples'length);

            when 24 =>
                -- Note code 24 is C1 at 32.7 Hz
                note_linear_diff    <= to_unsigned(91445, note_linear_diff'length);
                note_period_samples <= to_unsigned(2935, note_period_samples'length);

            when 25 =>
                -- Note code 25 is C#1 at 34.65 Hz
                note_linear_diff    <= to_unsigned(96882, note_linear_diff'length);
                note_period_samples <= to_unsigned(2771, note_period_samples'length);

            when 26 =>
                -- Note code 26 is D1 at 36.71 Hz
                note_linear_diff    <= to_unsigned(102643, note_linear_diff'length);
                note_period_samples <= to_unsigned(2615, note_period_samples'length);

            when 27 =>
                -- Note code 27 is D#1 at 38.89 Hz
                note_linear_diff    <= to_unsigned(108747, note_linear_diff'length);
                note_period_samples <= to_unsigned(2468, note_period_samples'length);

            when 28 =>
                -- Note code 28 is E1 at 41.2 Hz
                note_linear_diff    <= to_unsigned(115213, note_linear_diff'length);
                note_period_samples <= to_unsigned(2330, note_period_samples'length);

            when 29 =>
                -- Note code 29 is F1 at 43.65 Hz
                note_linear_diff    <= to_unsigned(122064, note_linear_diff'length);
                note_period_samples <= to_unsigned(2199, note_period_samples'length);

            when 30 =>
                -- Note code 30 is F#1 at 46.25 Hz
                note_linear_diff    <= to_unsigned(129322, note_linear_diff'length);
                note_period_samples <= to_unsigned(2076, note_period_samples'length);

            when 31 =>
                -- Note code 31 is G1 at 49.0 Hz
                note_linear_diff    <= to_unsigned(137012, note_linear_diff'length);
                note_period_samples <= to_unsigned(1959, note_period_samples'length);

            when 32 =>
                -- Note code 32 is G#1 at 51.91 Hz
                note_linear_diff    <= to_unsigned(145160, note_linear_diff'length);
                note_period_samples <= to_unsigned(1849, note_period_samples'length);

            when 33 =>
                -- Note code 33 is A1 at 55.0 Hz
                note_linear_diff    <= to_unsigned(153791, note_linear_diff'length);
                note_period_samples <= to_unsigned(1745, note_period_samples'length);

            when 34 =>
                -- Note code 34 is A#1 at 58.27 Hz
                note_linear_diff    <= to_unsigned(162936, note_linear_diff'length);
                note_period_samples <= to_unsigned(1647, note_period_samples'length);

            when 35 =>
                -- Note code 35 is B1 at 61.74 Hz
                note_linear_diff    <= to_unsigned(172625, note_linear_diff'length);
                note_period_samples <= to_unsigned(1555, note_period_samples'length);

            when 36 =>
                -- Note code 36 is C2 at 65.41 Hz
                note_linear_diff    <= to_unsigned(182890, note_linear_diff'length);
                note_period_samples <= to_unsigned(1468, note_period_samples'length);

            when 37 =>
                -- Note code 37 is C#2 at 69.3 Hz
                note_linear_diff    <= to_unsigned(193765, note_linear_diff'length);
                note_period_samples <= to_unsigned(1385, note_period_samples'length);

            when 38 =>
                -- Note code 38 is D2 at 73.42 Hz
                note_linear_diff    <= to_unsigned(205287, note_linear_diff'length);
                note_period_samples <= to_unsigned(1308, note_period_samples'length);

            when 39 =>
                -- Note code 39 is D#2 at 77.78 Hz
                note_linear_diff    <= to_unsigned(217494, note_linear_diff'length);
                note_period_samples <= to_unsigned(1234, note_period_samples'length);

            when 40 =>
                -- Note code 40 is E2 at 82.41 Hz
                note_linear_diff    <= to_unsigned(230426, note_linear_diff'length);
                note_period_samples <= to_unsigned(1165, note_period_samples'length);

            when 41 =>
                -- Note code 41 is F2 at 87.31 Hz
                note_linear_diff    <= to_unsigned(244128, note_linear_diff'length);
                note_period_samples <= to_unsigned(1100, note_period_samples'length);

            when 42 =>
                -- Note code 42 is F#2 at 92.5 Hz
                note_linear_diff    <= to_unsigned(258645, note_linear_diff'length);
                note_period_samples <= to_unsigned(1038, note_period_samples'length);

            when 43 =>
                -- Note code 43 is G2 at 98.0 Hz
                note_linear_diff    <= to_unsigned(274025, note_linear_diff'length);
                note_period_samples <= to_unsigned(980, note_period_samples'length);

            when 44 =>
                -- Note code 44 is G#2 at 103.83 Hz
                note_linear_diff    <= to_unsigned(290319, note_linear_diff'length);
                note_period_samples <= to_unsigned(925, note_period_samples'length);

            when 45 =>
                -- Note code 45 is A2 at 110.0 Hz
                note_linear_diff    <= to_unsigned(307582, note_linear_diff'length);
                note_period_samples <= to_unsigned(873, note_period_samples'length);

            when 46 =>
                -- Note code 46 is A#2 at 116.54 Hz
                note_linear_diff    <= to_unsigned(325872, note_linear_diff'length);
                note_period_samples <= to_unsigned(824, note_period_samples'length);

            when 47 =>
                -- Note code 47 is B2 at 123.47 Hz
                note_linear_diff    <= to_unsigned(345249, note_linear_diff'length);
                note_period_samples <= to_unsigned(778, note_period_samples'length);

            when 48 =>
                -- Note code 48 is C3 at 130.81 Hz
                note_linear_diff    <= to_unsigned(365779, note_linear_diff'length);
                note_period_samples <= to_unsigned(734, note_period_samples'length);

            when 49 =>
                -- Note code 49 is C#3 at 138.59 Hz
                note_linear_diff    <= to_unsigned(387529, note_linear_diff'length);
                note_period_samples <= to_unsigned(693, note_period_samples'length);

            when 50 =>
                -- Note code 50 is D3 at 146.83 Hz
                note_linear_diff    <= to_unsigned(410573, note_linear_diff'length);
                note_period_samples <= to_unsigned(654, note_period_samples'length);

            when 51 =>
                -- Note code 51 is D#3 at 155.56 Hz
                note_linear_diff    <= to_unsigned(434987, note_linear_diff'length);
                note_period_samples <= to_unsigned(617, note_period_samples'length);

            when 52 =>
                -- Note code 52 is E3 at 164.81 Hz
                note_linear_diff    <= to_unsigned(460853, note_linear_diff'length);
                note_period_samples <= to_unsigned(582, note_period_samples'length);

            when 53 =>
                -- Note code 53 is F3 at 174.61 Hz
                note_linear_diff    <= to_unsigned(488256, note_linear_diff'length);
                note_period_samples <= to_unsigned(550, note_period_samples'length);

            when 54 =>
                -- Note code 54 is F#3 at 185.0 Hz
                note_linear_diff    <= to_unsigned(517290, note_linear_diff'length);
                note_period_samples <= to_unsigned(519, note_period_samples'length);

            when 55 =>
                -- Note code 55 is G3 at 196.0 Hz
                note_linear_diff    <= to_unsigned(548049, note_linear_diff'length);
                note_period_samples <= to_unsigned(490, note_period_samples'length);

            when 56 =>
                -- Note code 56 is G#3 at 207.65 Hz
                note_linear_diff    <= to_unsigned(580638, note_linear_diff'length);
                note_period_samples <= to_unsigned(462, note_period_samples'length);

            when 57 =>
                -- Note code 57 is A3 at 220.0 Hz
                note_linear_diff    <= to_unsigned(615165, note_linear_diff'length);
                note_period_samples <= to_unsigned(436, note_period_samples'length);

            when 58 =>
                -- Note code 58 is A#3 at 233.08 Hz
                note_linear_diff    <= to_unsigned(651744, note_linear_diff'length);
                note_period_samples <= to_unsigned(412, note_period_samples'length);

            when 59 =>
                -- Note code 59 is B3 at 246.94 Hz
                note_linear_diff    <= to_unsigned(690499, note_linear_diff'length);
                note_period_samples <= to_unsigned(389, note_period_samples'length);

            when 60 =>
                -- Note code 60 is C4 at 261.63 Hz
                note_linear_diff    <= to_unsigned(731558, note_linear_diff'length);
                note_period_samples <= to_unsigned(367, note_period_samples'length);

            when 61 =>
                -- Note code 61 is C#4 at 277.18 Hz
                note_linear_diff    <= to_unsigned(775059, note_linear_diff'length);
                note_period_samples <= to_unsigned(346, note_period_samples'length);

            when 62 =>
                -- Note code 62 is D4 at 293.66 Hz
                note_linear_diff    <= to_unsigned(821146, note_linear_diff'length);
                note_period_samples <= to_unsigned(327, note_period_samples'length);

            when 63 =>
                -- Note code 63 is D#4 at 311.13 Hz
                note_linear_diff    <= to_unsigned(869974, note_linear_diff'length);
                note_period_samples <= to_unsigned(309, note_period_samples'length);

            when 64 =>
                -- Note code 64 is E4 at 329.63 Hz
                note_linear_diff    <= to_unsigned(921705, note_linear_diff'length);
                note_period_samples <= to_unsigned(291, note_period_samples'length);

            when 65 =>
                -- Note code 65 is F4 at 349.23 Hz
                note_linear_diff    <= to_unsigned(976513, note_linear_diff'length);
                note_period_samples <= to_unsigned(275, note_period_samples'length);

            when 66 =>
                -- Note code 66 is F#4 at 369.99 Hz
                note_linear_diff    <= to_unsigned(1034579, note_linear_diff'length);
                note_period_samples <= to_unsigned(259, note_period_samples'length);

            when 67 =>
                -- Note code 67 is G4 at 392.0 Hz
                note_linear_diff    <= to_unsigned(1096099, note_linear_diff'length);
                note_period_samples <= to_unsigned(245, note_period_samples'length);

            when 68 =>
                -- Note code 68 is G#4 at 415.3 Hz
                note_linear_diff    <= to_unsigned(1161276, note_linear_diff'length);
                note_period_samples <= to_unsigned(231, note_period_samples'length);

            when 69 =>
                -- Note code 69 is A4 at 440.0 Hz
                note_linear_diff    <= to_unsigned(1230329, note_linear_diff'length);
                note_period_samples <= to_unsigned(218, note_period_samples'length);

            when 70 =>
                -- Note code 70 is A#4 at 466.16 Hz
                note_linear_diff    <= to_unsigned(1303488, note_linear_diff'length);
                note_period_samples <= to_unsigned(206, note_period_samples'length);

            when 71 =>
                -- Note code 71 is B4 at 493.88 Hz
                note_linear_diff    <= to_unsigned(1380998, note_linear_diff'length);
                note_period_samples <= to_unsigned(194, note_period_samples'length);

            when 72 =>
                -- Note code 72 is C5 at 523.25 Hz
                note_linear_diff    <= to_unsigned(1463116, note_linear_diff'length);
                note_period_samples <= to_unsigned(183, note_period_samples'length);

            when 73 =>
                -- Note code 73 is C#5 at 554.37 Hz
                note_linear_diff    <= to_unsigned(1550118, note_linear_diff'length);
                note_period_samples <= to_unsigned(173, note_period_samples'length);

            when 74 =>
                -- Note code 74 is D5 at 587.33 Hz
                note_linear_diff    <= to_unsigned(1642292, note_linear_diff'length);
                note_period_samples <= to_unsigned(163, note_period_samples'length);

            when 75 =>
                -- Note code 75 is D#5 at 622.25 Hz
                note_linear_diff    <= to_unsigned(1739948, note_linear_diff'length);
                note_period_samples <= to_unsigned(154, note_period_samples'length);

            when 76 =>
                -- Note code 76 is E5 at 659.26 Hz
                note_linear_diff    <= to_unsigned(1843411, note_linear_diff'length);
                note_period_samples <= to_unsigned(146, note_period_samples'length);

            when 77 =>
                -- Note code 77 is F5 at 698.46 Hz
                note_linear_diff    <= to_unsigned(1953026, note_linear_diff'length);
                note_period_samples <= to_unsigned(137, note_period_samples'length);

            when 78 =>
                -- Note code 78 is F#5 at 739.99 Hz
                note_linear_diff    <= to_unsigned(2069159, note_linear_diff'length);
                note_period_samples <= to_unsigned(130, note_period_samples'length);

            when 79 =>
                -- Note code 79 is G5 at 783.99 Hz
                note_linear_diff    <= to_unsigned(2192197, note_linear_diff'length);
                note_period_samples <= to_unsigned(122, note_period_samples'length);

            when 80 =>
                -- Note code 80 is G#5 at 830.61 Hz
                note_linear_diff    <= to_unsigned(2322552, note_linear_diff'length);
                note_period_samples <= to_unsigned(116, note_period_samples'length);

            when 81 =>
                -- Note code 81 is A5 at 880.0 Hz
                note_linear_diff    <= to_unsigned(2460658, note_linear_diff'length);
                note_period_samples <= to_unsigned(109, note_period_samples'length);

            when 82 =>
                -- Note code 82 is A#5 at 932.33 Hz
                note_linear_diff    <= to_unsigned(2606977, note_linear_diff'length);
                note_period_samples <= to_unsigned(103, note_period_samples'length);

            when 83 =>
                -- Note code 83 is B5 at 987.77 Hz
                note_linear_diff    <= to_unsigned(2761996, note_linear_diff'length);
                note_period_samples <= to_unsigned(97, note_period_samples'length);

            when 84 =>
                -- Note code 84 is C6 at 1046.5 Hz
                note_linear_diff    <= to_unsigned(2926232, note_linear_diff'length);
                note_period_samples <= to_unsigned(92, note_period_samples'length);

            when 85 =>
                -- Note code 85 is C#6 at 1108.73 Hz
                note_linear_diff    <= to_unsigned(3100235, note_linear_diff'length);
                note_period_samples <= to_unsigned(87, note_period_samples'length);

            when 86 =>
                -- Note code 86 is D6 at 1174.66 Hz
                note_linear_diff    <= to_unsigned(3284585, note_linear_diff'length);
                note_period_samples <= to_unsigned(82, note_period_samples'length);

            when 87 =>
                -- Note code 87 is D#6 at 1244.51 Hz
                note_linear_diff    <= to_unsigned(3479896, note_linear_diff'length);
                note_period_samples <= to_unsigned(77, note_period_samples'length);

            when 88 =>
                -- Note code 88 is E6 at 1318.51 Hz
                note_linear_diff    <= to_unsigned(3686822, note_linear_diff'length);
                note_period_samples <= to_unsigned(73, note_period_samples'length);

            when 89 =>
                -- Note code 89 is F6 at 1396.91 Hz
                note_linear_diff    <= to_unsigned(3906052, note_linear_diff'length);
                note_period_samples <= to_unsigned(69, note_period_samples'length);

            when 90 =>
                -- Note code 90 is F#6 at 1479.98 Hz
                note_linear_diff    <= to_unsigned(4138318, note_linear_diff'length);
                note_period_samples <= to_unsigned(65, note_period_samples'length);

            when 91 =>
                -- Note code 91 is G6 at 1567.98 Hz
                note_linear_diff    <= to_unsigned(4384395, note_linear_diff'length);
                note_period_samples <= to_unsigned(61, note_period_samples'length);

            when 92 =>
                -- Note code 92 is G#6 at 1661.22 Hz
                note_linear_diff    <= to_unsigned(4645104, note_linear_diff'length);
                note_period_samples <= to_unsigned(58, note_period_samples'length);

            when 93 =>
                -- Note code 93 is A6 at 1760.0 Hz
                note_linear_diff    <= to_unsigned(4921317, note_linear_diff'length);
                note_period_samples <= to_unsigned(55, note_period_samples'length);

            when 94 =>
                -- Note code 94 is A#6 at 1864.66 Hz
                note_linear_diff    <= to_unsigned(5213953, note_linear_diff'length);
                note_period_samples <= to_unsigned(51, note_period_samples'length);

            when 95 =>
                -- Note code 95 is B6 at 1975.53 Hz
                note_linear_diff    <= to_unsigned(5523991, note_linear_diff'length);
                note_period_samples <= to_unsigned(49, note_period_samples'length);

            when 96 =>
                -- Note code 96 is C7 at 2093.0 Hz
                note_linear_diff    <= to_unsigned(5852465, note_linear_diff'length);
                note_period_samples <= to_unsigned(46, note_period_samples'length);

            when 97 =>
                -- Note code 97 is C#7 at 2217.46 Hz
                note_linear_diff    <= to_unsigned(6200470, note_linear_diff'length);
                note_period_samples <= to_unsigned(43, note_period_samples'length);

            when 98 =>
                -- Note code 98 is D7 at 2349.32 Hz
                note_linear_diff    <= to_unsigned(6569170, note_linear_diff'length);
                note_period_samples <= to_unsigned(41, note_period_samples'length);

            when 99 =>
                -- Note code 99 is D#7 at 2489.02 Hz
                note_linear_diff    <= to_unsigned(6959793, note_linear_diff'length);
                note_period_samples <= to_unsigned(39, note_period_samples'length);

            when 100 =>
                -- Note code 100 is E7 at 2637.02 Hz
                note_linear_diff    <= to_unsigned(7373644, note_linear_diff'length);
                note_period_samples <= to_unsigned(36, note_period_samples'length);

            when 101 =>
                -- Note code 101 is F7 at 2793.83 Hz
                note_linear_diff    <= to_unsigned(7812103, note_linear_diff'length);
                note_period_samples <= to_unsigned(34, note_period_samples'length);

            when 102 =>
                -- Note code 102 is F#7 at 2959.96 Hz
                note_linear_diff    <= to_unsigned(8276635, note_linear_diff'length);
                note_period_samples <= to_unsigned(32, note_period_samples'length);

            when 103 =>
                -- Note code 103 is G7 at 3135.96 Hz
                note_linear_diff    <= to_unsigned(8768789, note_linear_diff'length);
                note_period_samples <= to_unsigned(31, note_period_samples'length);

            when 104 =>
                -- Note code 104 is G#7 at 3322.44 Hz
                note_linear_diff    <= to_unsigned(9290209, note_linear_diff'length);
                note_period_samples <= to_unsigned(29, note_period_samples'length);

            when 105 =>
                -- Note code 105 is A7 at 3520.0 Hz
                note_linear_diff    <= to_unsigned(9842633, note_linear_diff'length);
                note_period_samples <= to_unsigned(27, note_period_samples'length);

            when 106 =>
                -- Note code 106 is A#7 at 3729.31 Hz
                note_linear_diff    <= to_unsigned(10427907, note_linear_diff'length);
                note_period_samples <= to_unsigned(26, note_period_samples'length);

            when 107 =>
                -- Note code 107 is B7 at 3951.07 Hz
                note_linear_diff    <= to_unsigned(11047982, note_linear_diff'length);
                note_period_samples <= to_unsigned(24, note_period_samples'length);

            when 108 =>
                -- Note code 108 is C8 at 4186.01 Hz
                note_linear_diff    <= to_unsigned(11704930, note_linear_diff'length);
                note_period_samples <= to_unsigned(23, note_period_samples'length);

            when others =>
                -- note is out of range, default to 0
                note_linear_diff    <= (others => '0');
                note_period_samples <= (others => '0');
        end case;
    end process mux;
end architecture lut;

-- DO NOT CHANGE THIS FILE DIRECTLY, INSTEAD CHANGE linear_diff.py.