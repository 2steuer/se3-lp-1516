% Blatt 2

% Merlin Steuer (6415125)
% Dominik Scheinert (6680325)
% Colin Maier (6701950)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Aufgabe 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
?- [familie].

% (a) Die Enkelkinder von Opa, aber nur die von Opas Töchtern.
?- vater_von(Opa, Tochter), mutter_von(Tochter, Enkel).
% Opa = walter,
% Tochter = barbara,
% Enkel = klaus ;
% Opa = walter,
% Tochter = barbara,
% Enkel = andrea ;
% false.

% (b) Zwei verschiedene Kinder von X
?- vater_von(X, Kind1), vater_von(X, Kind2), Kind1\=Kind2.
% X = otto,
% Kind1 = hans,
% Kind2 = helga ;
% X = otto,
% Kind1 = helga,
% Kind2 = hans ;
% X = johannes,
% Kind1 = klaus,
% Kind2 = andrea ;
% X = johannes,
% Kind1 = andrea,
% Kind2 = klaus ;
% X = walter,
% Kind1 = barbara,
% Kind2 = magdalena ;
% X = walter,
% Kind1 = magdalena,
% Kind2 = barbara ;
% false.

% (c) P2 ist der Onkel von P1.
?- assertz(mutter_von(hildegard, marie)).
?- assertz(mutter_von(hildegard, franz)).
?- assertz(vater_von(franz, linus)).

?- mutter_von(X, NeffeNichte), mutter_von(Y, X), mutter_von(Y, Onkel), vater_von(Onkel, Z), Y\=Onkel.
% X = marie,
% NeffeNichte = hans,
% Y = hildegard,
% Onkel = franz,
% Z = linus ;
% NeffeNichte = helga,
% Y = hildegard,
% Onkel = franz,
% Z = linus ;
% false.

% (d) P2 ist der Schwager von P1.
?- mutter_von(X, Schwager1), mutter_von(X, Y), mutter_von(Y, Z), vater_von(Schwager2, Z), Y \= Schwager1.
% X = charlotte,
% Schwager1 = magdalena,
% Y = barbara,
% Z = klaus,
% Schwager2 = johannes ;
% X = charlotte,
% Schwager1 = magdalena,
% Y = barbara,
% Z = andrea,
% Schwager2 = johannes ;

% (e) P1 und P2 sind Stiefgeschwister von der selben Mutter aber zwei verschiedenen Vaetern.
?- assertz(mutter_von(marie, hugo)).
?- assertz(vater_von(walter,hugo)).

?- vater_von(X,Geschwister1), vater_von(Y,Geschwister2), mutter_von(Z, Geschwister1), mutter_von(Z, Geschwister2), Geschwister1 \= Geschwister2, X \= Y.
% X = otto,
% Geschwister1 = hans,
% Y = walter,
% Geschwister2 = hugo,
% Z = marie ;
% false.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Aufgabe 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

?- [haeuser].

% (1)
?- obj(ID, Typ, bahnhofsstr, Nr, Baujahr).
% ID = 2,
% Typ = efh,
% Nr = 27,
% Baujahr = 1943 ;
% ID = 3,
% Typ = efh,
% Nr = 29,
% Baujahr = 1997 ;
% ID = 4,
% Typ = mfh,
% Nr = 28,
% Baujahr = 1989 ;
% ID = 5,
% Typ = bahnhof,
% Nr = 30,
% Baujahr = 1901 ;
% ID = 6,
% Typ = kaufhaus,
% Nr = 26,
% Baujahr = 1997.

% (2)
?- obj(ID, Typ, Strasse, Nr, Baujahr), Baujahr < 1950.
% ID = 2,
% Typ = efh,
% Strasse = bahnhofsstr,
% Nr = 27,
% Baujahr = 1943 ;
% ID = 5,
% Typ = bahnhof,
% Strasse = bahnhofsstr,
% Nr = 30,
% Baujahr = 1901 ;
% false.

% (3)
?- obj(GID,_,_,_,_), bew(_,GID,_,Kaeufer,Preis,_), Preis > 300000.
% GID = 3,
% Kaeufer = mueller,
% Preis = 315000 ;
% GID = 5,
% Kaeufer = piepenbrink,
% Preis = 1500000 ;
% false.

