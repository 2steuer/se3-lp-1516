% Blatt 4

% Merlin Steuer (6415125)
% Dominik Scheinert (6680325)
% Colin Maier (6701950)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Aufgabe 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
...

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Aufgabe 2.1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Praedikat wurde in hauser.pl definiert.

% Gibt wahr zurueck, wenn der Besitzer die Immobilie nach dem 31.12.2007 gekauft, und nicht mehr verkauft hat.

?- neueeigentuemer(schneider,bahnhofsstr,29).
false.

?- neueeigentuemer(meier,gaertnerstr,15).
true.

?- assert((bew(5,1,meier,juergen,300000,20151111))).
true.

?- neueeigentuemer(meier,gaertnerstr,15).
false.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Aufgabe 2.2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Praedikate wurden in hauser.pl definiert.

% a) Direkte Ausgabe aller Vorbesitzer eines Besitzers.

% Alle Vorbesitzer von mueller bezueglich Immobilie 3.
?- vorbesitzerAll(3,mueller,Vorbesitzer).
Vorbesitzer = [schulze, schneider].

% Alle Personen, die jemals Vorbesitzer einer Immobilie waren.
?- vorbesitzerAll(_,_,Vorbesitzer).
Vorbesitzer = [mueller, schulze, schneider, bund].

% b) Gibt fuer einen Besitzer immer nur einen Vorbesitzer pro Suchanfrage.

?- vorbesitzerSingle(3,mueller,Vorbesitzer).
Vorbesitzer = schneider ;
Vorbesitzer = schulze ;
false.
