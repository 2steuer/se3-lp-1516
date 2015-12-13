
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Aufgabe 1 %%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Praedikate wurden in praedikate.pl definiert.
%%% (1.1) %%%
Tests: Gestalten sich hier, zur Dokumentation, als schwierig, das bei groesseren Betraegen die Zahl
       moeglicher Zerlegungen rasant steigt.

    % Welche Zerlegungen gibt es bei einem Rueckgeld von 5 Cent? Die Ausgabe ist von groß nach klein sortiert.
    ?- changeback(5,Zerlegung,[1,2,5,10,20,50,100,200]).
    Zerlegung = [0, 0, 0, 0, 0, 1, 0, 0] ; % 1*5Cent-Stueck
    Zerlegung = [0, 0, 0, 0, 0, 0, 2, 1] ; % 2*2Cent-Stueck, 1*1Cent-Stueck
    Zerlegung = [0, 0, 0, 0, 0, 0, 1, 3] ; % 1*2Cent-Stueck, 3*1Cent-Stueck
    Zerlegung = [0, 0, 0, 0, 0, 0, 0, 5] ; % 5*1Cent-Stueck
    false.
    
    % Welche Zerlegungen gibt es bei einem Rueckgeld von 4 Cent? Die Ausgabe ist von groß nach klein sortiert.
    ?- changeback(4,Zerlegung,[1,2,5,10,20,50,100,200]).
    Zerlegung = [0, 0, 0, 0, 0, 0, 2, 0] ;
    Zerlegung = [0, 0, 0, 0, 0, 0, 1, 2] ;
    Zerlegung = [0, 0, 0, 0, 0, 0, 0, 4] ;
    false.
    
    % Welche Zerlegungen gibt es bei einem Rueckgeld von 10 Cent? Die Ausgabe ist von groß nach klein sortiert.
    ?- changeback(10,Zerlegung,[1,2,5,10,20,50,100,200]).
    Zerlegung = [0, 0, 0, 0, 1, 0, 0, 0] ;
    Zerlegung = [0, 0, 0, 0, 0, 2, 0, 0] ;
    Zerlegung = [0, 0, 0, 0, 0, 1, 2, 1] ;
    Zerlegung = [0, 0, 0, 0, 0, 1, 1, 3] ;
    Zerlegung = [0, 0, 0, 0, 0, 1, 0, 5] ;
    Zerlegung = [0, 0, 0, 0, 0, 0, 5, 0] ;
    Zerlegung = [0, 0, 0, 0, 0, 0, 4, 2] ;
    Zerlegung = [0, 0, 0, 0, 0, 0, 3, 4] ;
    Zerlegung = [0, 0, 0, 0, 0, 0, 2, 6] ;
    Zerlegung = [0, 0, 0, 0, 0, 0, 1, 8] ;
    Zerlegung = [0, 0, 0, 0, 0, 0, 0, 10] ;
    false.
    
%%% (1.2) %%%
Ausfuehrliche Tests haben gezeigt, dass unser Praedikat keine Mehrfachresultate erzeugt.
Geschuldet ist dies einer unserer Klauseln, die durch ihre speziellen Teilziele redundanzfreies Backtracking ermoeglicht.

%%% (1.3) %%%
Dies war durch die vorherige Arbeit sehr einfach. Da die erste von unserem Praedikat changeback gefundene Zerlegung immer die optimalste ist,
mussten wir nur ein weiteres Praedikat opt_changeback/3 definieren, was nach der ersten erfolgreichen Bestimmung einen Cut setzt.

%%% (1.4) %%%
Ja, unser Praedikat bleibt von solchen Aenderungen unbeinflusst. Da wir zu Beginn das uerbegebene Muenzsystem eh immer sortieren,
gibt es keine Probleme. Unser Praedikat wurde so stark abstrahiert, dass es voellig egal ist, wie das Muenzsystem aussieht. 
Zwar haben wir in den Tests oben das Eurosystem benutzt, aber jedes andere waere auch moeglich.
Test mit beliebigem Muenzsystem:

    ?- changeback(10,Zerlegung,[1,3,6,9,12,15]).
    Zerlegung = [0, 0, 1, 0, 0, 1] ;
    Zerlegung = [0, 0, 0, 1, 1, 1] ;
    Zerlegung = [0, 0, 0, 1, 0, 4] ;
    Zerlegung = [0, 0, 0, 0, 3, 1] ;
    Zerlegung = [0, 0, 0, 0, 2, 4] ;
    Zerlegung = [0, 0, 0, 0, 1, 7] ;
    Zerlegung = [0, 0, 0, 0, 0, 10] ;
    false.

%%% (1.5) %%%
Wir haben dafuer das Praedikat Kasse definiert. Dieses erwartet ein Muenzsystem, einen zu zerlegenden Geldbetrag und einen Kassenstand.
Daraus wird dann eine Zerlegung erzeugt und der aktualisierte Kassenstand angegeben.
Test; Wir haben von jeder Muenzsorte 10 Stueck in der Kasse. 120 soll ausgegeben werden.

    ?- kasse(120,[1,2,5,10,20,50,100,200],[10,10,10,10,10,10,10,10],Wechselgeld,NeuerKassenstand).
    Wechselgeld = [0, 1, 0, 1, 0, 0, 0, 0],
    NeuerKassenstand = [10, 9, 10, 9, 10, 10, 10, 10] . % Ergebnis nach einer einzigen Abfrage.

%%% (1.Bonus) %%%    
Dafuer wurde das Praedikat warenautomat/6 definiert. Die Funktionsweise wurde in praedikate.pl beschrieben.
Darueberhinaus haben wir ein weiteres Praedikat kaufen/4 definiert, welches einen Kauf-Vorgang abbildet.
Dabei wird auch in der Datenbank der Kassenstand durch rectract und assert aktualisiert.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Aufgabe 2 %%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% (2.1) %%%
Wir entscheiden uns für die Variante mit den orthografischen Schlüsseln.

%%% (2.2) %%%
Kontextfreie Grammatik:

Sei die Menge der Nichtterminale {Buchstabenbaum, Unterbaum, Schliessel, Endmarkierung, Nutzdaten}
Sei die Menge der Terminale {[, ], ',', *, 'Lautsymbol-Liste'}
Bedeute { xy } "xy kann beliebig oft wiederholt werden".

Buchstabenbaum		-> [ {Unterbaum} ] 
Unterbaum			-> { [  Schluessel, {Unterbaum} ] } | [Endmarkierung, Nutzdaten]
Schluessel			-> a-zA-Z0-9
Endmarkierung		-> *
Nutzdaten			-> 'Lautsymbol-Liste'