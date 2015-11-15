% liegt_liegt_stromaufwaerts_von_von(Fluss,Ort1,Ort2,Distanz)
% ist wahr, wenn fuer zwei an einem Fluss liegende
% Ortschaften die natuerliche Fliessrichtung des Wassers von
% Ort1 zu Ort2 verlaeuft 
% Distanz ist die Entfernung zwischen diesen Orten in Kilometern

liegt_stromaufwaerts_von(moldau,praha,muendung_moldau,38).
liegt_stromaufwaerts_von(elbe,muendung_moldau,usti,70). 
liegt_stromaufwaerts_von(elbe,usti,dresden,93).
liegt_stromaufwaerts_von(elbe,dresden,meissen,26).
liegt_stromaufwaerts_von(elbe,meissen,torgau,73).
liegt_stromaufwaerts_von(elbe,torgau,rosslau,102).
liegt_stromaufwaerts_von(elbe,rosslau,muendung_saale,33).
liegt_stromaufwaerts_von(elbe,muendung_saale,magdeburg,35).
liegt_stromaufwaerts_von(elbe,magdeburg,tangermuende,63).
liegt_stromaufwaerts_von(elbe,tangermuende,muendung_havel,34).
liegt_stromaufwaerts_von(elbe,muendung_havel,wittenberge,31).
liegt_stromaufwaerts_von(elbe,wittenberge,schnackenburg,21).
liegt_stromaufwaerts_von(elbe,schnackenburg,geesthacht,111).
liegt_stromaufwaerts_von(elbe,geesthacht,hamburg,22).
liegt_stromaufwaerts_von(elbe,hamburg,muendung_elbe,125).
liegt_stromaufwaerts_von(saale,calbe,muendung_saale,20).
liegt_stromaufwaerts_von(saale,bernburg,calbe,16).
liegt_stromaufwaerts_von(saale,halle,bernburg,57).
liegt_stromaufwaerts_von(mulde,bitterfeld,rosslau,27).
liegt_stromaufwaerts_von(mulde,wurzen,bitterfeld,47).
liegt_stromaufwaerts_von(havel,havelberg,muendung_havel,3).
liegt_stromaufwaerts_von(havel,rathenow,havelberg,42).
liegt_stromaufwaerts_von(havel,brandenburg,rathenow,47).
liegt_stromaufwaerts_von(havel,muendung_spree,brandenburg,55).
liegt_stromaufwaerts_von(spree,berlin_mitte,muendung_spree,14).
liegt_stromaufwaerts_von(oder,muendung_neisse,eisenhuettenstadt,11).
liegt_stromaufwaerts_von(oder,eisenhuettenstadt,frankfurt_oder,33).
liegt_stromaufwaerts_von(oder,frankfurt_oder,schwedt,111).
liegt_stromaufwaerts_von(oder,schwedt,szczecin,42).
liegt_stromaufwaerts_von(oder,szczecin,swinoujscie,61).

% ist_betroffen_von(Ort1,Ort2)
% Ein Praedikat, das die wasserwirtschaftliche
% Abhaeangigkeit der Ortschaft Ort1 von einer Schadstoffeinleitung an einem Ort Ort2 beschreibt.

:- dynamic ist_betroffen_von/2.

ist_betroffen_von(Ort1,Ort2):-
                    liegt_stromaufwaerts_von(_,Ort2,Ort1,_).

ist_betroffen_von(Ort1,Ort2):-
                    liegt_stromaufwaerts_von(_,OrtX,Ort1,_),
                    ist_betroffen_von(OrtX,Ort2).

% Praedikat fuer Aufgabe 3.2
:- dynamic stoerfall_chemiewerk_bitterfeld/2.

stoerfall_chemiewerk_bitterfeld(Liste):-
                               findall(BetroffenerOrt,ist_betroffen_von(BetroffenerOrt,bitterfeld),Liste).

 %% Aufgabe 3.3
 :- dynamic ist_erreichbar_von/2.

 ist_erreichbar_von(Ort1, Ort2) :-
 					liegt_stromaufwaerts_von(_,Ort1,Ort2,_).

ist_erreichbar_von(Ort1, Ort2) :-
 					ist_erreichbar_von(Ort2, Ort1).

 ist_erreichbar_von(Ort1, Ort2) :-
 					liegt_stromaufwaerts_von(_,Ort1,OrtX,_),
 					ist_erreichbar_von(OrtX, Ort2).


                        







