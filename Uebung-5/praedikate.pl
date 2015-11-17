:- dynamic nachfolger_peano/2.

nachfolger_peano(0,s(0)).
nachfolger_peano(s(X),s(Y)) :- nachfolger_peano(X,Y). 

:- dynamic vorgaenger_peano/2.

vorgaenger_peano(s(0),0) :- nachfolger_peano(0,s(0)).
vorgaenger_peano(s(X),s(Y)):- nachfolger_peano(s(Y),s(X)).