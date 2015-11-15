% Blatt 4

% Merlin Steuer (6415125)
% Dominik Scheinert (6680325)
% Colin Maier (6701950)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Aufgabe 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
A ist das Geburtsjahr von B: 
Diese Relation ist nicht symmetrisch, da A ein Jahr und B ein Mensch (Wesen, ...) ist, und zb. ein Jahr kein Geburtsjahr hat.
Diese Relation ist nicht reflexiv, da A ein Jahr und B ein Mensch (Wesen, ...) ist, und zb. ein Jahr kein Geburtsjahr hat.
Diese Relation ist transitiv, da sich bei einem Element (A,B) kein Element (B,C) finden wird, da B sonst Mensch und Jahr wäre.
Diese Relation ist funktional in B, da jeder Mensch ein eindeutiges Geburtsjahr hat.

A ist Nachbargrundstück von B:
Diese Relation ist symmetrisch, da wenn A neben B liegt auch B neben A liegt.
Diese Relation ist nicht reflexiv, da A nicht neben sich selbst liegt.
Diese Relation ist nicht transitiv, da zB für eine Anordung von Grundstücken A B C gilt: R(A,B) und R(B,C), aber nicht R(A,C).
Diese Relation ist nicht funktional, da ein Grundstück zwei Nachbarn haben kann, und R symmetrisch ist.

A ist leichter als B:
Diese Relation ist nicht symmetrisch, da wenn A leichter als B ist, B natürlich nicht leichter als A ist.
Diese Relation ist nicht reflexiv, da A genauso schwer, also nicht leichter als B ist.
Diese Relation ist transitiv, denn wenn A leichter als B und B leichter als C ist, ist A im Besonderen leichter als C.
Diese Relation ist nicht funktional, da es potentiell unendlich viele leichtere bzw. schwerere Elemente geben kann.

A ist kleiner oder gleich B:
Diese Relation ist nicht symmetrisch, wenn A echt kleiner als B ist, B natürlich nicht kleiner als A ist.
Diese Relation ist reflexiv, da A gleich A ist.
Diese Relation ist transitiv, denn wenn A kleiner als B und B kleiner als C ist, ist A im Besonderen kleiner als C.
Diese Relation ist nicht funktional, da es potentiell unendlich viele kleinere bzw. größere Elemente geben kann.
Bem: Dieses Relation ist zudem noch anti-symmetrisch und damit eine Ordnungsrelation.

A hat schon einmal in einer Mannschaft mit B gespielt:
Diese Relation ist symmetrisch, da wenn A mit B in einer Mannschaft gespielt hat, B natürlich auch mit A in einer Mannschaft gespielt hat.
Diese Relation ist nicht reflexiv, da man nicht mit sich selbst in einer Mannschaft spielen kann.
Diese Relation ist nicht transitiv, da wenn A und B zusammen in Mannschaft X gespielt haben, und B und C in Mannschaft Y, A und C nicht zwingend auch in einer gemeinsamen Mannschaft gespielt haben.
Diese Relation ist nicht funktional, da A mit endlich vielen, aber im Besonderen durchaus mit mehr als einem in einer Mannschaft gespielt hat, und die Relation symmetrisch ist.

A ist kongruent zu B:
Diese Relation ist symmetrisch, da wenn A zu B kongruent ist, B auch zu A kongruent ist.
Diese Relation ist reflexiv, da A zu sich selbst kongruent ist.
Diese Relation ist transitiv, da wenn A kongruent zu B ist, und B zu C, auch A zu C kongruent ist.
Diese Relation ist nicht funktional, da A zu potentiell unendlich vielen Elementen kongruent sein kann, und R symmetrisch ist.
Bem: Diese Relation ist eine Äquivalenzrelation.
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


% Kennt man den gesuchten Vorbesitzer und weiß, dass er nicht allzu weit in der Vergangenheit der Vorbesitzer war, bietet sich
% die zweite Variante an aufgrund weniger Rechenoperationen.
% Im anderen Fall ist immer Variante Eins vorzuziehen.
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

% ist_betroffen_von(A,B)
% Diese Relation ist nicht symmetrisch, da A zwar betroffen von B ist, aber B aufgrund der Fließrichtung nicht von A.
% Diese Relation ist nicht reflexiv, da A nicht von sich selbst betroffen sein kann.(Laut Funktion...In der echten Welt mag dies anders sein!)
% Diese Relation ist transitiv, da A von B betroffen sein kann, und B wiederum von C. So ist auch A von C betroffen.
% Diese Relation ist nicht funktional, da ein Ort A auch an der Mündung von zwei Flüssen liegen kann.

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Aufgabe 3.3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Auch dieses Prädikat ist in fluss.pl definiert.

?- ist_erreichbar_von(hamburg, praha). % über muendung_moldau
true ;
true ;
true ;
true ;
true ;
true ;
true ;
true ;
true ;
true ;
true ;
true ;
true ;
true ;
true ;
true ;
true ;
false.

% Offenbar scheint hier eine relativ tiefe Rekursionstiefe durchlaufen zu werden. (Der Weg ist ja auch lang.)
% frage man ist_erreichbar_von(praha, X)., so werden schier unendlich viele Werte für X ausgegeben, die sich alle doppeln. 
% Lösen könnte man dies, indem man eine Liste mit Orten hält, die jeweils schon ein mal bearbeitet wurden.

% Diese relation ist Symmetrisch (ist A von B aus erreichbar, ist auch B von A aus erreichbar), transitiv (Ist A von B aus erreichbar, und C von A aus,
% so ist auch C von B aus erreichbar) sowie reflexiv (von A kommt man immer nach A).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Aufgabe 3.4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Auch dieses Prädikat ist in fluss.pl definiert.

?- ist_erreichbar_von(hamburg, brandenburg). % über muendung_moldau
true .
