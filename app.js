'use strict';

var searchfield = document.getElementById("searchfield");
var results = document.getElementById("results");

// For FirefoxOS, we want the Enter key to dismiss the on-screen keyboard.
// Desktop doesn't have an on-screen keyboard, so Enter shouldn't lose focus.
if (navigator.userAgent.search('Mobile') !== -1) {
    searchfield.addEventListener("keypress", blur_on_enter, false);
    // The autofocus attribute doesn't bring up the keyboard in FxOS.
    searchfield.focus();
}

function blur_on_enter(keyevent) {
    // keyCode is deprecated, but non-Firefox-desktop doesn't support key.
    if (keyevent.keyCode === 13 || keyevent.key === "Enter") {
        searchfield.blur();
    }
}

searchfield.addEventListener("input", on_keystroke, false);

function on_keystroke() {
    results.innerHTML = makehtml(search(searchfield.value));
}

// Given a list of match indices into espdic, display them as HTML.
function makehtml(matchlist) {
    if (matchlist.length === 0) {
        return '<span lang="eo">Nenio trovita.</span>';
    }

    var resultlen = Math.min(matchlist.length, 20);

    var html = "";
    for (var i = 0; i < resultlen; ++i) {
        var entry = espdic[matchlist[i]];

        html += '<div class="resultrow">';
        html += '<span class="eo-result" lang="eo">' + entry[0] + '</span>';

        // Add a space between eo-result and en-result for screen readers.
        html += ' ';

        html += '<span class="en-result" lang="en">' + entry.slice(1).join(', ') + '</span>';

        var etym = find_etymology(entry[0]);
        if (etym.length > 0) {
            html += '<div class="etym-result">' + etym + '</div>';
        }
        html += '</div>';
    }

    return html;
}
