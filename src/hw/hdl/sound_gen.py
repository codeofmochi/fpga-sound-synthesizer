#
# This file is a helper to generate the sound_gen component, which handles
# the complete sound generation pipeline
#
# file:         sound_gen.py
# generates:    sound_gen.vhd
# author:       Alexandre CHAU
import math

# Configure DAC properties here
DAC_FREQ = 48000
DAC_DEPTH = 16
N_OSC = 1

# Derived properties
DAC_MAX_SIGNED_INT = (2 ** (DAC_DEPTH - 1) - 1)
DAC_MIN_SIGNED_INT = -(2 ** (DAC_DEPTH - 1))
OSC_RANGE = int(math.floor((DAC_MAX_SIGNED_INT - DAC_MIN_SIGNED_INT) / N_OSC))
OSC_DEPTH = math.ceil(math.log(OSC_RANGE, 2))
OSC_MAX = int(math.floor(OSC_RANGE / 2))
OSC_MIN = -OSC_MAX