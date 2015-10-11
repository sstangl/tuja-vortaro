var searchfield = document.getElementById("searchfield");
var results = document.getElementById("results");

searchfield.addEventListener("keypress", function(e) {
    // Only respond to the enter key.
    if (e.keyCode != 13)
        return;

    // This breaks for English words with "ux", but... that's OK.
    var term = xreplace(searchfield.value);

    if (term.startsWith('to ')) {
        term = term.substr(3);
    }

    var matchlist = search(term);
    results.innerHTML = makehtml(matchlist);
}, false);

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

// Returns a list of match indices into espdic.
function search(word) {
    var lowerWord = word.toLowerCase();
    var matches = [];

    // Find all potentially matching candidates quickly.
    // Does not care whether the entry was in English or Esperanto.
    for (var i = 0; i < espdic.length; ++i) {
        var entry = espdic[i];
        for (var j = 0; j < entry.length; ++j) {
            if (entry[j].toLowerCase().includes(lowerWord)) {
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

            // Verbs often are entered as "to foo".
            if (lower.startsWith('to ')) {
                if (lower.substr(3) === lowerWord) {
                    exactmatches.push(matches[i]);
                    break;
                }
            }

            // But we also want to match on explicit searches.
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

    for (var i = 0; i < etymology.length; ++i) {
        if (etymology[i][0] === lowerWord) {
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

    if (matchlist.length > 20) {
        return "Tro multe da rezultoj!";
    }

    html = "";
    for (var i = 0; i < matchlist.length; ++i) {
        var entry = espdic[matchlist[i]];

        html += '<div class="resultrow">';
        html += '<span class="eo-result">' + entry[0] + '</span>';

        /*
        for (var j = 1; j < entry.length; ++j) {
            html += '<span class="en-result">' + entry[j] + '</span>';
        }
        */
        html += '<span class="en-result">' + entry.slice(1).join(', ') + '</span>';

        var etym = find_etymology(entry[0]);
        if (etym.length > 0) {
            html += '<div class="etym-result">' + etym + '</div>';
        }
        html += '</div>';   
    }

    return html;
}
