// @license magnet:?xt=urn:btih:cf05388f2679ee054f2beb29a391d25f4e673ac3&dn=gpl-2.0.txt GPL-v2
// De La Reta Vortaro
'use strict';
var revo_fi = [
["-uj","astia (sananjohdin)","säilytyspaikka (sananjohdin)","-puu (hedelmä-)","-pensas (marja-)","maa (maan tai alueen nimen johdin)","-kunta (hallintoalueen nimen johdin)"],
["-ul","olio (sananjohdin), yleensä ihminen tai eläin jolla on kantasanan ilmoittama ominaisuus"],
["Argentino","Argentiina"],
["Belgio","Belgia"],
["Brazilo","Brasilia"],
["Bruselo","Bryssel"],
["Dejmo","Deimos"],
["Flandrio","Flanderi"],
["Francio","Ranska"],
["Gaŭsa","Gaussin"],
["Gaŭso","Gauss"],
["Germanio","Saksa"],
["Granda ursino","Otava","Iso Karhu"],
["Holando","Hollanti"],
["Kabalisto","kabbalisti"],
["Kabalo","kabbala","(kuv.) salaoppi"],
["Kabe","Kabe"],
["Kabei","tehdä kuin Kabe"],
["Kieva Regno","Kiovan Rus","Kiovan Venäjä"],
["Kievano","kiovalainen (subst.)"],
["Kievo","Kiova"],
["Luksemburgio","Luxemburg"],
["Luksemburgo","Luxemburg"],
["Malgranda ursino","Pieni Karhu","Pikku Otava"],
["Svedio","Ruotsi"],
["Unikodo","Unicode"],
["Unikso","Unix"],
["Uniksulo","Unix-käyttäjä","Unix-fani"],
["Urala","Uralin","uralilainen (adj.)"],
["Urala lingvo","uralilainen kieli"],
["Urala-altaja lingvofamilio","uralilais-altailainen kielikunta"],
["Uralano","uralilainen (subst.)"],
["Uralo","Ural"],
["Urano","Uranos","Uranus"],
["Urugvajo","Uruguay"],
["Usona","yhdysvaltalainen (adj.)","Yhdysvaltojen","USA:n"],
["Usonano","yhdysvaltalainen (subst.)","amerikkalainen (Yhdysvaltain kansalainen)"],
["Usono","Yhdysvallat","USA"],
["Utreĥto","Utrecht"],
["Valonio","Vallonia"],
["Vathoro","wattitunti"],
["Vato","Watt","watti"],
["abako","abakus","helmitaulu","nomogrammi","laskutaulukko"],
["abandoni","suorittaa abandoni","luopua (vakuutuksen kohteesta)"],
["abandono","abandoni"],
["afera","asia-"],
["afereca","asiallinen"],
["aferema","toimelias","puuhakas"],
["aferisto","liikemies","liikenainen"],
["afero","asia","kysymys","(voi tarkoittaa jotain konkreettistakin, jää usein kääntämättä erillisellä sanalla)"],
["ajn","(vahvistussana iu-, ĉiu- ja kiu-sarjan sanojen kanssa) [kuka, mikä] tahansa","hyvänsä","vain","vaikka [kuka, mikä]"],
["ajna","mikä vain","millainen tahansa","mielivaltainen","satunnainen"],
["akaĵunukso","cashewpähkinä"],
["akaĵuo","acajouomena"],
["alia","toinen","muu"],
["alie","toisin","toisella tapaa","muuten","muulla tavalla","(tai) muuten","muussa tapauksessa"],
["aliflanke","toisella puolen","toisaalta"],
["aliigi","muuttaa (toiseksi, toisenlaiseksi) "],
["aliiĝi","muuttua (toiseksi, toisenlaiseksi) "],
["alio","(jotakin) muuta","muu (asia)"],
["almenaŭ","ainakin","ainakaan [en nea frazo]","joka tapauksessa"],
["alta","korkea (sävel)","korkea","pitkä (ihminen, puu)","korkea(lla oleva)","ylä-","suuri"],
["altaĵo","korkea paikka","kukkula","mäki"],
["alteco","korkeus (ominaisuus)","pituus (ominaisuus)"],
["altigi","korottaa","nostaa","ylentää"],
["alto","korkeus","pituus (pystysuunnassa)"],
["amafero","rakkausjuttu","suhde"],
["ambaŭ","molemmat","kumpikin"],
["ankaŭ","myös","-kin","[en nea kunteksto:] myöskään","-kaan","-kään"],
["ankoraŭ","vielä","yhä","edelleen","vieläkin","lisäksi"],
["antaŭforigi","poistaa ennakolta","ehkäistä"],
["antaŭhieraŭ","toissa päivänä"],
["apenaŭ","heti kun","tuskin ... kun jo"],
["azota","typpi-"],
["azotacido","typpihappo"],
["azoto","typpi"],
["aŭ","tai","(toistettuna: aŭ ... aŭ ) joko ... tai","[en demandoj neprigantaj elekton] vai","[t.e., alivorte] eli"],
["aŭtismo","autismi"],
["baldaŭ","pian","kohta"],
["belgujo","Belgia"],
["defora","kaukaa tapahtuva","etä-","kauko-"],
["dek","kymmenen"],
["deka","kymmenes"],
["deke","kymmenenneksi"],
["deksesuma","16-kantainen","heksadesimaali-"],
["dekuma","kymmenkantainen"],
["disidento","toisinajattelija"],
["do","siis"],
["du","kaksi"],
["dua","toinen"],
["due","toiseksi"],
["duobla","kaksinkertainen"],
["duoniganto","puolittaja"],
["duono","puoli","puolikas"],
["duuma","binaari-","binaarinen","kaksikantainen"],
["ekliptiko","ekliptika"],
["elektrokemio","sähkökemia"],
["elektroĥemia","sähkökemiallinen"],
["elektroĥemio","sähkökemia"],
["eluzi","käyttää loppuun","kuluttaa (tehdä kuluneeksi)"],
["eluzitaĵo","risa","rämä","vanha roju"],
["enkadrigi","kehystää","ympäröidä"],
["enmemiĝi","uppoutua","syventyä"],
["enujigi","panna astiaan (laatikkoon, kansioon...)"],
["escepte se","paitsi jos"],
["eĉ","jopa","vieläpä","-kin","(en nea frazo) edes","-kaan, -kään"],
["flandrujo","Flanderi"],
["for","pois","poissa","kaukana","etäällä","kauas"],
["fora","kaukainen","etäinen","etä-"],
["foraĵo","kaukaisuus","etäinen paikka"],
["fore","kaukana"],
["foren","kauas","pitkälle"],
["forigi","poistaa","ottaa pois"],
["foriĝi","poistua","hävitä"],
["foruzi","käyttää loppuun"],
["francujo","Ranska"],
["fruktuzo","käyttöoikeus","nautinta"],
["fuŝuzi","käyttää taitamattomasti","pilata"],
["germanujo","Saksa"],
["grenskarabo","jyväkärsäkäs","(Sitophilus-suvun) kärsäkäs"],
["ha","haa","oho","voi"],
["hieraŭ","eilen"],
["hieraŭa","eilinen"],
["hieraŭo","eilinen (subst.)","eilispäivä","edellinen päivä"],
["ho","voi","oi","hei","hoi"],
["hodiaŭ","tänään"],
["hodiaŭa","tämänpäiväinen"],
["hostimontrilo","monstranssi"],
["hostio","ehtoollisleipä","öylätti"],
["hostiujo","öylättirasia","ciborium"],
["ikso","x","äksä"],
["ili","he","ne"],
["ilia","heidän ... -nsa, -nsä","niiden"],
["imaginara unuo","imaginaariyksikkö"],
["imunoĥemio","immunokemia"],
["inter si","keskenään"],
["interalie","muun muassa"],
["ja","kyllä (vahvistussana)","-han, -hän","toki","tosin"],
["jam","jo","(kieltosanan seuratessa) enää"],
["jarduono","vuosipuolisko","puoli vuotta"],
["jarkvarono","vuosineljännes"],
["jarmilo","vuosituhat"],
["jen","tässä","kas","kas tässä"],
["jen vi havas","siinä sitä nyt ollaan!"],
["jen...","milloin ... milloin","vuoroin ... vuoroin"],
["jena","tämä tässä","seuraava(ksi esitettävä)"],
["jene","näin","seuraavasti"],
["jeno","tämä (asia)","seuraava (asia)"],
["jes","kyllä (myöntävänä vastauksena)"],
["jesa","myöntävä","myönteinen"],
["jesi","vastata myöntävästi"],
["jesigi","vahvistaa"],
["jeso","myöntävä vastaus","suostumus"],
["jogo","jooga"],
["kabano","maja"],
["kabareto","kabaree"],
["kabineto","työhuone","(tutkijan)kammio","kokoelma(huone)","kabinetti (esim. vaha-)","hallitus","ministeristö","kabinetti","kabinetti (avustajisto)"],
["kabinetulo","kamarioppinut","poliittinen avustaja"],
["kablero","johdin (kaapelin osana)"],
["kablo","köysi","vaijeri","kaapeli","kaapelinmitta"],
["kabo","niemi"],
["kabuko","kabuki(-teatteri)"],
["kaco","(miehen) kalu","kulli"],
["kadavro","(kuollut) ruumis","raato"],
["kadenco","tempo","tahti (vauhti)","kadenssi","lopuke"],
["kadeto","kadetti"],
["kadio","kadi"],
["kadmio","kadmium"],
["kadrato","suluke"],
["kadre de, enkadre de","(jonkin) puitteissa (t. ”puitteissa”)"],
["kadri","kehystää","ympäröidä"],
["kadro","kehys","kehykset","raami(t)","puitteet","ympäristö","tausta","puitteet (kuv.)","olosuhteet"],
["kaduceo","Merkuriuksen sauva","caduceus"],
["kaduka","ränsistynyt","huonokuntoinen","kuihtuva","häviävä","mitätön","raihnainen","vanhentunut","pätemättömäksi käynyt"],
["kadukaĵo","vika","rikkinäinen osa","rappeuma"],
["kadukeco","rappio","raihnaus"],
["kadukiĝi","ränsistyä","raihnaantua","rapistua"],
["kadukulo","raihnas vanhus"],
["kafarbo","kahvipensas"],
["kafeino","kofeiini"],
["kafejo","kahvila"],
["kafo","kahvi"],
["kafskatolo","kahvitölkki"],
["kaftano","kauhtana","kaftaani"],
["kafujo","kahvipensas"],
["kahela","laatta-","laatoitettu","kaakeli-"],
["kahelaro","laatoitus (laatoitettu pinta) "],
["kaheli","laatoittaa"],
["kahelo","(keramiikka)laatta","kaakeli"],
["kaj","ja","sekä"],
["kaj-signo","et-merkki"],
["kajaki","kulkea kajakilla"],
["kajako","kajakki"],
["kajero","vihko"],
["kajo","ja-operaattori","(looginen) konjunktio"],
["kajto","leija"],
["kajuto","hytti","kajuutta"],
["kakaarbo, kakaoarbo","kaakaopuu"],
["kakao","kaakaopapu","kaakao"],
["kakatuo","kakadu"],
["kakaujo","kaakaopuu"],
["kakemono","kakemono (maalauskäärö)"],
["kakofonio","kakofonia","epäsointuisuus"],
["kakto","kaktus"],
["kalabaso","kalebassi"],
["kalambako","agarpuu","aquilaria-puu"],
["kalandrao","jyväkärsäkäs","(Sitophilus-suvun) kärsäkäs"],
["kalandri","mankeloida","kalanteroida (paperon en fabriko)"],
["kalandrilo","mankeli","kalanteri (en paperfabriko)"],
["kalandro","jyväkärsäkäs","(Sitophilus-suvun) kärsäkäs","mankelointi","arokiuru"],
["kalcini","kalsinoida","hehkuttaa (tekn.)"],
["kalcio","kalsium"],
["kalcito","kalsiitti","kalkkisälpä"],
["kalcitri","potkia (takajaloillaan)","panna vastaan","rimpuilla"],
["kaldronego","(höyrykoneen) kattila"],
["kaldrono","pata","(iso) kattila","kattilalaakso"],
["kalejdoskopi","vaihdella (kuin kaleidoskoopissa)"],
["kalejdoskopo","kaleidoskooppi"],
["kalendara","ajanlasku-","kalenterin"],
["kalendaro","ajanlasku","kalenteri","almanakka"],
["kalendo","kalendae","calendae"],
["kalifo","kalifi"],
["kalifujo","kalifaatti","kalifikunta"],
["kapjesi","nyökätä (myöntävästi)"],
["kapnei","pudistaa päätään"],
["kaĉaloto","kaskelotti"],
["kaĉo","puuro","sose","sekasotku","soppa (kuv.)","vyyhti (kuv.)","sotku"],
["kaĝo","häkki"],
["kaĵola","hellyttävä","mairea"],
["kaĵoli","mairitella (suostumaan)","suostutella (hellästi)","mielistellä"],
["ke","että"],
["kemio","kemia"],
["kinino","kiniini"],
["kirurgia","kirurginen"],
["kirurgiisto","kirurgi"],
["kirurgio","kirurgia"],
["kirurgo","kirurgi"],
["kolesterolo","kolesteroli"],
["kometo","pyrstötähti","komeetta"],
["koncertkafejo","musiikkikahvila"],
["kumino","roomankumina","juustokumina"],
["kunalie","muun mukana","muiden (tavaroiden) mukana"],
["kuseno","tyyny"],
["kusentego, kusentegilo","tyynyliina"],
["kvadrigo","quadriga","(antiikin) nelivaljakko"],
["kvankam","vaikka"],
["kvar","neljä"],
["kvara","neljäs"],
["kvarangula","nelikulmainen"],
["kvare","neljänneksi"],
["kvaronjara","neljännesvuosi-","neljännesvuosittainen"],
["kvaronjaro","neljännesvuosi"],
["kvarono","neljännes","neljäsosa"],
["kvazaŭ","ikään kuin","kuin (+konditionaali)","kuin","kuin olisi"],
["kvazaŭa","jonkinlainen","muka"],
["kvazaŭe","jollakin tavalla","jos niin voi sanoa"],
["kvin","viisi"],
["kvina","viides"],
["kvine","viidenneksi"],
["kvinono","viidennes","viidesosa"],
["la","(määräinen artikkeli)"],
["ladurbo","hökkelikaupunki"],
["li","hän","hän (miespuolinen)","tuo mies","tuo poika"],
["lia","hänen ... -nsa, -nsä"],
["lunkalendaro, luna kalendaro","kuukalenteri"],
["malalta","matala (ei korkea)","alhainen","ala-"],
["malaltigi","alentaa","laskea","madaltaa"],
["maljesi","vastata kieltävästi","ei suostua"],
["malkajo","NAND-operaatio","Shefferin viiva"],
["malplej","vähiten"],
["malpliigi","vähentää","supistaa"],
["malpliiĝi","vähetä"],
["maltroigo","vähättely","understatement"],
["malutili","tehdä haittaa","haitata"],
["malutilo","haitta","vahinko"],
["mem","itse","omin avuin"],
["mem-","itse-"],
["mema","ominainen","luonteenomainen"],
["memeco","ominaislaatu","yksilöllisyys"],
["memo","minä (subst.)","olemus","identiteetti"],
["mezurunuo","mittayksikkö"],
["mi","minä"],
["mia","minun ... -ni","-ni"],
["mil","tuhat"],
["mirmekobo","pussimuurahaiskarhu","numbatti"],
["misuzi","käyttää väärin"],
["modkanto, furorkanto","hitti"],
["mona subunuo","rahan alayksikkö"],
["monunuo","rahayksikkö"],
["morgaŭ","huomenna"],
["morgaŭa","huominen (adj.)","huomis-"],
["morgaŭo","huominen (subst.)","huomispäivä","seuraava päivä"],
["naŭ","yhdeksän"],
["naŭa","yhdeksäs"],
["naŭe","yhdeksänneksi"],
["ne","ei (en, et,...)"],
["nea","kieltävä","kielteinen","epäävä"],
["nei","sanoa ei","kieltää","kiistää"],
["neigi","kieltää","kiistää"],
["nek","eikä (enkä, etkä...)"],
["nek ...","ei ... eikä"],
["neo","kieltävä vastaus","kiistäminen"],
["neutila, senutila","hyödytön","joutava"],
["ni","me"],
["nia","meidän","meidän -mme","-mme"],
["nigra truo","musta aukko"],
["nikabo","niqab"],
["nomuskla","versaalialkuinen","isoalkukirjaiminen"],
["nu","no","-han, -hän"],
["nuna","nykyinen"],
["nuntempo","nykyaika"],
["nur","vain","ainoastaan","pelkästään","vasta"],
["nura","pelkkä","silkka","jo (pelkkä)"],
["ok","kahdeksan"],
["oka","kahdeksas"],
["oke","kahdeksanneksi"],
["okulario","okulaari"],
["okuma","kahdeksankantainen","oktaali-"],
["ol","kuin (erilaisuutta ilmaiseva)"],
["oni","(epämääräinen persoonapronomini) ihmiset","(käännetään suom. passiivilla tai 3. persoonalla ilman subjektia)"],
["paciencludo, paciencoludo","pasianssi"],
["per si mem","itsestään"],
["perihelio","periheli"],
["petrolĥemio","petrokemia"],
["plej","(superlatiivin merkki, enintä määrää ilmaiseva partikkeli)","eniten"],
["pleje","eniten","enimmäkseen"],
["pli","enemmän","(komparatiivin merkki, suurempaa määrää ilmaiseva partikkeli ) ","vähemmän","ei niin (paljon kuin)"],
["pli kaj, ĉiam pli","yhä enemmän"],
["pli ol unu","enemmän kuin yksi","usea"],
["plia","lisä-","muu","lisäksi tuleva"],
["plie","lisäksi","enemmän"],
["pliigi","lisätä","kasvattaa"],
["pliiĝi","lisääntyä","kasvaa","karttua"],
["plu","edelleen","yhä","vielä","(kun nea vorto:) enää"],
["plua","tuleva","vastainen","lisä-"],
["plue","edelleen","lisäksi","pidemmälle"],
["pluen","edelleen","kauemmas"],
["plui","jatkua (edelleen)"],
["pluigi","jatkaa","pidentää"],
["postmorgaŭ","ylihuomenna"],
["praeksplodo","Alkuräjähdys"],
["praknalo","Alkuräjähdys"],
["preskaŭ","melkein","lähes","miltei"],
["rostpano","paahtoleipä"],
["se","jos"],
["se eĉ, eĉ se","vaikka"],
["se kaj nur, se... kaj nur tiam","jos ja vain jos","silloin ja vain silloin, kun"],
["sed","mutta","vaan"],
["sen ajna, sen ia ajn","ilman ainoatakaan","ilman vähäistäkään"],
["sep","seitsemän"],
["sepa","seitsemäs"],
["sepe","seitsemänneksi"],
["ses","kuusi (lukusana)"],
["sesa","kuudes"],
["sesdekuma","kuusikymmenkantainen","seksagesimaali-"],
["sese","kuudenneksi"],
["si","(3. pers. refleksiivipronomini)itse(nsä)"],
["sia","-nsa, -nsä","oma(nsa)"],
["subunuo","alayksikkö","kerrannaisyksikkö (yksikön murto-osa)"],
["sunkalendaro, suna kalendaro","aurinkokalenteri"],
["superunuo","kerrannaisyksikkö (yksikön monikerta)"],
["svedujo","Ruotsi"],
["tamen","kuitenkin","kuitenkaan","silti"],
["transurania","transuraaninen"],
["transuranio","transuraani"],
["tre","hyvin","erittäin","sangen","kovasti","paljon","suuressa määrin"],
["tri","kolme"],
["tria","kolmas"],
["trie","kolmanneksi"],
["triono","kolmannes","kolmasosa"],
["triunuo","kolminaisuus"],
["tro","liian","liikaa"],
["troa","liika","ylenmääräinen"],
["troaĵo","liiallisuus"],
["troe","liikaa"],
["troigo","liioittelu"],
["tuj","heti","viipymättä","aivan (lähellä)"],
["tuja","pikainen","pika-","heti tapahtuva"],
["tujpreta","pika-","instant-"],
["ublieto","kellarityrmä"],
["udono","udon (-nuudeli)"],
["ugviso","idänsilkkikerttunen"],
["ujo","astia","säiliö","kotelo","kansio"],
["ukazo","asetus (Venäjällä tai NL:ssa)","ukaasi"],
["ukulelo","havaijinkitara","ukulele"],
["ulambano","ullambana","(buddhalainen) esi-isien juhla","obon-juhla (Japanissa)"],
["ulano","ulaani"],
["ulcero","haavauma"],
["ulekso","piikkiherne"],
["ulemo","ulema (islamin uskonoppinut)"],
["ulmacoj","jalavakasvit"],
["ulmo","jalava"],
["ulno","kyynärä","kyynärluu"],
["ultimato","uhkavaatimus"],
["ultramaro","ultramariini"],
["ultrasono","ultraääni"],
["ululi","ulvoa","ulista"],
["umbeliferoj","(vanh.) sarjakukkaiset"],
["umbelo","sarja (kukinto)"],
["umbilika ŝnuro","napanuora"],
["umbiliko","napa (anat.)","(siemenen) arpi"],
["umearbo","ume","ume-puu"],
["umeo","ume","japaninaprikoosi"],
["umlaŭto","umlaut","vokaalinmukaus"],
["unco","unssi"],
["ungo","kynsi"],
["ungvento","pasta (lääke)","salva"],
["uniano","uniaatti"],
["uniata","uniaatti-"],
["uniato","uniaatti"],
["uniformo","univormu"],
["unika","ainoa","uniikki","ainutlaatuinen"],
["unikorno","yksisarvinen (tarueläin) "],
["unio","liitto","unioni","unioni (kirkollinen)","unioituminen","unioni (tietorakenne C-kielessä) "],
["unisono","unisono","yksiääninen sointu t. esitys"],
["universa","universumin","kosminen"],
["universala","yleinen","yleis-","maailman","yleispätevä","universaali(nen)"],
["universitata areo, universitata parko","korkeakoulualue","kampus"],
["universitato","yliopisto"],
["universo","maailmankaikkeus","universumi"],
["unkario","Uncaria (kasvisuku, mm. gambiirikasvi ja perunkynsiliaani)"],
["unu","yksi","toinen","eräs"],
["unua","ensimmäinen","ensi (ensimmäinen)"],
["unuaaĵo, unuaĵo","uutinen (uutisvilja, -leipä tms.)"],
["unuaeco","ensimmäisen asema","etusija"],
["unuaulo","ensimmmäinen (ihminen)"],
["unue","ensin","ensiksi"],
["unueco","ykseys","yhtenäisyys"],
["unuhava","ykkösalkiollinen"],
["unuigi","yhdistää"],
["unuiĝi","yhtyä","yhdistyä"],
["ununura","yksi ainoa"],
["unuo","ykkönen","yksikkö","(mitta)yksikkö","ykkösalkio","neutraalialkio"],
["unupeca","yhtä kappaletta (oleva)","saumaton"],
["unuto","priimi"],
["upaniŝado","upanišad"],
["uragani","riehua","myrskytä","raivota"],
["uragano","hirmumyrsky"],
["uranio","uraani"],
["urbano","kaupunkilainen","Urbanus"],
["urbego","suurkaupunki"],
["urbestro","kaupunginjohtaja","pormestari"],
["urbeto","pikkukaupunki"],
["urbo","kaupunki","esikaupunki","lähiö"],
["uretero","virtsanjohdin"],
["uretro","virtsaputki"],
["ureuso","uraeus(käärme)"],
["urinado","virtsaaminen"],
["urini","virtsata"],
["urino","virtsa"],
["urinveziko","virtsarakko"],
["urno","uurna"],
["uro","alkuhärkä"],
["urodeloj","pyrstösammakot"],
["urogalo","metso"],
["ursedoj","karhut (nisäkäsheimo)"],
["urso","karhu"],
["urtikacoj","nokkoskasvit"],
["urtiko","nokkonen"],
["urĝa","kiireellinen","viipymättä tehtävä","jota ei voi lykätä"],
["urĝi","kiirehtiä","hoputtaa","patistaa","olla kiireellinen","vaatia nopeaa toimintaa"],
["usklo, uskleco","aakkoslaji (”kirjainkoko”: ABC abc)"],
["utero","kohtu"],
["utila","hyödyllinen","haitallinen","vahingollinen"],
["utili","olla hyödyksi","hyödyttää"],
["utiligi","käyttää hyödyksi","hyödyntää"],
["utilismo","utilitarismi","hyötymoraali"],
["utilo","hyöty","etu"],
["utopio","utopia"],
["uverturo","alkusoitto"],
["uvulo","kitakieleke"],
["uzado","käyttö"],
["uzanco","käytänne","menettelytapa"],
["uzaĵo","käyttöesine","tarve-esine","tarveaine"],
["uzbeko","Uzbek(-kaani)","uzbekki"],
["uzbekujo, uzbekio","Uzbekistan"],
["uzi","käyttää","käyttää ylettömästi","käyttää liikaa"],
["uzino","tehdas (suuri metalliteollisuuslaitos)"],
["uzo","käyttö"],
["uzukapi","saada omistusoikeus pitkäaikaisen nautinnan nojalla"],
["uzukapo","nauttimussaanto"],
["uzuro","koronkiskonta"],
["uzurpi","anastaa","kaapata"],
["uŝuisto","wushu-urheilija"],
["uŝuo","wushu","kungfu (kamppailulaji)"],
["valonujo","Vallonia"],
["vaporkaldrono","höyrykattila (tekn.)"],
["zloto","zloty"],
["Ĉilio","Chile"],
["ĉar","koska","sillä"],
["ĉefurbo","pääkaupunki"],
["ĉi","(tiu- ja ĉiu-sarjan sanojen merkitystä tarkentamassa) lähempänä oleva","(etuliitteenä muissa adjektiiveissa ja adverbeissa) tässä lähellä oleva","(runokielessä) tämä","(runok.) täällä"],
["ĉilo","maitiaisneste (ruoansulatus)","kyylus"],
["ĉimo","ruokasula"],
["ĉirkaŭurbo","ympäristökaupunki","lähikaupunki"],
["ĉu","(kysymyssana) -ko","-kö"],
["ĉu...","-ko ... vai","olipa ... tai sitten"],
["ĝi","se"],
["ĝia","sen"],
["ĝisnuna","tähänastinen"],
["Ĥamido","Haamin jälkeläinen","haamilainen (subst.)"],
["Ĥamo","Haam"],
["Ĥanuko","hanukka"],
["Ĥarkovo","Harkova"],
["Ĥeopso","Kheops"],
["Ĥeroneo","Khaironeia"],
["Ĥio","Khios","Hios"],
["ĥaldea","kaldealainen (adj.)","Kaldean"],
["ĥaldeo","kaldealainen (subst.)"],
["ĥalkogeno","kalkogeeni"],
["ĥalkolitiko","kuparikausi","kalkoliittinen kausi"],
["ĥameleona","kameleonttimainen"],
["ĥameleono","kameleontti","Kameleontti (tähdistö)"],
["ĥamemoro, kamemoro","muurain","hilla","lakka (kasvi, marja)"],
["ĥamsino","khamsin"],
["ĥano","kaani"],
["ĥanto","hanti"],
["ĥanujo","kaanikunta"],
["ĥaosa","sekasortoinen","kaoottinen","sotkuinen"],
["ĥaose","sekasortoisesti","kaoottisesti","sotkuisesti"],
["ĥaosigi","sotkea täysin","tehdä (jostakin) kaaos"],
["ĥaoso","kaaos (mytol.)","kaaos","sekasorto","epäjärjestys"],
["ĥaradriedoj","kurmitsat"],
["ĥaradrio","tylli"],
["ĥaradrioformaj","rantalinnut"],
["ĥasidismo","hasidismi"],
["ĥasido","hasidilainen"],
["ĥazaro","kasaari"],
["ĥazarujo","kasaarien valtakunta"],
["ĥelonio","liemikilpikonna"],
["ĥemia","kemiallinen"],
["ĥemiaĵo","kemikaali"],
["ĥemio","kemia"],
["ĥi","khii"],
["ĥilo","maitiaisneste (ruoansulatus)","kyylus"],
["ĥimero","Khimaira","tuulentupa","haave"],
["ĥimo","ruokasula"],
["ĥio","khii"],
["ĥitino","kitiini"],
["ĥolero","kolera"],
["ĥoralo","koraali"],
["ĥorano","kuorolainen"],
["ĥoraĵo","kuoroteos","kuorosävellys"],
["ĥordo","selkäjänne"],
["ĥorduloj","selkäjänteiset"],
["ĥorejo","kuoron paikka (kirkossa)"],
["ĥoreo","tanssitauti","chorea"],
["ĥorestro","kuoronjohtaja"],
["ĥoro","kuoro"],
["ĵus","(äsken) juuri","äsken","vastikään"],
["ĵusa","äskeinen","äskettäinen","tuore"],
["ŝi","hän (naispuolinen)","tuo nainen","tuo tyttö"],
["ŝia","hänen","hänen -nsa (-nsä)"],
["ŝirfolia kalendaro","(repäisy)päivyri"],
];
var revo_fi_lower = revo_fi.map(function(a) { return a.map(function(x) { return x.toLowerCase(); }) });
// @license-end
