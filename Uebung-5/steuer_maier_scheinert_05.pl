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
        