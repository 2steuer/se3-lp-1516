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
            
            
:- dynamic binomial/3.
% Struktur: binomial(+N,+K,?Ergebnis).

binomial(_,0,1). % Rekursionsaschluss
binomial(X,X,1). % Rekursionsaschluss
binomial(N,K,Ergebnis):-
            N > 0,
            K > 0,
            N =\= K,
            Nneg is N-1,
            Kneg is K-1,
            binomial(Nneg,Kneg,Ergebnis1),
            binomial(Nneg,K,Ergebnis2),
            Ergebnis is Ergebnis1 + Ergebnis2.
%------------------------------------------------------------------                
% Bonus:
% Hilfspraedikat zur Berechnung der Fakultät.
fak(0,1). 
fak(Zahl,Fakultaet):- 
   Zahl > 0, 
   Zahl1 is Zahl - 1, 
   fak(Zahl1,Fakultaet1), 
   Fakultaet is Zahl * Fakultaet1.

% Umsetzung der ersten Bonus-Implementierung.   
:- dynamic binomial2/3.
% Struktur: binomial2(+N,+K,?Ergebnis).
binomial2(N,K,Ergebnis):-
            fak(N,Fak1),
            fak(K,Fak2),
            MinusK is N-K,
            fak(MinusK,Fak3),
            Divisor is Fak2 * Fak3,
            Dividend is Fak1,
            Ergebnis is Dividend / Divisor.
            
% Umsetzung der zweiten Bonus-Implementierung. 
:- dynamic binomial3/3.
% Struktur: binomial3(+N,+K,?Ergebnis).
binomial3(N,K,Ergebnis):- helper(N,K,1,1,Ergebnis).

helper(_,K,Zaehler,Zwischensumme,Ergebnis):- Zaehler > K, Ergebnis is Zwischensumme.
helper(N,K,Zaehler,Zwischensumme,Ergebnis):-
            ((Zaehler < K); (Zaehler =:= K)),
            Dividend is N + 1 - Zaehler,
            Quotient is Dividend / Zaehler,
            NewSum is Zwischensumme * Quotient,
            Zaehler1 is Zaehler + 1,
            helper(N,K,Zaehler1,NewSum,Ergebnis).
    
               
               
               
               
               
               
               
               
               
               
               
                