#!/usr/bin/env python

import sys, subprocess, os

alignment = sys.argv[1]

stem = alignment[:alignment.rfind('.a3m')]


strength = "0.01"
print alignment, strength
if not os.path.exists(stem + '.0.01.plm20'.format(strength)):
    strength = "0.01"
    a = subprocess.check_output('/home/skwarkmj/skwarkmj/sw/julia/bin/julia -p 12 /dors/meilerlab/home/skwarkmj/project/plmconv/runplm.jl ' + alignment + ' ' + str(strength) + ' ' + stem + '.0.01.plm20'.format(strength), shell=True)
    print a
    subprocess.call('gzip ' + stem + '.0.01.plm20.Jtensor'.format(strength), shell=True)

"""
if not os.path.exists(stem + '.0.01.plm20'.format(strength)):
    strength = "0.01"
    a = subprocess.check_output('/home/skwarkmj/skwarkmj/sw/julia/bin/julia -p 12 /dors/meilerlab/home/skwarkmj/project/plmconv/runplm.jl ' + alignment + ' ' + str(strength) + ' ' + stem + '.0.01.plm20'.format(strength), shell=True)
    subprocess.call('gzip ' + stem + '.0.01.plm20.Jtensor'.format(strength), shell=True)
"""
