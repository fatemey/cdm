import os
from bmi.wrapper import BMIWrapper

os.environ['DYLD_LIBRARY_PATH'] = '/Users/hoonhout/GitHub/CDM/.libs/'

with BMIWrapper('cdm', '/Users/hoonhout/GitHub/CDM/data/input/param.par') as model:
    tstop = model.get_end_time()
    while model.get_current_time() < tstop:
        model.update(-1)

