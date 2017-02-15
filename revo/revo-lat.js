// @license magnet:?xt=urn:btih:cf05388f2679ee054f2beb29a391d25f4e673ac3&dn=gpl-2.0.txt GPL-v2
// De La Reta Vortaro
'use strict';
var revo_lat = [
["Amsterdamo","Amstelodamum"],
["Antverpeno","Antverpia"],
["Arnhemo","Arenacum","Arnhemiae"],
["Azio","Asia"],
["Aŭreliano","Aurelianus"],
["Belgio","Belgica"],
["Beogrado","Belgradum"],
["Berlino","Berolinum"],
["Bizanco","Byzantium"],
["Bizantio","Byzantium"],
["Bremeno","Brema"],
["Bruselo","Bruxella"],
["Bruĝo","Brugis Flandrorum"],
["Cefeo","Cepheus"],
["Cicerono","Marcus Tullius Cicero"],
["Danubo","Danuvius"],
["Eneado","Aeneis"],
["Eneo","Aeneas"],
["Erasmo","Desiderius Erasmus"],
["Flandrio","Flandria"],
["Florenco","Florentia"],
["Frankfurto","Francofurtum"],
["Frankfurto ĉe Majno","Francofurtum ad Moenum"],
["Frankfurto ĉe Odro","Francofurtum ad Viadrum"],
["Gento","Gandava"],
["Hago","Haga-Comitis"],
["Hamburgo","Hamburgum"],
["Horacio","Horatius","Quintus Horatius Flaccus"],
["Janseno","Jansenius"],
["Karolo la Granda","Carolus Magnus"],
["Kolonjo","Colonia","Colonia Agrippina"],
["Komenio","Comenius"],
["Kortrejko","Cortoriacum"],
["Laŭrenco","Laurentius"],
["Lieĝo","Leodium"],
["Londono","Londinium"],
["Loveno","Lovanium"],
["Majenco","Moguntiacum"],
["Majno","Moenus"],
["Malgrand-Azio","Asia minor"],
["Marcialo","Marcus Valerius Martialis"],
["Menceo","Mencius"],
["Meĥleno","Mechlinia"],
["Mozelo","Mosella"],
["Nilo","Nilus"],
["Nimego","Noviomagus"],
["Odro","Viadrus"],
["Olimpo","Olympus"],
["Onufrio","Onuphrius"],
["Ovidio","Ovidius","Publius Ovidius Naso"],
["Plinio","Plinius"],
["Plinio la Juna","Caius Plinius Caecilius Secundus"],
["Plinio la Maljuna","Caius Plinius Secundus"],
["Pompejo","Pompeii"],
["Regensburgo","Regina Castra"],
["Rejno","Rhenus"],
["Seneko, Seneko la Juna","Lucius Annaeus Seneca"],
["Silezio","Silesia"],
["Svisio","Helvetia"],
["Tiberio","Tiberius"],
["Tinĉjo","Tintinus"],
["Utreĥto","Trajectum ad Rhenam","Trajectum Batavorum"],
["Vergilio","Vergilius","Publius Vergilius Maro"],
["Vitruvio","Vitruvius Polio","Vitruvius Pollio"],
["Vizbadeno","Aquae Mattiacae"],
["apologo","apologus, i"],
["aŭgusto","Sextilis","Augustus mensis","Augustus"],
["bavarujo","Bavaria"],
["belgujo","Belgica"],
["bisturio","scalprum"],
["danka","gratus"],
["danki","gratias ago, ere"],
["demamigi","a matre depello, ere","a mamma disiungo, ere","ablacto, are"],
["denaro","denarius"],
["ekssklavo","libertus","libertinus"],
["fablo","fabula, ae"],
["fiolo","aguncula","fiala (pop.)","phiala (class.)"],
["flandrujo","Flandria"],
["florbutono","gemma, ae"],
["furioza","rabidus, a, um (rabies)"],
["furzi","pedo, ere","crepo, are"],
["galo","bilis"],
["heso","Hassus, i","Chattus, i"],
["hesujo","Hassia","terra Chattorum"],
["intervjuo","colloquium, ii percontatiuum","colloquium, ii interrogatiuum"],
["italujo","Italia"],
["juro","ius"],
["komuna","communis"],
["komune","communiter"],
["komuneco","communitas, atis"],
["komunismo","communismus, i"],
["komunisto","communista, ae"],
["kune","una cum"],
["kvin","quinque"],
["kvina","quintus"],
["libreto","libellus, i"],
["libro","liber, bri"],
["librotenejo","bibliotheca, ae"],
["lingvo","lingua, ae","sermo, onis"],
["mameto","papilla, ae"],
["mamo","mamma, ae"],
["mampinto","papilla, ae"],
["mamsuĉi","lacteo, ere","sugo, ere"],
["numenio","Numenius"],
["okulo","oculus"],
["orgojlo","fastus, us","ferocia, ae","superbia, ae"],
["paliumo","pallium"],
["pardoni","excuso, are","ignosco, ere"],
["pardono","uenia, ae"],
["rabio","rabies, em, e"],
["razi","rado, ere"],
["razilo","nouacula, ae"],
["saksa","Saxonicus"],
["saksujo","Saxonia"],
["sendanka","ingratus"],
["skalpelo","scalprum"],
["studĝardeno, eksperimentĝardeno","hortus botanicus"],
["svislando","Helvetia"],
["svisujo","Helvetia"],
["taŭro","taurus, i"],
["tedi","taedet, erealiquem alicuius rei"],
["tendaro","castra, orum"],
["tendo","tentorium, ii","tabernaculum, i"],
["torturi","excrucio, are"],
["torturo","tormentum, i","cruciatus, us","supplicium, ii"],
["trezorejo","aerarium, ii"],
["trezoro","thesaurus, i"],
["trinki","bibo, ere","poto, are"],
["triumfo","triumphus, i"],
["triviala","trivialis","vulgaris","plebeius"],
["trompa","dolosus","fallax"],
["trompi","decipio, ere","fallo, ere"],
["trono","solium, ii"],
["turingujo","Thuringia"],
["tute","omnino","penitus","prorsus"],
["uro","Bos urus"],
["vorto","verbum"],
["Ĝenovo","Genua"],
["ĝemistino","praefica"],
["ĵurnalisto","diurnarius"],
["ĵurnalo","acta, orum diurna"],
];
var revo_lat_lower = revo_lat.map(function(a) { return a.map(function(x) { return x.toLowerCase(); }) });
// @license-end
