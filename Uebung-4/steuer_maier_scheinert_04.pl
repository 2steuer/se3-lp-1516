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
% Praedikate wurden in hauser.pl definiert.

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Aufgabe 3.1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Praedikate wurden in fluss.pl definiert.

% Terminierungssicher, da von einem Ort1 immer nur der unmittelbare Ort2 flussabwärts gezaehlt wird,
% und ggf. alle Orte, die von diesem Ort2 betroffen sind.(Transitivitaet)
% Da Fluesse bekanntlich nicht im Kreis verlaufen, terminiert unsere Loesung immer.

?- ist_betroffen_von(Betroffener_Ort,muendung_neisse).
Betroffener_Ort = eisenhuettenstadt ;
Betroffener_Ort = frankfurt_oder ;
Betroffener_Ort = schwedt ;
Betroffener_Ort = szczecin ;
Betroffener_Ort = swinoujscie ;
false.

?- ist_betroffen_von(Betroffener_Ort,berlin_mitte).
Betroffener_Ort = muendung_spree ;
Betroffener_Ort = wittenberge ;
Betroffener_Ort = schnackenburg ;
Betroffener_Ort = geesthacht ;
Betroffener_Ort = hamburg ;
Betroffener_Ort = muendung_elbe ;
Betroffener_Ort = muendung_havel ;
Betroffener_Ort = havelberg ;
Betroffener_Ort = rathenow ;
Betroffener_Ort = brandenburg ;
false.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Aufgabe 3.2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Praedikate wurden in fluss.pl definiert.

% Wir haben uns ueberlegt, dass rein theoretisch nur in jenen Ortschaften Trinkwasseralarm ausgeloest werden muss,
% die flussabwaerts von dem Chemiewerk Bitterfeld liegen.
% Ob dies in der Realitaet praktikabel und moralisch vertretbar ist, ist eine andere Frage.

% Als Liste:

?- stoerfall_chemiewerk_bitterfeld(Betroffene_Orte).
Betroffene_Orte = [rosslau, muendung_saale, magdeburg, tangermuende, muendung_havel, wittenberge, schnackenburg, geesthacht, hamburg|...].

% Alternativ als normale Aufzaehlung, um Korrektheit zu verdeutlichen:

?- ist_betroffen_von(Betroffener_Ort,bitterfeld).
Betroffener_Ort = rosslau ;
Betroffener_Ort = muendung_saale ;
Betroffener_Ort = magdeburg ;
Betroffener_Ort = tangermuende ;
Betroffener_Ort = muendung_havel ;
Betroffener_Ort = wittenberge ;
Betroffener_Ort = schnackenburg ;
Betroffener_Ort = geesthacht ;
Betroffener_Ort = hamburg ;
Betroffener_Ort = muendung_elbe ;
false.