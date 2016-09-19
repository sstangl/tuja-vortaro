// vim: set ts=4 sts=4 sw=4 et:
'use strict';

var DEBUG = false;

var langfield = document.getElementById("langfield");
var searchfield = document.getElementById("searchfield");
var results = document.getElementById("results");

// The current active dictionary.
var dictionary = undefined;
var dictionary_lower = undefined;

// Continuation for rendering more results in response to a scroll event,
// or undefined if all results are displayed.
var scroll_continuation = undefined;

var global = this;

// 0: Language Code.
// 1: Path to dictionary JS file.
// 2: Name of dictionary variable defined by that JS file.
var languages = [
    ['be', 'revo/revo-be.js', 'revo_be'],
    ['cs', 'revo/revo-cs.js', 'revo_cs'],
    ['de', 'revo/revo-de.js', 'revo_de'],
    ['en', 'espdic/espdic.js', 'espdic'],
    ['es', 'revo/revo-es.js', 'revo_es'],
    ['fr', 'revo/revo-fr.js', 'revo_fr'],
    ['hu', 'revo/revo-hu.js', 'revo_hu'],
    ['nl', 'revo/revo-nl.js', 'revo_nl'],
    ['pl', 'revo/revo-pl.js', 'revo_pl'],
    ['pt', 'revo/revo-pt.js', 'revo_pt'],
    ['ru', 'revo/revo-ru.js', 'revo_ru'],
    ['sk', 'revo/revo-sk.js', 'revo_sk'],
];

// Add an option to the language selector.
function add_language_option(value, text) {
    var option = document.createElement('option');
    option.text = text;
    option.value = value;
    langfield.options.add(option);
}

// Gets the current language option (currently for supplying tags to screen readers).
function get_selected_language() {
    return langfield.value;
}

// Load a JS file (one of the dictionaries), calling the callback after load.
function load_javascript(url, callback) {
    var script = document.createElement("script");
    script.type = "text/javascript";

    script.onload = function () {
        callback();
    };

    script.src = url;
    document.getElementsByTagName("head")[0].appendChild(script);
}

function load_and_set_current_dictionary() {
    for (var i = 0; i < languages.length; ++i) {
        if (languages[i][0] !== langfield.value) {
            continue;
        }

        // Avoid redundant dictionary loads.
        if (global[languages[i][2]] !== undefined) {
            global.dictionary = global[languages[i][2]];
            global.dictionary_lower = global[languages[i][2] + '_lower'] || global.dictionary;
            on_keystroke();
        } else {
            load_javascript(languages[i][1], function () {
                global.dictionary = global[languages[i][2]];
                global.dictionary_lower = global[languages[i][2] + '_lower'] || global.dictionary;
                on_keystroke();
            });
        }
        return;
    }
}

function blur_on_enter(keyevent) {
    // keyCode is deprecated, but non-Firefox-desktop doesn't support key.
    if (keyevent.keyCode === 13 || keyevent.key === "Enter") {
        searchfield.blur();
    }
}

// Height of the entire document, independent of viewport.
function docheight() {
    return Math.max(
        document.body.scrollHeight, document.documentElement.scrollHeight,
        document.body.offsetHeight, document.documentElement.offsetHeight,
        document.body.clientHeight, document.documentElement.clientHeight
    );
}

// Scroll event handler, which checks if more dictionary results
//  exist to be printed from the given search.
// The continuation called here is created by append_more_results().
function append_more_results_on_scroll() {
    if (scroll_continuation === undefined) {
        return;
    }

    // Scroll delta from the bottom of the page under which results are appanded.
    var bottom_delta = 200;

    // Height is measured to the top of the scrollbar, so include the window.
    // Distance tracked is from the bottom of the document.
    // This works in both Firefox and Chrome.
    var scrollheight = window.innerHeight + window.scrollY;

    // Scrolling near the bottom triggers an update.
    // Firefox provides scrollMaxY, with a scrollY from the bottom of the scrollbar.
    if (docheight() - scrollheight <= bottom_delta) {
        scroll_continuation = scroll_continuation();
    }
}

function on_keystroke() {
    var debug_time;

    // The scroll event handler is only valid for a given search,
    // changed on keystroke or language change.

    var serĉo = searchfield.value.trim();
    if (serĉo === '') {
        results.innerHTML = '';
    } else {
        if (DEBUG === true) {
            debug_time = performance.now();
        }

        var matches = search(serĉo, dictionary, dictionary_lower);
        if (matches.length() === 0) {
            results.innerHTML = '<div class="resultrow-0" lang="eo">Nenio trovita.</span>';
        } else {
            // Append results to the div, giving either a continuation for appending more
            // results, or undefined if all results are displayed.
            results.innerHTML = '';
            scroll_continuation = append_more_results(0, matches, dictionary);

            // Keep appending results until the screen is filled or all entries are shown.
            while (scroll_continuation !== undefined && docheight() <= window.innerHeight) {
                scroll_continuation = scroll_continuation();
            }
        }

        if (DEBUG === true) {
            console.log(performance.now() - debug_time);
        }
    }
}

