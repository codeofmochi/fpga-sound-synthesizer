#
# This file is a helper to generate the oscillator component
#
# file:         osc.py
# generates:    osc.vhd
# author:       Alexandre CHAU
import datetime

header = f"""--
-- Sound synthesizer oscillator module
-- Computes an audio wave given a note frequency
--
-- file:                osc.vhd
-- auto-generated from: osc.py
-- last generated:      {datetime.date.today()}
-- author:              Alexandre CHAU & Loïc DROZ
--
"""