% (4)
?- obj(ID,Typ,Strasse,Nr,Baujahr), bew(_,ID,_,_,AlterPreis,_), bew(_,ID,_,_,NeuerPreis,_), AlterPreis < NeuerPreis.
% ID = 3,
% Typ = efh,
% Strasse = bahnhofsstr,
% Nr = 29,
% Baujahr = 1997,
% AlterPreis = 260000,
% NeuerPreis = 315000 .

% (5)
?- obj(ID,Typ,Strasse,Nr,Baujahr), bew(_,ID,_,ErsterBesitzer,_,_), bew(_,ID,_,ZweiterBesitzer,_,_), ErsterBesitzer \== ZweiterBesitzer.
% ID = 3,
% Typ = efh,
% Strasse = bahnhofsstr,
% Nr = 29,
% Baujahr = 1997,
% ErsterBesitzer = schneider,
% ZweiterBesitzer = mueller .

% (6)
?- bew(_,ID,_,X,_,_), bew(_,ID2,_,X,_,_), ID \== ID2, X==X.
& false.

?- assert(bew(5,6,bund,schneider,250000,19700512)).
% true.

?- bew(_,ID,_,X,_,_), bew(_,ID2,_,X,_,_), ID \== ID2, X==X.
% ID = 3,
% X = schneider,
% ID2 = 6 .

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Aufgabe 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Datenbank siehe Email-Anhang.

?- [verleih].

?- film(_,Erscheinungsjahr,Titel), Erscheinungsjahr > 1975.
% Erscheinungsjahr = 2015,
% Titel = men-in-black ;
% Erscheinungsjahr = 2000,
% Titel = titanic ;
% Erscheinungsjahr = 1990,
% Titel = der-zweite-weltkrieg ;
% false.

?- verliehen(Kunde,_,der-zweite-weltkrieg,Datum), kunde(Kunde, Vorname, Nachname,_,_).
% Kunde = 1,
% Datum = 7071980,
% Vorname = hans,
% Nachname = werner ;
% Kunde = 3,
% Datum = 8081990,
% Vorname = lukas,
% Nachname = tramm ;
% Kunde = 4,
% Datum = 10101985,
% Vorname = udo,
% Nachname = stark ;
% false.

?- verliehen(Kunde,_,_,Datum), kunde(Kunde, Vorname, Nachname,_,_), Datum > 19991231, Datum  < 20142131.
% Kunde = 4,
% Datum = 20141010,
% Vorname = udo,
% Nachname = stark ;
% Kunde = 4,
% Datum = 20121010,
% Vorname = udo,
% Nachname = stark ;
% false.

?- film(_,_,Film).
% Film = men-in-black ;
% Film = titanic ;
% Film = der-zweite-weltkrieg ;
% Film = flight ;
% Film = tarzan.

?- kunde(_,Vorname,_,Gesamtbuchungen,LetzteBuchung), LetzteBuchung == tarzan , Gesamtbuchungen > 1.
% Vorname = peter,
% Gesamtbuchungen = 2,
% LetzteBuchung = tarzan ;
% false.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Aufgabe 4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Prädikat:
Durch Prädikate werden Fakten in einer Datenbasis beschrieben. Die Stelligkeit ihrer Argumente ist beliebig.
Dabei schafft das Prädikat zwischen seinen einzelnen atomaren Informationen eine Relation
und somit einen Fakt. 

Klausel:
Klauseln sind konkrete Ausprägungen von Prädikaten, bzw. strukturgleiche Klauseln können zu einem 
Prädikat "zusammengefasst" werden. Mit Klauseln werden Datenbanken erst befüllt und die Welt
der Datenbank aufgebaut.

Struktur:
Eine Struktur besteht aus einem Namen und mindestens einem Argument, wobei jedes Argument ein Term ist.
Das Konzept von Strukturen ist elementar für die Logikprogrammierung, da nur so die Datenbank mit ihren Informationen
geordnet werden kann, um unsere späteren Anfragen überhaupt realisieren zu können.



