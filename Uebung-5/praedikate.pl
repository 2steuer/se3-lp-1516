:- dynamic nachfolger_peano/2.
% Bestimmt den Nachfolger einer PEANO-Zahl.
% Struktur: nachfolger_peano(Zahl,Nachfolgerzahl)
nachfolger_peano(0,s(0)).
nachfolger_peano(s(X),s(Y)) :- nachfolger_peano(X,Y). 

:- dynamic vorgaenger_peano/2.
% Bestimmt den Vorgaenger einer PEANO-Zahl.
% Struktur: vorgaenger_peano(Zahl,Vorgaengerzahl)
vorgaenger_peano(s(0),0) :- nachfolger_peano(0,s(0)).
vorgaenger_peano(s(X),s(Y)):- nachfolger_peano(s(Y),s(X)).

:- dynamic subtrahiere/3.
% Realisiert die Subtraktion von PEANO-Zahlen.
% Struktur: subtrahiere(Minuend,Subtrahend,Differenz)
subtrahiere(X,0,X).
subtrahiere(s(X),s(X),0).
subtrahiere(X,s(Y),Z):- subtrahiere(X,Y,s(Z)).

:- dynamic verdoppelt/2.
% Prueft fuer zwei PEANO-Zahlen P1 und P2, ob P2 doppelt so gross ist wie P1.
% Struktur: verdoppelt(Zahl,Zahlverdoppelt)
verdoppelt(0,0).
verdoppelt(s(Zahl),s(s(Zahlverdoppelt))):- verdoppelt(Zahl,Zahlverdoppelt).

:- dynamic gte/2.
gte(0,0).
gte(s(X),0).
gte(s(X),s(Y)):- gte(X,Y).

:- dynamic modulo/3.
% Struktur: modulo(Dividend,Divisor,Modulo)
% Prueft, ob Dividend modulo Divisor = Modulo gilt.
% Wir nutzen dabei als Hilfspraedikat das gte-Praedikat.
modulo(s(0),s(0),0).
modulo(Dividend,Divisor,Modulo):- 
                    gte(Dividend,Divisor), 
                    subtrahiere(Dividend,Divisor,Differenz), 
                    modulo(Differenz,Divisor,Modulo).
modulo(Dividend,Divisor,Modulo):- 
                    not((gte(Dividend,Divisor))), 
                    Modulo = Dividend.

:- dynamic peanoToInt/2.
% Struktur: peanoToInt(Peano-Zahl,Integer-Zahl)
% Wandelt eine Peano-Zahl in eine Integer-Zahl um.
peanoToInt(0,0).
peanoToInt(s(X),Y):- Z is Y - 1, peanoToInt(X,Z).





