// Skripto por la testado de la vortaro. Ĝi estas uzebla per moderna JS-konko.
'use strict';

load('espdic/espdic.js');
load('etymology/etymology.js');
load('vortaro.js');

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
    var trovitaj = listo.map(function (x) { return espdic[x][0]; });

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

asertuKongruas(search("swim"), ["naĝi"]);
asertuKongruas(search("to swim"), ["naĝi"]);
asertuKongruas(search("swimming"), ["naĝado"]);

print("hi");
