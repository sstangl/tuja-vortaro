#!/usr/bin/env python
# Konvertas la listo de vorto-transitiveco al JS-skripto, por uzi en la retpagxo.

trans = open('transitiveco.txt', 'r')
js = open('transitiveco.js', 'w')

print >>js, "// @license magnet:?xt=urn:btih:90dc5c0be029de84e523b9b3922520e79e0e6f08&dn=cc0.txt CC0-1.0"
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

print >>js, "function trovu_transitivecon(vorto) {"
print >>js, "    var sercxo = transitiveco[vorto];"
print >>js, "    if (sercxo === undefined)"
print >>js, "        return '';"
print >>js, "    if (sercxo === %s)" % NTR
print >>js, "        return 'ntr';"
print >>js, "    if (sercxo === %s)" % TR
print >>js, "        return 'tr';"
print >>js, "    if (sercxo === %s)" % TR_NTR
print >>js, "        return 'tr/ntr';"
print >>js, "    return '';"
print >>js, "}"
print >>js, "// @license-end"

trans.close()
js.close()
