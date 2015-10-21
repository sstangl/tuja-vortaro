var searchfield = document.getElementById("searchfield");
var results = document.getElementById("results");

// For FirefoxOS, we want the Enter key to dismiss the on-screen keyboard.
// Desktop doesn't have an on-screen keyboard, so Enter shouldn't lose focus.
if (navigator.userAgent.search('Mobile') !== -1) {
    searchfield.addEventListener("keypress", blur_on_enter, false);
}

searchfield.addEventListener("input", refresh, false);

function blur_on_enter(keyevent) {
    // keyCode is deprecated, but non-Firefox-desktop doesn't support key.
    if (keyevent.keyCode === 13 || keyevent.key === "Enter") {
        searchfield.blur();
    }
}

// Use the current value of the searchfield to refresh the results.
function refresh() {
    // This breaks for English words with "ux", but... that's OK.
    var term = xreplace(searchfield.value);
    if (term.length === 0) {
        return;
    }

    // Normalize "to foo", "to be foo", and "be foo" => "foo".
    if (term.startsWith('to ')) {
        term = term.substr(3);
    }
    if (term.startsWith('be ')) {
        term = term.substr(3);
    }

    var matchlist = search(term);

    // If no results were found, try fixing input to a standard dictionary form.
    if (matchlist.length === 0) {
        var normalized = normalize_suffix(term);
        if (normalized !== term) {
            matchlist = search(normalized);
        }
    }

    results.innerHTML = makehtml(matchlist);
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
function search(word) {
    var lowerWord = word.toLowerCase();
    var matches = [];

    // Find all potentially matching candidates quickly.
    // Does not care whether the entry was in English or Esperanto.
    for (var i = 0; i < espdic.length; ++i) {
        var entry = espdic[i];
        for (var j = 0; j < entry.length; ++j) {
            // FirefoxOS 2.2 doesn't support ES6 includes().
            if (entry[j].toLowerCase().indexOf(lowerWord) !== -1) {
                matches.push(i);
                break;
            }
        }
    }

    // Filter out exact matches.
    var exactmatches = [];
    for (var i = 0; i < matches.length; ++i) {
        var entry = espdic[matches[i]];
        for (var j = 0; j < entry.length; ++j) {
            var lower = entry[j].toLowerCase();

            // Normalize "to foo", "to be foo", and "be foo" => "foo".
            if (lower.startsWith('to ')) {
                lower = lower.substr(3);
            }
            if (lower.startsWith('be ')) {
                lower = lower.substr(3);
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

// Given a list of match indices into espdic, display them as HTML.
function makehtml(matchlist) {
    if (matchlist.length === 0) {
        return "Nenio trovita.";
    }

    // TODO: We could output a "more results" button.
    var resultlen = Math.min(matchlist.length, 20);

    html = "";
    for (var i = 0; i < resultlen; ++i) {
        var entry = espdic[matchlist[i]];

        html += '<div class="resultrow">';
        html += '<span class="eo-result">' + entry[0] + '</span>';

        // Add a space between eo-result and en-result for screen readers.
        html += ' ';

        html += '<span class="en-result">' + entry.slice(1).join(', ') + '</span>';

        var etym = find_etymology(entry[0]);
        if (etym.length > 0) {
            html += '<div class="etym-result">' + etym + '</div>';
        }
        html += '</div>';
    }

    return html;
}
