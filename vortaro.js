'use strict';

// Main search function.
function search(term) {
    term = normalize_english(term);
    if (term.length === 0) {
        return [];
    }

    // This breaks for English words with "ux", but... that's OK.
    term = xreplace(term);

    var matchlist = search_exact(term);
    if (matchlist.length !== 0) {
        return matchlist;
    }

    // If no results were found, try fixing input to a standard dictionary form.
    var normalized = normalize_suffix(term);
    if (normalized !== term) {
        return search_exact(normalized);
    }

    return [];
}

// Normalize "to foo", "to be foo", and "be foo" => "foo".
function normalize_english(string) {
    if (string.startsWith('to ') || string.startsWith('be ')) {
        return string.substr(3);
    }
    return string;
}

// Support the x-system.
function xreplace(text) {
    var pairs = [
        ['cx', 'ĉ'],
        ['gx', 'ĝ'],
        ['hx', 'ĥ'],
        ['jx', 'ĵ'],
        ['sx', 'ŝ'],
        ['ux', 'ŭ'],
        ['Cx', 'Ĉ'],
        ['Gx', 'Ĝ'],
        ['Hx', 'Ĥ'],
        ['Jx', 'Ĵ'],
        ['Sx', 'Ŝ'],
        ['Ux', 'Ŭ']
    ];

    text = text.replace('X', 'x');
    for (var i = 0; i < pairs.length; ++i) {
        text = text.replace(pairs[i][0], pairs[i][1]);
    }
    return text;
}

// Given an esperanto word, try to get a standard form.
function normalize_suffix(word) {
    var suffices = [
        ['as', 'i'],
        ['os', 'i'],
        ['is', 'i'],
        ['us', 'i'],
        ['u',  'i'],

        ['oj', 'o'],
        ['ojn', 'o'],
        ['on', 'o'],

        ['aj', 'a'],
        ['ajn', 'a'],
        ['an', 'a'],

        ['en', 'e']
    ];

    for (var i = 0; i < suffices.length; ++i) {
        if (word.endsWith(suffices[i][0])) {
            return word.slice(0, -1 * suffices[i][0].length) + suffices[i][1];
        }
    }

    return word;
}

// Given an esperanto word subject to normal grammar rules, get the root.
function getroot(word) {
    word = normalize_suffix(word);

    // Remove the function indicator.
    var lastchar = word[word.length - 1]
    if (lastchar === 'a' || lastchar === 'i' || lastchar === 'o' || lastchar === 'e') {
        word = word.slice(0, -1);
    }

    // Get out of participle form.
    var suffices = [
        'ant', 'ont', 'int', 'unt', 'at', 'ot', 'it', 'ut'
    ];

    for (var i = 0; i < suffices.length; ++i) {
        if (word.endsWith(suffices[i])) {
            return word.slice(0, -1 * suffices[i].length);
        }
    }

    return word;
}

// Returns a list of match indices into espdic.
function search_exact(word) {
    var lowerWord = word.toLowerCase();
    var matches = [];

    // Find all potentially matching candidates quickly.
    // Does not care whether the entry was in English or Esperanto.
    for (var i = 0; i < espdic.length; ++i) {
        var entry = espdic_lower[i];
        for (var j = 0; j < entry.length; ++j) {
            // FirefoxOS 2.2 doesn't support ES6 includes().
            if (entry[j].indexOf(lowerWord) !== -1) {
                matches.push(i);
                break;
            }
        }
    }

    // Filter out exact matches.
    var exactmatches = [];
    for (var i = 0; i < matches.length; ++i) {
        var entry = espdic_lower[matches[i]];
        for (var j = 0; j < entry.length; ++j) {
            var lower = normalize_english(entry[j]);

            // Remove a parenthesis pair.
            // A search for "paragraph" should return "paragraph (text)".
            var paren = lower.indexOf('(');
            if (paren !== -1) {
                if (paren === 0) {
                    lower = lower.substr(lower.indexOf(')')+1);
                } else {
                    lower = lower.substr(0, paren);
                }
                lower = lower.trim();
            }

            if (lower === lowerWord) {
                exactmatches.push(matches[i]);
                break;
            }
        }
    }

    // If there are exact matches, just return those.
    if (exactmatches.length > 0) {
        return exactmatches;
    }

    return matches;
}

// Given an esperanto word, look up an etymology.
function find_etymology(word) {
    // The etymology dictionary is entirely in lowercase.
    var lowerWord = word.toLowerCase();

    // Look for the word directly.
    for (var i = 0; i < etymology.length; ++i) {
        if (etymology[i][0] === lowerWord) {
            return etymology[i][1];
        }
    }

    // If it wasn't found, try to compare roots.
    // We can't do this in the first place because of exceptions.
    // For example, "tri" and "tro" have distinct etymologies.
    var root = getroot(lowerWord);
    for (var i = 0; i < etymology.length; ++i) {
        if (etymology[i][0].slice(0, -1) === root) {
            return etymology[i][1];
        }
    }

    return "";
}