// Make the HTML for a single dictionary entry.
function makeentry(i, entry, lang) {
    var parity = i % 2;

    var html = '<div class="resultrow-' + parity + '">';
    html += '<span class="eo-result" lang="eo">' + entry[0] + '</span>';

    // Se la vorto estas verbo, montru ankaŭ ĝian transitivecon.
    if (entry[0][entry[0].length - 1] === 'i') {
        var transitiveco = trovu_transitivecon(entry[0]);
        if (transitiveco.length !== 0) {
            html += ' <span class="eo-informacio" lang="eo">(' + transitiveco + ')</span>';
        }
    }

    // Add a space between eo-result and en-result for screen readers.
    html += ' <span class="en-result" lang="' +lang+ '">' + entry.slice(1).join(', ') + '</span>';

    var etym = find_etymology(entry[0]);
    if (etym.length > 0) {
        html += '<div class="etym-result">' + etym + '</div>';
    }
    html += '</div>';

    return html;
}

// Appends a preset number of results to the results div.
// Returns a continuation that appends more results, or undefined
//  if all results have already been displayed.
function append_more_results(start, matchlist, dictionary) {
    if (start >= matchlist.length() || matchlist.length() === 0) {
        return undefined;
    }

    var ENTRIES_AT_ONCE = 20;

    var entries = Math.min(matchlist.length() - start, ENTRIES_AT_ONCE);
    var lang = get_selected_language();

    var html = "";

    for (var i = start; i < start + entries; ++i) {
        // Add a separator between the exact and inexact match results.
        if (i > 0 && matchlist.isExact(i-1) && !matchlist.isExact(i)) {
            html += '<hr class="exactsep">';
        }

        html += makeentry(i, dictionary[matchlist.get(i)], lang);

    }

    results.innerHTML += html;

    if (start + entries === matchlist.length()) {
        return undefined;
    }

    return function() {
        return append_more_results(start + ENTRIES_AT_ONCE, matchlist, dictionary);
    };
}

// Roughly parse index.html?q=foo&a=bar into an object {q: foo, a: bar}.
function getqueryobj() {
    var url = document.location.href;
    var i = url.indexOf('?');
    var args = url.slice(i+1);

    var obj = {};
    var split = args.split('&');
    for (var j = 0; j < split.length; ++j) {
        var arg = split[j];
        if (arg.indexOf('=') >= 0) {
            var v = decodeURIComponent(arg).split('=');
            obj[v[0]] = v[1];
        }
    }
    return obj;
}

// Language selector setup and initialization.
(function () {
    // Populate the language selector.
    languages.forEach(function (val, idx) {
        add_language_option(val[0], val[0]);
    });

    // Detect and set the default language based on the browser's language preference.
    if (!navigator.language)
        return;

    for (var i = 0; i < languages.length; ++i) {
        if (navigator.language.indexOf(languages[i][0]) === -1) {
            continue;
        }

        for (var j = 0; j < langfield.options.length; ++j) {
            if (langfield.options[j].value === languages[i][0]) {
                langfield.selectedIndex = j;
                return;
            }
        }
    }
})();

// Dictionary and Event initialization.
(function () {
    // Load the initial dictionary, and set it to update on language change.
    load_and_set_current_dictionary();

    langfield.addEventListener("change",
        function () {
            load_and_set_current_dictionary();
            searchfield.focus();
        }, false);

    // Keydown needs to wait for the value to change.
    langfield.addEventListener("keydown",
        function () {
            setTimeout(load_and_set_current_dictionary, 0);
        }, false);

    searchfield.addEventListener("input", on_keystroke, false);

    window.addEventListener("scroll", append_more_results_on_scroll, false);

    // For FirefoxOS, we want the Enter key to dismiss the on-screen keyboard.
    // Desktop doesn't have an on-screen keyboard, so Enter shouldn't lose focus.
    if (navigator.userAgent.search('Mobile') !== -1) {
        searchfield.addEventListener("keypress", blur_on_enter, false);
        // The autofocus attribute doesn't bring up the keyboard in FxOS.
        searchfield.focus();
    }
})();

// Argument handling.
(function () {
    var query = getqueryobj();
    if (query.vorto !== undefined) {
        searchfield.value = query.vorto;
        on_keystroke();
    }
})();
