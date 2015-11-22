%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Aufgabe 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
- b(x,y) unifiziert mit b(Y, X) mit Y = x, X = y.
- t(r,i) unifiziert mit t(Z, Z) mit Z = r und Z = i, also r = i.
- b(g(F,k),g(k,F)) unifiziert mit b(g(m,H),g(H,m)) mit F = m, H = k.
- m(X, c(g), h(x)) unifiziert nicht mit m(t(r,s), c(u), h(g(T)), t), da m jeweils verschiedenstellig ist.
- false unifizert mit not(true) per definition.
- False unifiziert mit False = not(true). (False hier Variable).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Aufgabe 2.1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Praedikte wurden in praedikate.pl definiert.

Praedikat: nachfolger_peano
    % Positiv-Tests:
        % ?- nachfolger_peano(X,Y).
        % X = 0,
        % Y = s(0) .

        % ?- nachfolger_peano(X,s(0)).
        % X = 0 .

        % ?- nachfolger_peano(s(0),X).
        % X = s(s(0)).

        % ?- nachfolger_peano(s(0),s(s(0))).
        % true.
        
    % Negativ-Tests:
        % ?- nachfolger_peano(s(0),s(s(s(0)))).
        % false.

        % ?- nachfolger_peano(s(s(0)),s(0)).
        % false.

        % ?- nachfolger_peano(s(0),s(0)).
        % false.
        
Praedikat: vorgaenger_von
    % Positiv-Tests:
        % ?- vorgaenger_peano(Zahl,Vorgaenger).
        % Zahl = s(0),
        % Vorgaenger = 0 .

        % ?- vorgaenger_peano(Zahl,s(0)).
        % Zahl = s(s(0)).

        % ?- vorgaenger_peano(s(0),Vorgaenger).
        % Vorgaenger = 0 .

        % ?- vorgaenger_peano(s(s(0)),s(0)).
        % true.
        
    % Negativ-Tests:
        % ?- vorgaenger_peano(s(s(0)),0).
        % false.

        % ?- vorgaenger_peano(s(0),s(s(s(0)))).
        % false.

        % ?- vorgaenger_peano(s(0),s(0)).
        % false.
        
Praedikat: subtrahiere
    % Positiv-Tests:
        % ?- subtrahiere(0,0,0).
        % true .

        % ?- subtrahiere(s(0),0,s(0)).
        % true .

        % ?- subtrahiere(s(0),s(0),0).
        % true .

        % ?- subtrahiere(s(s(s(0))),Subtrahend,0).
        % Subtrahend = s(s(s(0))) .

        % ?- subtrahiere(s(s(s(0))),s(0),Differenz).
        % Differenz = s(s(0)) .

        % ?- subtrahiere(Minuend,s(0),s(s(s(0)))).
        % Minuend = s(s(s(s(0)))).
        
    % Negativ-Tests:
        % ?- subtrahiere(0,s(0),0).
        % false.

        % ?- subtrahiere(s(0),s(0),s(0)).
        % false.
        
Praedikat: verdoppelt
    % Positiv-Tests:
        % ?- verdoppelt(0,0).
        % true.

        % ?- verdoppelt(s(s(0)),s(s(s(s(0))))).
        % true.

        % ?- verdoppelt(s(0),Zahlverdoppelt).
        % Zahlverdoppelt = s(s(0)).

        % ?- verdoppelt(Zahl,s(s(s(s(0))))).
        % Zahl = s(s(0)).
        
    % Negativ-Tests:
        % ?- verdoppelt(0,1).
        % false.

        % ?- verdoppelt(s(s(0)),s(s(0))).
        % false.

        % ?- verdoppelt(s(s(0)),s(0)).
        % false.
        
Praedikat: modulo
    % Positiv-Tests:
        % ?- modulo(s(s(s(0))),s(0),0).
        % true .

        % ?- modulo(s(0),s(0),0).
        % true .

        % ?- modulo(s(s(s(0))),s(s(0)),s(0)).
        % true .

        % ?- modulo(s(s(s(s(s(0))))),s(s(s(0))),s(s(0))).
        % true .
        
    % Negativ-Tests:
        % ?- modulo(s(0),s(0),s(0)).
        % false.

        % ?- modulo(s(s(0)),s(0),s(0)).
        % false.