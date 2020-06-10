# Generates all VHD files with make
NOCACHE=PYTHONDONTWRITEBYTECODE=1

all: linear_diff osc sound_gen

linear_diff:
	$(NOCACHE) python3 linear_diff.py

osc:
	$(NOCACHE) python3 osc.py

sound_gen:
	$(NOCACHE) python3 sound_gen.py