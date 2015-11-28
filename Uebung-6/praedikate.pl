% odd(+NatZahl) // Aus dem Skript.
% NatZahl ist eine ungerade natuerliche Zahl
odd(X) :- X > 0, 1 is X mod 2.

:- dynamic mypi/2.
% Struktur: mypi(+Schritte, ?Resultat).
% Berechnung erfolgt beim rekursiven Aufstieg. Nicht endrekursiv.
mypi(Schritte,Resultat):- 
                leibnitzschereihenzerlegung(Schritte,BetaErgebnis),
                Resultat is 4 * BetaErgebnis.

leibnitzschereihenzerlegung(0,1). %Rekursionsabschluss.

% Wenn S ungerade, wird der Exponent laut Leibniz-Reihe -1 bleiben.
leibnitzschereihenzerlegung(S,Resultat):-
                S > 0,
                odd(S),
                DoubleSchritte is S*2,
                Divisor is DoubleSchritte+1,
                Ergebnis1 is -1/Divisor, % Dividend wird fix auf -1 gesetzt, da ein ungerader Exponent -1 negativ lässt.
                S1 is S-1,
                leibnitzschereihenzerlegung(S1,Ergebnis2),
                Resultat is Ergebnis2+Ergebnis1.
   
% Wenn S gerade, wird der Exponent laut Leibniz-Reihe zu 1.   
leibnitzschereihenzerlegung(S,Resultat):-
                S > 0,
                not((odd(S))),
                DoubleSchritte is S*2,
                Divisor is DoubleSchritte+1,
                Ergebnis1 is 1/Divisor, % Dividend wird fix auf 1 gesetzt, da ein gerader Exponent -1 positiv macht.
                S1 is S-1,
                leibnitzschereihenzerlegung(S1,Ergebnis2),
                Resultat is Ergebnis2+Ergebnis1.    

:- dynamic mypiendrec/2.
% Struktur: mypiendrec(+Schritte, ?Resultat).
% Berechnung erfolgt beim rekursiven Abstieg. Endrekursiv.
mypiendrec(Schritte,Resultat):- leibnitz2(Schritte,0,Resultat).

leibnitz2(0,Zwischenergebnis,Resultat):- 
            LastSum is Zwischenergebnis + 4,
            Resultat is LastSum. %Rekursionsabschluss.


% Wenn S ungerade, wird der Exponent laut Leibniz-Reihe -1 bleiben.
leibnitz2(S,Zwischenergebnis,Ergebnis):-
                S > 0,
                odd(S),
                DoubleSchritte is S*2,
                Divisor is DoubleSchritte+1,
                Quotient is -1/Divisor, % Dividend wird fix auf -1 gesetzt, da ein ungerader Exponent -1 negativ lässt.
                Multiple is 4*Quotient,
                NewSum is Zwischenergebnis + Multiple,
                S1 is S-1,
                leibnitz2(S1,NewSum,Ergebnis).

% Wenn S gerade, wird der Exponent laut Leibniz-Reihe zu 1.  
leibnitz2(S,Zwischenergebnis,Ergebnis):-
                S > 0,
                not((odd(S))),
                DoubleSchritte is S*2,
                Divisor is DoubleSchritte+1,
                Quotient is 1/Divisor,  % Dividend wird fix auf 1 gesetzt, da ein gerader Exponent -1 positiv macht.
                Multiple is 4*Quotient,
                NewSum is Zwischenergebnis + Multiple,
                S1 is S-1,
                leibnitz2(S1,NewSum,Ergebnis).
 
:- dynamic wallipi/2.
% Struktur: wallipi(+Schritte, ?Resultat).
% Berechnung erfolgt beim rekursiven Abstieg. Endrekursiv.
wallipi(Schritte,Resultat):- Schritte > 0, walli(Schritte,1,Resultat).

walli(0,Zwischensumme,Resultat):- NewSum is Zwischensumme * 2, Resultat is NewSum.
walli(S,Zwischensumme,Resultat):-
            S > 0,
            Doubleschritte is S*2,
            Dividend is Doubleschritte * Doubleschritte,
            Pos is Doubleschritte + 1,
            Neg is Doubleschritte - 1,
            Divisor is Neg * Pos,
            Quotient is Dividend / Divisor,
            NewSum is Zwischensumme * Quotient,
            S1 is S-1,
            walli(S1,NewSum,Resultat).
                
                
                