#!/usr/bin/env python
# Converts the etymology.txt project to JS.
# The resulting file shares the same license as etymology.txt: CC0 1.0 Universal.

etym = open('etymology.txt', 'r')
js = open('etymology.js', 'w')

print >>js, "// @license magnet:?xt=urn:btih:90dc5c0be029de84e523b9b3922520e79e0e6f08&dn=cc0.txt CC0-1.0"
print >>js, "'use strict';"
print >>js, 'var etymology = ['

# Each line contains an Esperanto word, followed by "=" and a list of sources.
# Instead of "=", some lines actually just contain an explanation, enclosed
#  within [] brackets.
for line in etym.readlines():
    line = line.replace('"', '\\"')

    if '[' in line:
        esperanto, sources = line.strip().split('[')
        sources = '[' + sources
    else:
        esperanto, sources = line.strip().split('=')

    esperanto = esperanto.strip()
    sources = sources.strip()

    print >>js, '["%s","%s"],' % (esperanto, sources)

print >>js, '];'
print >>js, "// @license-end"

etym.close()
js.close()
