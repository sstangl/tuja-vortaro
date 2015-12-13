// vim: set ts=4 sts=4 sw=4 et:
// Skripto por la testado de la vortaro. Ĝi estas uzebla per moderna JS-konko.
'use strict';

load('espdic/espdic.js');
load('revo/revo-cs.js');

load('etymology/etymology.js');
load('vortaro.js');

function search_en(x) {
    return search(x, espdic, espdic_lower);
}
function search_cs(x) {
    return search(x, revo_cs, revo_cs_lower);
}

//////////////////////////////////////////////////////////////////////////////

function listo_enhavas(listo, v) {
    for (var i = 0; i < listo.length; ++i) {
        if (v === listo[i])
            return true;
    }
    return false;
}

// Asertas, ke la trovit-listo kongruas kun la anticipata eo-vortolisto.
// La unua listo suplikas indeksojn en la tutprograman espdic-on.
function asertuKongruas(listo, eolisto) {
    var trovitaj = listo.exactMatches.map(function (x) { return listo.dict[x][0]; });

    eolisto.forEach(function (v) {
        if (!listo_enhavas(trovitaj, v)) {
            throw "Aserto: Serĉo rompiĝis! Ne trovita: " + v + ", en " + trovitaj;
        }
    });
}

// Asertas, ke la du enigoj egaliĝas.
function asertuEgalas(x, y) {
    if (x !== y) {
        throw "Aserto: " + x + " ne egalas " + y;
    }
}

//////////////////////////////////////////////////////////////////////////////

// Testas la x-sistemon.
(function () {
    // Testas, ke oni povas traduki ĉiun literon.
    asertuEgalas(xreplace("cxgxhxjxsxux"), "ĉĝĥĵŝŭ");
    asertuEgalas(xreplace("cXgXhXjXsXuX"), "ĉĝĥĵŝŭ");
    asertuEgalas(xreplace("CXGXHXJXSXUX"), "ĈĜĤĴŜŬ");
    asertuEgalas(xreplace("CxGxHxJxSxUx"), "ĈĜĤĴŜŬ");

    // Testas, ke povas ekzisti pli ol unu de la sama anstataŭaĵo.
    asertuEgalas(xreplace("cxcxcxcx"), "ĉĉĉĉ");
    asertuEgalas(xreplace("gxgxgxgx"), "ĝĝĝĝ");
    asertuEgalas(xreplace("hxhxhxhx"), "ĥĥĥĥ");
    asertuEgalas(xreplace("jxjxjxjx"), "ĵĵĵĵ");
    asertuEgalas(xreplace("sxsxsxsx"), "ŝŝŝŝ");
    asertuEgalas(xreplace("uxuxuxux"), "ŭŭŭŭ");

    // Testas, ke la funkcio ne ĝenas normalajn tekstojn.
    asertuEgalas(xreplace("xxxxxxxx"), "xxxxxxxx");
    asertuEgalas(xreplace("xXxXXxxX"), "xXxXXxxX");
    asertuEgalas(xreplace("xXuXXxgx"), "xXŭXxĝ");
    asertuEgalas(xreplace("kontraŭpluviloj"), "kontraŭpluviloj");
    asertuEgalas(xreplace("  Spaco-vorto  "), "  Spaco-vorto  ");
})();

