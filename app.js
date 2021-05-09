// @license magnet:?xt=urn:btih:cf05388f2679ee054f2beb29a391d25f4e673ac3&dn=gpl-2.0.txt GPL-v2
// vim: set ts=4 sts=4 sw=4 et:
'use strict';

/**
 * Milliseconds to wait after the user has finished typing before updating the URL.
 * @type {number}
 */
const URL_UPDATE_DELAY = 400;
let update_url_timeout_id = 0;

var DEBUG = false;

const langfield = document.getElementById("langfield");
const searchfield = document.getElementById("searchfield");
const results = document.getElementById("results");
const htmlElement = document.getElementsByTagName("html")[0];
const toggleSwitch = document.getElementById("toggleSwitch");


// The current active dictionary.
var dictionary = undefined;
var dictionary_lower = undefined;

// Continuation for rendering more results in response to a scroll event,
// or undefined if all results are displayed.
var scroll_continuation = undefined;

var global = this;

/**
 * A mapping from a language's code to its dictionary data.
 * Implements the following interface:
 * interface {
 *     [language_code: string]: {
 *         path: string; // Path to dictionary JS file.
 *         name: string; // Name of dictionary variable defined by that JS file.
 *     }
 * }
 * @type {object}
 */
const languages = {
    be: {path: 'revo/revo-be.js', name: 'revo_be'},
    cs: {path: 'revo/revo-cs.js', name: 'revo_cs'},
    de: {path: 'revo/revo-de.js', name: 'revo_de'},
    en: {path: 'espdic/espdic.js', name: 'espdic'},
    es: {path: 'revo/revo-es.js', name: 'revo_es'},
    fr: {path: 'revo/revo-fr.js', name: 'revo_fr'},
    hu: {path: 'revo/revo-hu.js', name: 'revo_hu'},
    nl: {path: 'revo/revo-nl.js', name: 'revo_nl'},
    pl: {path: 'revo/revo-pl.js', name: 'revo_pl'},
    pt: {path: 'revo/revo-pt.js', name: 'revo_pt'},
    ru: {path: 'revo/revo-ru.js', name: 'revo_ru'},
    sk: {path: 'revo/revo-sk.js', name: 'revo_sk'},
};

// Attempt to get saved localStorage; Default to "light"
var mode = (function () {
    try {
        return localStorage.getItem("tvTheme");
    } catch (error) {
        console.log(error);
        return false;
    }
})() || "light";

// Change toggle switch’s text on page reload
if (mode) {
    htmlElement.className = mode;
    if (mode === "light") {
        toggleSwitch.value = "Mallume";
    } else {
        toggleSwitch.value = "Lume";
    }
}

// Switch to alternate css file while attempting to save to localStorage
function toggle_theme() {
    try {
        if (toggleSwitch.value === "Mallume") {
            htmlElement.className = "dark";
            toggleSwitch.value = "Lume";
            localStorage.setItem("tvTheme", "dark");
        } else {
            htmlElement.className = "light";
            toggleSwitch.value = "Mallume";
            localStorage.setItem("tvTheme", "light");
        }
    } catch (error) {
        console.log(error);
    }
}

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

// Saves the selected language option to localStorage.
function save_selected_language() {
    localStorage.setItem("tvLang", get_selected_language());
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
    const selected_language_code = langfield.value;
    // Prevent crash if HTML is changed by user.
    if (!(selected_language_code in languages)) {
        return false
    }
    const current_language = languages[selected_language_code];
    const set_current_dictionary = () => {
        global.dictionary = global[current_language.name];
        global.dictionary_lower = global[current_language.name + '_lower'] || global.dictionary;
        on_keystroke();
    }
    // Avoid redundant dictionary loads.
    if (global[current_language.name]) {
        // Dictionary already loaded. Set as current.
        set_current_dictionary();
    } else {
        // Load the dictionary, and set as current on-load.
        load_javascript(current_language.path, set_current_dictionary);
    }
    update_url();
    return true;
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
    let debug_time = 0;

    // Wait until the user has stopped typing for URL_UPDATE_DELAY milliseconds before calling update_url()
    clearTimeout(update_url_timeout_id)
    update_url_timeout_id = setTimeout(update_url, URL_UPDATE_DELAY);

    // The scroll event handler is only valid for a given search,
    // changed on keystroke or language change.
    const serĉo = searchfield.value.trim();
    if (serĉo === '') {
        results.innerHTML = '';
    } else {
        if (DEBUG === true) {
            debug_time = performance.now();
        }
        // Prevent race condition.
        if (!(dictionary && dictionary_lower)) {
            return;
        }
        const matches = search(serĉo, dictionary, dictionary_lower);
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
    html += ' <span class="en-result" lang="' + lang + '">' + entry.slice(1).join(', ') + '</span>';

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
        if (i > 0 && matchlist.isExact(i - 1) && !matchlist.isExact(i)) {
            html += '<hr class="exactsep">';
        }

        html += makeentry(i, dictionary[matchlist.get(i)], lang);

    }

    results.innerHTML += html;

    if (start + entries === matchlist.length()) {
        return undefined;
    }

    return function () {
        return append_more_results(start + ENTRIES_AT_ONCE, matchlist, dictionary);
    };
}

// Parse index.html?q=foo&a=bar into an object.
function getqueryobj() {
    return new URLSearchParams(location.search);
}

function set_language_if_exists(language_code) {
    const exists = language_code in languages;
    if (exists) {
        langfield.value = language_code;
    }
    return exists;
}

function update_url() {
    const vorto = searchfield.value.trim();
    const lingvo = langfield.value.trim();
    const params = {lingvo, vorto};
    const query = new URLSearchParams(params);
    const url = `${location.protocol}//${location.host}${location.pathname}?${query.toString()}`;
    window.history.replaceState(null, '', url);
}

// Language selector setup and initialization.
(function () {
    // Populate the language selector.
    Object.keys(languages).forEach(
        language_code => add_language_option(language_code, language_code)
    );

    // Load set language from localStorage otherwise detect and set the default
    // language based on the browser's language preference.
    const language = localStorage.getItem("tvLang") || navigator.language;
    set_language_if_exists(language)
})();

// Dictionary and Event initialization.
(function () {
    const query = getqueryobj();

    // Allow a "lingvo" GET parameter to override LocalStorage.
    set_language_if_exists(query.get('lingvo'))

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

    // Allow a "vorto" GET parameter to specify a search term.
    const vorto = query.get('vorto');
    if (vorto !== null) {
        searchfield.value = vorto;
        on_keystroke();
    }
})();
// @license-end
