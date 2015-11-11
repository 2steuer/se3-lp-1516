:- dynamic obj/5.

% obj(Objektnummer, Objekttyp, Strassenname, Hausnummer, Baujahr).
obj(1,efh,gaertnerstr,15,2005).
obj(2,efh,bahnhofsstr,27,1943).
obj(3,efh,bahnhofsstr,29,1997).
obj(4,mfh,bahnhofsstr,28,1989).
obj(5,bahnhof,bahnhofsstr,30,1901).
obj(6,kaufhaus,bahnhofsstr,26,1997).
obj(7,efh,gaertnerstr,17,1982).

:- dynamic bew/6.

% bew(Vorgangsnr, Objektnr, Verkaeufer, Kaeufer, Preis, Verkaufsdatum)
% Datumsangaben haben die Struktur JJJJMMTT 
bew(1,1,mueller,meier,250000,20120401).
bew(2,3,schulze,schneider,260000,19881213).
bew(3,3,schneider,mueller,315000,20011201).
bew(4,5,bund,piepenbrink,1500000,19980601).

% Aufgabe 2.1
:- dynamic neueeigentuemer/3.
% Gibt wahr zurueck, wenn der Eigentuemer die Immobilie nach dem 31.12.2007 erworben hat und immer noch Eigentuemer ist.
neueeigentuemer(Eigentuemer,Strasse,Hausnummer) :- 
                bew(_,HausID,_,Eigentuemer,_,Kaufdatum),
                obj(HausID,_,Strasse,Hausnummer,_),
                Kaufdatum > 20071231,
                not((bew(_,HausID,_,_,_,MoeglichesVerkaufDatum), MoeglichesVerkaufDatum > Kaufdatum)).

                

%hallo 2.2
:- dynamic vorbesitzerAll/3.
% Gibt fuer einen Besitzer alle Vorbesitzer zurueck.
vorbesitzerAll(ObjektID,Besitzer,Vorbesitzer):-
                findall(Verkaeufer,bew(_,ObjektID,Verkaeufer,Kaeufer,_,_),Vorbesitzer),
                Verkaeufer \== Vorbesitzer,
                Kaeufer \== Vorbesitzer.
                
:- dynamic vorbesitzerSingle/3.
% Gibt fuer einen Besitzer immer einen Vorbesitzer zurueck pro Suchanfrage.
vorbesitzerSingle(ObjektID,Besitzer,Vorbesitzer):-
                    Vorbesitzer \== Besitzer,
                    bew(_,ObjektID,Vorbesitzer,Besitzer,_,_).
                    
vorbesitzerSingle(ObjektID,Besitzer,Vorbesitzer):-
                    bew(_,ObjektID,Vorbesitzer1,Besitzer,_,_),
                    vorbesitzerSingle(ObjektID,Vorbesitzer1,Vorbesitzer).
                