// Testas la sistemon, kiu trovas radikojn por la etimologia vortaro.
(function () {
    // Substantivoj.
    asertuEgalas(getroot("viro"), "vir");
    asertuEgalas(getroot("viron"), "vir");
    asertuEgalas(getroot("viroj"), "vir");
    asertuEgalas(getroot("virojn"), "vir");

    // Adjektivoj.
    asertuEgalas(getroot("laca"), "lac");
    asertuEgalas(getroot("lacan"), "lac");
    asertuEgalas(getroot("lacaj"), "lac");
    asertuEgalas(getroot("lacajn"), "lac");

    // Adverboj (kaj nevortoj).
    asertuEgalas(getroot("hejme"), "hejm");
    asertuEgalas(getroot("hejmen"), "hejm");
    asertuEgalas(getroot("hejmej"), "hejmej");
    asertuEgalas(getroot("hejmejn"), "hejmejn");

    // Participoj.
    asertuEgalas(getroot("ludanto"), "lud");
    asertuEgalas(getroot("ludanton"), "lud");
    asertuEgalas(getroot("ludantoj"), "lud");
    asertuEgalas(getroot("ludantojn"), "lud");
    asertuEgalas(getroot("ludinto"), "lud");
    asertuEgalas(getroot("ludinton"), "lud");
    asertuEgalas(getroot("ludintoj"), "lud");
    asertuEgalas(getroot("ludintojn"), "lud");
    asertuEgalas(getroot("ludonto"), "lud");
    asertuEgalas(getroot("ludonton"), "lud");
    asertuEgalas(getroot("ludontoj"), "lud");
    asertuEgalas(getroot("ludontojn"), "lud");

    // Neoficialaj participoj.
    asertuEgalas(getroot("ludunto"), "lud");
    asertuEgalas(getroot("ludunton"), "lud");
    asertuEgalas(getroot("luduntoj"), "lud");
    asertuEgalas(getroot("luduntojn"), "lud");

    // Participoj kvazaŭ adjektivoj.
    asertuEgalas(getroot("montranta"), "montr");
    asertuEgalas(getroot("montrinta"), "montr");
    asertuEgalas(getroot("montronta"), "montr");
    asertuEgalas(getroot("montrata"), "montr");
    asertuEgalas(getroot("montrita"), "montr");
    asertuEgalas(getroot("montrota"), "montr");

    // Participoj kvazaŭ adverboj.
    asertuEgalas(getroot("naĝante"), "naĝ");
    asertuEgalas(getroot("naĝinte"), "naĝ");
    asertuEgalas(getroot("naĝonte"), "naĝ");
    asertuEgalas(getroot("naĝate"), "naĝ");
    asertuEgalas(getroot("naĝite"), "naĝ");
    asertuEgalas(getroot("naĝote"), "naĝ");

    // Verboj.
    asertuEgalas(getroot("doni"), "don");
    asertuEgalas(getroot("donas"), "don");
    asertuEgalas(getroot("donis"), "don");
    asertuEgalas(getroot("donos"), "don");
    asertuEgalas(getroot("donus"), "don");
    asertuEgalas(getroot("donu"), "don");

    // Neĝustaj strangaĵoj.
    asertuEgalas(getroot("pluvantanto"), "pluvant");
    asertuEgalas(getroot("domususus"), "domusus");
})();

// Testas la etimologiojn.
(function () {
    asertuEgalas(find_etymology("parkere"), "Fre. par coeur");
    asertuEgalas(find_etymology("parkeri"), "Fre. par coeur");
    asertuEgalas(find_etymology("parkerigi"), "Fre. par coeur");
    asertuEgalas(find_etymology("parkeriganto"), "Fre. par coeur");
})();

// Testas anglajn serĉojn.
(function () {
    asertuKongruas(search_en("to be happy"), ["feliĉi"]);
    asertuKongruas(search_en("be happy"), ["feliĉi"]);

    asertuKongruas(search_en("swim"), ["naĝi"]);
    asertuKongruas(search_en("to swim"), ["naĝi"]);
    asertuKongruas(search_en("swimming"), ["naĝado"]);
})();

// Testas antaŭe rompitajn kazojn.
(function () {
    // Ne-ekzaktaj serĉrezultoj ne kaŝu ekzaktajn.
    asertuKongruas(search_en("proverb"), ["proverbo", "sentenco"]);
    asertuKongruas(search_en("bug"), ["cimo", "miso", "insekto"]);

    // Se unu termo estas ekzakta maĉo, la tuta rikordo estas ekzakta.
    asertuKongruas(search_cs("pro"), ["pro"]);
})();
