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
Praedikate wurden in praedikate.pl definiert.

Praedikat: nachfolger_peano
Dieses Praedikat ist richtungsunabhaengig.
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
Dieses Praedikat ist richtungsunabhaengig.
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
Dieses Praedikat ist nicht richtungsunabhaengig, da es keine negativen Peano-Zahlen gibt, und somit eine
Eingabe wie subtrahiere(s(0),s(s(0)),X) false liefert.
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
Dieses Praedikat ist richtungsunabhaengig.
    % Positiv-Tests:
        % ?- verdoppelt(0,0).
        % true.
        
        % ?- verdoppelt(Einfach,Doppelt).
        % Einfach = Doppelt, Doppelt = 0 ;
        % Einfach = s(0),
        % Doppelt = s(s(0)) ;
        % Einfach = s(s(0)),
        % Doppelt = s(s(s(s(0)))) 
        % ...
        
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
Dieses Praedikat ist nicht richtungsunabhaengig, da es fuer einen Wert fuer Modulo unendlich viele Loesungen gibt.
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
        
<<<<<<< HEAD
Praedikat: peano_zu_int
Dieses Praedikat ist richtungsunabhaengig.
    % Positiv-Tests:    
        % ?- peano_zu_int(0,0).
        % true.

        % ?- peano_zu_int(s(0),1).
        % true.

        % ?- peano_zu_int(s(s(s(0))),Integer).
        % Integer = 3.

        % ?- peano_zu_int(Peano,5).
        % Peano = s(s(s(s(s(0))))) .
        
        % ?- peano_zu_int(Peano,Integer).
        % Peano = Integer, Integer = 0 ;
        % Peano = s(0),
        % Integer = 1 ;
        % Peano = s(s(0)),
        % Integer = 2 ;
        % Peano = s(s(s(0))),
        % Integer = 3 ;
        % Peano = s(s(s(s(0)))),
        % Integer = 4 
        % ...       
        
    % Negativ-Tests:
        % ?- peano_zu_int(s(0),0).
        % false.

        % ?- peano_zu_int(s(s(0)),4).
        % false.
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Aufgabe 2.2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Praedikate wurden in praedikate.pl definiert.

Prolog testet die Argumente auf ihren Typ. Dies ist gut nachvollziehbar im Trace:

[trace] 12 ?- add(0,0,0).
   Call: (7) add(0, 0, 0) ? creep
   Call: (8) integer(0) ? creep
   Exit: (8) integer(0) ? creep  % Der Test fuer das erste Argument war positiv.
   Call: (8) compound(0) ? creep
   Fail: (8) compound(0) ? creep % Der Test fuer das zweite Argument war negativ. 
                                 % Es wird ein zweiter Test durchgefuehrt(Laut Definition sind zwei Typen fuer dieses Argument zulaessig).
   Redo: (7) add(0, 0, 0) ? creep
   Call: (8) integer(0) ? creep
   Exit: (8) integer(0) ? creep  % Dieses mal ist der Test erfolgreich. Da zweites Argument = drittes Argument, sind wir fertig.
   Exit: (7) add(0, 0, 0) ? creep
true.

Typtests sind nuetzlich, um die Sicherheit eines Programms zu erhoehen,
moegliche Fehler oder fehlerhafte Nutzung zu reduzieren
oder ganz zu vermeiden.
        
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Aufgabe 3.1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Positivtest
        % ?- ist_betroffen_von(X,Y,Z).
        % [...] ;
        % false
    
    % Negativtest
        % ?- ist_betroffen_von(praha,hamburg,X).
        % false.
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Aufgabe 3.2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Positivtest
        % ?- ist_betroffen_von(X,Y,Z).
        % [...] ;
        % false
    
    % Negativtest
        % ?- ist_betroffen_von(praha,hamburg,X).
        % false.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Aufgabe 5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Alle Prädikate ähneln sich in der Hinsicht, dass sie Wege innerhalb von Bäumen finden.
Vor allem die Wegfindungs-Prädikate sollen nun aber auch Wege in allgemeinen gerichteten und ungerichteten Graphejn finden.
Daher ist es notwendig, dass dort ein Abbruch erfolgt, sobald bspw. ein Weg gesucht wird, welcher in die Falsche Richtung läuft.
Bei Verwandtscahftsbeziehungen und Vorbesitzern von Immobilien ist dies unter den hier gestellten Annahmen nicht notwendig, so
entfällt dort möglicherweise auch die Zyklenerkennung, welche in allg. Graphen für eine Terminierung unumgänglich ist.
Um ein Beispiel zu konstruieren, in welchem auch diese nicht hilft betrachten wir Dateisysteme, welche symbolische Linnks
auf Ordner unterstützen. Genommen den Fall, es existiert ein Verzeichnis /home/user/test, in diesem legen wir einen Symbolischen Link an,
welcher /home/user/test/zwo heißt und auf /home/user/ zeigt. Dann sind Pfade wie /home/user/test/zwo/test ebenso gültig wie
/home/user/test/zwo/test/zwo ... usw. Zyklenerkennung schlägt hier i.d.R. jedoch fehl, da gegenüber Applikationen
diese symbolischen Links transparent sind.