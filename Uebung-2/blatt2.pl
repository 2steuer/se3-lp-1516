% Blatt 2

% Aufgabe 1

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

% (e) P1 und P2 sind Stiefgeschwister.
