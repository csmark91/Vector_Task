Alapadatok:
Fejlesztőkörnyezet: Delphi (VCL)
Adatbáziskezelő: Microsoft SQL Server
Adatkapcsolat: ADO (TADOConnection, TADOQuery)
Riportmotor: FastReport VCL

Adatbázis létrehozása és feltöltése:
Futtassa a mellékelt init_database.sql scriptet az SQL Serveren. Ezt követően létrejön az adatbázis, amely feltöltődik 5-5 darab kezdeti törzsadattal.

Az alkalmazás futtatása
A program külön telepítést nem igényel. Másolja a Vector.exe fájlt (a kimutatás készítéséhez szükséges FastReport.fr3 fájllal együtt) egy tetszőleges mappába a számítógépen, és futtassa a programot.

Program használata:
Bejelentkezés ablak: Indításkor megjelenő bejelentkezési ablakban meg kell adni:
•	Szerver nevét
•	Adatbázis nevét
•	Felhasználó nevét
•	Belépési jelszót

Bejelentkezés után az alábbi funkciók elérhetők:
•	Új tétel rögzítése
•	Tétel törlése
•	Tétel módosítása
•	Kimutatás készítése

Tételek rögzítése:
A bejelentkezést követően a következő módon lehet új tételeket rögzíteni.
1.	Partner kiválasztása a legördülő menüből:
Kiválasztást követően a rendszer automatikusan megjeleníti a partner teljes címét és a hozzárendelt egyedi kedvezmény mértékét (%).
2.	Termék kiválasztása a listából:
A termék kiválasztását követően a rendszer beajánlja a terméktörzsben rögzített adatokat.
3.	Engedmény: A program automatikusan beajánlja a kiválasztott partnerhez tartozó engedmény mértékét, azonban ez a mező módosítható. Amennyiben eseti jelleggel szükségessé válik a kedvezmény mértékének változtatása, ebben a mezőben meg tudjuk tenni. (A rendszer az adatok beírásakor automatikusan frissíti az engedménnyel csökkentett nettó egységárat, a tétel teljes nettó értékét, az ÁFA összegét, valamint a teljes bruttó értéket.)
4.	Mennyiség megadása: Adja meg az eladott mennyiséget.
5.	Megjegyzés mező: A rögzíteni kívánt tételhez megjegyzést írhatunk. Amennyiben a törzsadatokban van a kiválasztott partnerhez állandó megjegyzés rögzítve, az is ebben a mezőben jelenik meg.
6.	Hozzáadás: a gomb megnyomását követően a bevitt adatok bekerülnek az adatbázisba. (Hiányosan kitöltött adatok esetén hibaüzenettel figyelmeztet a program.)

Korábban rögzített tételek módosítása:
A korábban rögzített tételekre kattintva lehetőség van arra, hogy egy rögzítést módosítsunk. Ennek lépései a következők:
1.	Válassza ki a módosítani kívánt tételt a táblázatban, majd kattintson a „Módosítás” gombra. A program betölti a javítani kívánt tétel adatait a beviteli mezőkbe.
2.	A szükséges módosítások elvégzése után kattintson a „Mentés” gombra.

Korábban rögzített tételek törlése:
A kiválasztott tétel a Törlés gombra kattintva távolítható el. (A művelet megerősítést kér).

Kimutatás készítése
A Kimutatás gombra kattintva elkészíthető egy partnerenkénti forgalmi kimutatás.

A kimutatás szerkezete:
Ügyfél csoportok: Az adatok ügyfélnév szerint csoportosítva jelennek meg.
Tétel részletező: Tartalmazza az adott ügyfél által vásárolt termékek cikkszámát, megnevezését, egységárát, nettó forgalmi értékét.
Ügyfél részösszesen: Minden ügyfélblokk végén megjelenik az összesített nettó forgalom.
Mindösszesen: A jelentés legvégén az összes ügyfél összevont összforgalma.
A megnyíló előnézeti ablakból a kimutatás közvetlenül nyomtatható vagy menthető.
