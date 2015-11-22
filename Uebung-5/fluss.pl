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

% ist_betroffen_von(Ort1,Ort2,Distanz)
% Ein Praedikat, das die wasserwirtschaftliche
% Abhaeangigkeit der Ortschaft Ort1 von einer Schadstoffeinleitung an einem Ort Ort2 beschreibt.
% Distanz ist die Entfernung zwischen Ort1 und Ort2 über den Wasserweg

ist_betroffen_von(Ort1,Ort2,X):-
               liegt_stromaufwaerts_von(_,Ort2,Ort1,X).

ist_betroffen_von(Ort1,Ort2,Z):-
               liegt_stromaufwaerts_von(_,OrtX,Ort1,X),
               ist_betroffen_von(OrtX,Ort2,Y), 
		Z is X+Y.


% Da sich in kurzer Zeit leider keine genauen Daten finden lassen, betrachten wir die hochgradig unrealistische Abstraktion, dass ein FLuss überall gleich schnell fließt.

liegt_stromaufwaerts_von_geschwindigkeit(A,B,C,D,E) :- A = moldau, E = 3, 
    liegt_stromaufwaerts_von(A,B,C,D).
liegt_stromaufwaerts_von_geschwindigkeit(A,B,C,D,E) :- A = elbe, E = 3, 
    liegt_stromaufwaerts_von(A,B,C,D).
liegt_stromaufwaerts_von_geschwindigkeit(A,B,C,D,E) :- A = saale, E = 2, 
    liegt_stromaufwaerts_von(A,B,C,D).
liegt_stromaufwaerts_von_geschwindigkeit(A,B,C,D,E) :- A = mulde, E = 4, 
    liegt_stromaufwaerts_von(A,B,C,D).
liegt_stromaufwaerts_von_geschwindigkeit(A,B,C,D,E) :- A = havel, E = 1, 
    liegt_stromaufwaerts_von(A,B,C,D).
liegt_stromaufwaerts_von_geschwindigkeit(A,B,C,D,E) :- A = spree, E = 1.8, 
    liegt_stromaufwaerts_von(A,B,C,D).
liegt_stromaufwaerts_von_geschwindigkeit(A,B,C,D,E) :- A = oder, E = 4, 
    liegt_stromaufwaerts_von(A,B,C,D).

% ist_betroffen_nach(Ort1,Ort2,Stunden)
% Ein Prädikat, das misst, nach wie vielen Stunden Ort1 betroffen ist.

ist_betroffen_nach(X,Y,Z) :-
		liegt_stromaufwaerts_von_geschwindigkeit(_,Y,X,A,B),
		Z is A/B.
ist_betroffen_nach(X,Y,Z) :-
		liegt_stromaufwaerts_von_geschwindigkeit(_,S,X,A,B),
               ist_betroffen_nach(S,Y,U), 
		T is A/B,
		Z is T+U.
