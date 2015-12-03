'use strict';

var langfield = document.getElementById("langfield");
var searchfield = document.getElementById("searchfield");
var results = document.getElementById("results");

// The current active dictionary.
var dictionary = undefined;
var dictionary_lower = undefined;

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

function on_keystroke() {
    var serĉo = searchfield.value.trim();
    if (serĉo === '') {
        results.innerHTML = '';
    } else {
        results.innerHTML = makehtml(search(serĉo, dictionary, dictionary_lower), dictionary);
    }
}

// Given a list of match indices into a dictionary, display them as HTML.
function makehtml(matchlist, dictionary) {
    if (matchlist.length === 0) {
        return '<div class="resultrow" lang="eo">Nenio trovita.</span>';
    }

    var resultlen = Math.min(matchlist.length, 20);

    var html = "";
    for (var i = 0; i < resultlen; ++i) {
        var entry = dictionary[matchlist[i]];

        html += '<div class="resultrow">';
        html += '<span class="eo-result" lang="eo">' + entry[0] + '</span>';

        // Se la vorto estas verbo, montru ankaŭ ĝian transitivecon.
        if (entry[0][entry[0].length - 1] === 'i') {
            var transitiveco = trovu_transitivecon(entry[0]);
            if (transitiveco.length !== 0) {
                html += ' <span class="eo-informacio" lang="eo">(' + transitiveco + ')</span>';
            }
        }

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

    // For FirefoxOS, we want the Enter key to dismiss the on-screen keyboard.
    // Desktop doesn't have an on-screen keyboard, so Enter shouldn't lose focus.
    if (navigator.userAgent.search('Mobile') !== -1) {
        searchfield.addEventListener("keypress", blur_on_enter, false);
        // The autofocus attribute doesn't bring up the keyboard in FxOS.
        searchfield.focus();
    }
})();
