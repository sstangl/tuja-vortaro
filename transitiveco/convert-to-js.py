#!/usr/bin/env python
# Konvertas la listo de vorto-transitiveco al JS-skripto, por uzi en la retpagxo.

trans = open('transitiveco.txt', 'r')
js = open('transitiveco.js', 'w')

print >>js, "'use strict';"

NTR = 0
TR = 1
TR_NTR = 2

print >>js, 'var transitiveco = {'

def kurtnomo_al_cifero(s):
    if s == 't':
        return TR
    if s == 'n':
        return NTR
    if s == 'tn':
        return TR_NTR
    raise Exception('nevalida transitiveco: %s' % s)

# Po linio enhavas verbon kaj 't', 'n', aux 'tr', kiu signifas ambaux formojn.
for linio in trans.readlines():
    partoj = linio.strip().split()
    print >>js, '%s:%s,' % (partoj[0], kurtnomo_al_cifero(partoj[1]))

print >>js, '};'
trans.close()
js.close()
