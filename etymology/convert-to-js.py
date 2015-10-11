#!/usr/bin/env python
# Converts the etymology.txt project to JS.
# The resulting file shares the same license as etymology.txt: CC0 1.0 Universal.

etym = open('etymology.txt', 'r')
js = open('etymology.js', 'w')

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

print >>js, ']'
etym.close()
js.close()
