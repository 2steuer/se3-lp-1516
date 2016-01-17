%%%%%%%%%%%%%%%%%%%
% Aufgabe 1
%%%%%%%%%%%%%%%%%%%
% vogel(?Vogel, ?fliegen)
% Gibt für den gegebenen Vogel an, ob dieser fliegen kann.
% Es ist möglich die Voegel abzufragen, die nicht fliegen koennen.
% Jedoch nicht solche, die fliegen koennen.

vogel(pinguin, kann_nicht_fliegen).
vogel(strauss, kann_nicht_fliegen).
vogel(X, kann_fliegen) :- \+ vogel(X, kann_nicht_fliegen).

%%%%%%%%%%%%%%%%%%
% Aufgabe 2
%%%%%%%%%%%%%%%%%%
merkmale(steinpilz, [gruen, blau, gelb, lamellen]).
merkmale(object2, [blau, gelb, rosa, punkte]).

hat_merkmal(Objekt, Merkmal) :- merkmale(Objekt, Liste), member(Merkmal, Liste).

hat_merkmale(Objekt, [Merkmal|Merkmale]) :- hat_merkmal(Objekt, Merkmal), hat_merkmale(Objekt, Merkmale).
hat_merkmale(_, []). 