// @license magnet:?xt=urn:btih:cf05388f2679ee054f2beb29a391d25f4e673ac3&dn=gpl-2.0.txt GPL-v2
// De La Reta Vortaro
'use strict';
var revo_th = [
["Bankoko, Bangkoko","กรุงเทพมหานคร","บางกอก"],
["aboni","สมัคร (นิตยสาร, บริการ)"],
["abrupta","ฉับพลัน (ไม่ได้ตั้งตัว)"],
["alilando","ต่างประเทศ"],
["alilandulo","คนต่างประเทศ","คนต่างชาติ"],
["argilo","ดินเหนียว"],
["avantaĝo","ผลประโยชน์","ความได้เปรียบ"],
["aĝo","อายุ"],
["aŭguro","ลางบอกเหตุ"],
["bonvoli","กรุณา","โปรด","ได้โปรด"],
["deklivo","ลาด","เอียง"],
["derivi","กลายมาจาก"],
["difekti","ทำให้ไม่ดี","ทำให้เสียหาย"],
["eksterlanda","นอกประเทศ"],
["eksterlandano","คนต่างประเทศ"],
["eksterlando","ต่างประเทศ"],
["evolulando, evoluanta lando","ประเทศที่กำลังพัฒนา","ประเทศโลกที่สาม"],
["flosi","ลอย (อยู่บนน้ำ)"],
["granato","ทับทิม (ผลไม้)"],
["grundo","ดิน"],
["homo","คน","มนุษย์"],
["industrilando, industria lando","ประเทศพัฒนาแล้ว"],
["iniciati","ริเริ่ม"],
["iniciatinto","ผู้ริเริ่ม"],
["kondukpermesilo, stirpermesilo","ใบอนุญาตขับขี่"],
["konsideri","พิจารณา","ไตร่ตรอง"],
["konsonanto","พยัญชนะ"],
["landano","ประชากร (ของประเทศ)"],
["landestro","ผู้นำประเทศ"],
["landnomo, landnomado","ชื่อประเทศ"],
["lando","ประเทศ","ดินแดน"],
["laŭvole","ตามที่ต้องการ"],
["minaci","ข่มขู่","ขู่"],
["minuto","นาที"],
["palmo","ปาล์ม","ต้นปาล์ม"],
["palmofesto, palmodimanĉo","วันอาทิตย์ใบลาน","วันอาทิตย์ทางตาล"],
["permesi","อนุญาติ"],
["permesilo","ใบอนุญาต"],
["pioniri","บุกเบิก"],
["pioniro","ผู้บุกเบิก"],
["prelegi","บรรยาย"],
["prelego","การบรรยาย"],
["procesio","การแห่สิ่งศักสิทธิ์"],
["rekompenci","มอบรางวัล","ให้รางวัล"],
["rekompenco","รางวัล"],
["samlandano","คนประเทศเดียวกัน"],
["sankcio","การอนุมัติ","การอนุญาต"],
["simpozio","การประชุมทางวิชาการ"],
["spontanea","ซึ่งเป็นไปตามธรรมชาติ","เกิดขึ้นเอง"],
["sterni","กระจาย","ปูผ้า"],
["tajlando","ประเทศไทย","เมืองไทย"],
["tordi","บิด"],
["torento","น้ำที่ไหลแรง"],
["uzurpi","ช่วงชิง"],
["voli","ต้องการ"],
["volo","ความต้องการ","สิ่งที่ต้องการ"],
["ĵaluzi","หึง"],
["ĵaluzo","ความหึง"],
["ŝvebi","ลอย (อยู่บนอากาศ)"],
];
var revo_th_lower = revo_th.map(function(a) { return a.map(function(x) { return x.toLowerCase(); }) });
// @license-end