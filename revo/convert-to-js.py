#!/usr/bin/env python

import re
import os
import xml.etree.ElementTree as ET
from lxml import etree

# There are a ton of entities defined in src/cfg.
# Apparently these have to be loaded manually and shoved into a custom parser.
def get_entities():
    entities = {}

    with open('src/dtd/vokosgn.dtd', 'rb') as f:
        dtd = etree.DTD(f)
        for entity in dtd.iterentities():
            entities[entity.name] = entity.content

    with open('src/dtd/vokomll.dtd', 'rb') as f:
        dtd = etree.DTD(f)
        for entity in dtd.iterentities():
            entities[entity.name] = entity.content

    # Seed some default entities.
    entities[u'apos'] = "'"
    entities[u'quot'] = '"'

    # Entities sometimes refer to a canonical entity.
    for key, value in entities.iteritems():
        if '&' in value and ';' in value:
            pre  = value[:value.index('&')]
            sym  = value[value.index('&')+1 : value.index(';')]
            post = value[value.index(';')+1:]

            entities[key] = u"%s%s%s" % (pre, entities[sym], post)

    return entities


# Makes a one-time-use XMLParser object.
def make_parser(entities):
    parser = ET.XMLParser()
    parser.entity = entities
    return parser


# Given a root and a kap Element, create the full Esperanto word(s).
def kap_to_esperanto(root, kap):
    # <kap><tld/>i</kap>
    tld = kap.find('tld')
    if tld is None:
        # <kap>Pumpilo</kap>
        word = kap.text.strip()
    else:
        word = ((kap.text or '') + root + (kap.find('tld').tail or '')).strip()

    # Handle <var> in the kap, which specifies variants.
    var = kap.find('var')
    if var is not None:
        # Sometimes the comma separating variants is the tail of another tag.
        # <kap><tld/>ilo<fnt>Z</fnt>,
        word = word + ', ' + kap_to_esperanto(root, var.find('kap'))
        word = word.replace(',,', ',')
        word = word.replace('  ', ' ')

    return re.sub('\s+', ' ', word)


# Create language text out of a trd translation element.
def trd_to_text(trd):
    return re.sub('\s+', ' ', ''.join(trd.itertext()))


def mark_translation(esperanto, lang, translation):
    global dictionary
    if lang not in dictionary:
        dictionary[lang] = {}
    
    entries = dictionary[lang]
    if esperanto not in entries:
        entries[esperanto] = [translation]
    elif translation not in entries[esperanto]:
        entries[esperanto].append(translation)


def extract_translations(esperanto, root):
    # Translations.
    # Non-group translations:
    for trd in root.findall('trd'):
        translation = trd_to_text(trd)
        mark_translation(esperanto, trd.attrib['lng'], translation)

    # Group translations:
    for trdgrp in root.findall('trdgrp'):
        lng = trdgrp.attrib['lng']
        for trd in trdgrp.findall('trd'):
            translation = trd_to_text(trd)
            mark_translation(esperanto, lng, translation)


#####################################################################


dictionary = {}


def main():
    entities = get_entities()
    xmlfiles = ['src/xml/' + f for f in os.listdir('src/xml') if f[-4:] == '.xml']

    for xml in xmlfiles:
        parser = make_parser(entities)
        tree = ET.parse(xml, parser=parser)
        root = tree.getroot().find('art')

        radiko = root.find('kap').find('rad').text

        # Derivatives of the root.
        for drv in root.iter('drv'):
            esperanto = kap_to_esperanto(radiko, drv.find('kap'))

            extract_translations(esperanto, drv)

            # Senses of meaning of the derivative.
            for snc in drv.iter('snc'):
                extract_translations(esperanto, snc)

    # Output the dictionaries.
    for lang, entries in dictionary.iteritems():
        with open('revo-' + lang + '.js', 'wb') as js:

            print >>js, '// La Reta Vortaro, GPLv2'
            print >>js, "'use strict';"
            print >>js, 'var revo_%s = [' % lang

            ordered = sorted(entries.items())
            for entry in ordered:
                eo = entry[0].replace('"', "'");
                tra = ', '.join(entry[1]).replace('"', "'");
                print >>js, ('["%s","%s"],' % (eo, tra)).encode("utf-8")

            print >>js, '];'

            # Construct a lowercase version of the dictionary.
            # Done on load since it's very fast, even on phones.
            print >>js, 'var revo_%s_lower = revo_%s.map(function(a) { return a.map(function(x) { return x.toLowerCase(); }) });' % (lang, lang)

if __name__ == '__main__':
    main()

