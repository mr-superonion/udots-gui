#!/usr/bin/env python
import os
import numpy as np
import astropy.io.fits as pyfits

import matplotlib as mpl
mpl.use('agg')
mpl.rcParams['ps.useafm'] = True
mpl.rcParams['pdf.use14corefonts'] = True
mpl.rcParams['text.usetex'] = True
import matplotlib.pyplot as plt
