:- dynamic kunde/5.

% kunde(Kundennummer, Vorname, Nachname, GesamtBuchungenAnzahl, LetzteBuchung).
kunde(1,hans,werner,2,titanic).
kunde(2,peter,henning,2,tarzan).
kunde(3,lukas,tramm,1,der-zweite-weltkrieg).
kunde(4,udo,stark,3,flight).
kunde(5,hannes,rabicht,1,men-in-black).

:- dynamic film/3.

% film(Filmnummer, Erscheinungsdatum, Titel).
film(1,2015,men-in-black).
film(2,2000,titanic).
film(3,1990,der-zweite-weltkrieg).
film(4,1950,flight).
film(5,1975,tarzan).

:- dynamic verliehen/4.

% verliehen(Kundennummer, Filmnummer, Titel, Datum).
% Datumsangaben haben die Struktur JJJJMMDD
verliehen(1,3,der-zweite-weltkrieg,19800707).
verliehen(1,2,titanic,20151020).
verliehen(2,5,tarzan,20151031).
verliehen(2,1,men-in-black,20151028).
verliehen(3,3,der-zweite-weltkrieg,19900808).
verliehen(4,4,flight,20141010).
verliehen(4,5,tarzan,20121010).
verliehen(4,3,der-zweite-weltkrieg,19851010).
verliehen(5,1,men-in-black,20151031).

