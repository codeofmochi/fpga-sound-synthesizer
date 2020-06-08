steps = [601, 636, 674, 714, 757, 802, 850, 900, 954, 1010, 1070, 1134]

for i, step in enumerate(steps):
    print(f"when {i} =>")
    print(f"if octave_shift < 0 then")
    print(f"note_step <= shift_right(to_unsigned({step}, note_step'length), 0 - octave_shift);")
    print(f"elsif octave_shift > 0 then")
    print(f"note_step <= shift_left(to_unsigned({step}, note_step'length), octave_shift);")
    print(f"else")
    print(f"note_step <= to_unsigned({step}, note_step'length);")
    print(f"end if;")