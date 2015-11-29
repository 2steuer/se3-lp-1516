%%%%%%%%%%%%%%
Aufgabe 1.2
%%%%%%%%%%%%%%
Das Prädikat lautet wie folgt:
zins_direkt(B,Z,D,G) :- G is (1+Z)^D*B.

%%%%%%%%%%%%%%
Aufgabe 1.5
%%%%%%%%%%%%%%
Da für den variablen Zinssatz VZ(n) nach n Jahren gilt: VZ(n) = (2^(n+1)-1)/(2^(n-1)) gilt, und lim_n->∞ VZ(n) = 4 gilt,
übersteigt der variable Zinssatz nie den konstanten, sondern ist in jedem einzelnen Jahr schlechter. Daraus folgt selbstverständlich,
dass auch in der Summe, und damit für jeden Anlegezeitraum der variable Zinssatz schlechter ist.


%%%%%%%%%%%%%%
Aufgabe 2.1
%%%%%%%%%%%%%%
Praedikate wurden in praedikate.pl definiert.

1. Variante: Berechnung beim rekursiven Aufstieg.
    Tests:
        ?- mypi(10,Pi).
        Pi = 3.232315809405594 ;
        false.
        
        ?- mypi(100,Pi).
        Pi = 3.1514934010709914 ;
        false. 
        
        ?- mypi(1000,Pi).
        Pi = 3.1425916543395442 ;
        false.
    Ganz offensichtlich funktioniert das Praedikat. Das Pi beim rekursiven Aufstieg
    erst berechnet wird, zeigt der Trace:
    
   [trace] 1 ?- mypi(1,Pi).
   Call: (7) mypi(1, _G2074) ? creep
   Call: (8) leibnitzschereihenzerlegung(1, _G2150) ? creep
   Call: (9) 1>0 ? creep
   Exit: (9) 1>0 ? creep
   Call: (9) odd(1) ? creep
   Call: (10) 1>0 ? creep
   Exit: (10) 1>0 ? creep
   Call: (10) 1 is 1 mod 2 ? creep
   Exit: (10) 1 is 1 mod 2 ? creep
   Exit: (9) odd(1) ? creep
   Call: (9) _G2155 is 1*2 ? creep
   Exit: (9) 2 is 1*2 ? creep
   Call: (9) _G2158 is 2+1 ? creep
   Exit: (9) 3 is 2+1 ? creep
   Call: (9) _G2161 is -1/3 ? creep
   Exit: (9) -0.3333333333333333 is -1/3 ? creep
   Call: (9) _G2168 is 1+ -1 ? creep
   Exit: (9) 0 is 1+ -1 ? creep
   Call: (9) leibnitzschereihenzerlegung(0, _G2169) ? creep
   Exit: (9) leibnitzschereihenzerlegung(0, 1) ? creep %Abbruchbedingung. Danach werden die Teilergebnisse aufsummiert.
   Call: (9) _G2171 is 1+ -0.3333333333333333 ? creep
   Exit: (9) 0.6666666666666667 is 1+ -0.3333333333333333 ? creep
   Exit: (8) leibnitzschereihenzerlegung(1, 0.6666666666666667) ? creep
   Call: (8) _G2074 is 4*0.6666666666666667 ? creep
   Exit: (8) 2.666666666666667 is 4*0.6666666666666667 ? creep
   Exit: (7) mypi(1, 2.666666666666667) ? creep
   Pi = 2.666666666666667 .
   
2. Variante: Berechnung beim rekursiven Abstieg.
    Tests:
        ?- mypiendrec(10,Pi).
        Pi = 3.232315809405593 ;
        false.
        
        ?- mypiendrec(100,Pi).
        Pi = 3.151493401070991 ;
        false.
        
        ?- mypiendrec(1000,Pi).
        Pi = 3.1425916543395434 ;
        false.
    Ganz offensichtlich funktioniert das Praedikat. Das Pi beim rekursiven Abstieg
    erst berechnet wird, zeigt der Trace:
    
   [trace] 4 ?- mypiendrec(1,Pi).
   Call: (7) mypiendrec(1, _G453) ? creep
   Call: (8) leibnitz2(1, 0, _G453) ? creep
   Call: (9) 1>0 ? creep
   Exit: (9) 1>0 ? creep
   Call: (9) odd(1) ? creep
   Call: (10) 1>0 ? creep
   Exit: (10) 1>0 ? creep
   Call: (10) 1 is 1 mod 2 ? creep
   Exit: (10) 1 is 1 mod 2 ? creep
   Exit: (9) odd(1) ? creep
   Call: (9) _G534 is 1*2 ? creep
   Exit: (9) 2 is 1*2 ? creep
   Call: (9) _G537 is 2+1 ? creep
   Exit: (9) 3 is 2+1 ? creep
   Call: (9) _G540 is -1/3 ? creep
   Exit: (9) -0.3333333333333333 is -1/3 ? creep
   Call: (9) _G547 is 4* -0.3333333333333333 ? creep
   Exit: (9) -1.3333333333333333 is 4* -0.3333333333333333 ? creep
   Call: (9) _G554 is 0+ -1.3333333333333333 ? creep
   Exit: (9) -1.3333333333333333 is 0+ -1.3333333333333333 ? creep
   Call: (9) _G561 is 1+ -1 ? creep
   Exit: (9) 0 is 1+ -1 ? creep
   Call: (9) leibnitz2(0, -1.3333333333333333, _G453) ? creep %Abbruchbedingung.
   Call: (10) _G564 is -1.3333333333333333+4 ? creep
   Exit: (10) 2.666666666666667 is -1.3333333333333333+4 ? creep
   Call: (10) _G453 is 2.666666666666667 ? creep
   Exit: (10) 2.666666666666667 is 2.666666666666667 ? creep
   Exit: (9) leibnitz2(0, -1.3333333333333333, 2.666666666666667) ? creep
   Exit: (8) leibnitz2(1, 0, 2.666666666666667) ? creep
   Exit: (7) mypiendrec(1, 2.666666666666667) ? creep
   Pi = 2.666666666666667 .
   
   Bei der Abbruchbedingung wird nur noch das Teilergebnis für Schritte = 0 hinzuaddiert, und dann steht die Berechnung.
   Sie wird nur noch nach oben durchgereicht, weitere Berechnungen finden nicht mehr statt.
   Dies bedeutet, dass Variante 2 endrekursiv ist.
   
%%%%%%%%%%%%%%
Aufgabe 2.2
%%%%%%%%%%%%%%
Variante 2 ist vorzuziehen. Da bei Rekursionen die Zwischenergebnisse auf einem Stack gesammelt werden und dieser den Speicher sprengen kann,
ist in den meisten Fällen die Endrekursion vorzuziehen. Auch ist sie verständlicher, da ein Außenstehender sofort erkennen kann,
dass das Zwischenergebnis immer mitgenommen wird, und später dann zum Ergebnis wird.

%%%%%%%%%%%%%%
Aufgabe 2.3
%%%%%%%%%%%%%%
Praedikat wurden in praedikate.pl definiert.
    Tests:
    
    ?- wallipi(0,Pi). % Richtig, so besagt es zumindestens das Wallische Produkt. Schritte > 0 muss gelten.
    false.
    
    ?- wallipi(10,Pi).
    Pi = 3.0677038066434994 ;
    false.
    
    ?- wallipi(100,Pi).
    Pi = 3.133787490628163 ;
    false.    
    
    ?- wallipi(1000,Pi).
    Pi = 3.1408077460304042 ;
    false.
    
Spannend ist zu beobachten, inwiefern sich das Konvergenzverhalten nach Leibniz-Reihenzerlegung und wallisschem Produkt unterscheidet.
Während für das Prädikat, welches die Leibniz-Reihenzerlegung implementiert,Pi die untere Schrank darstellt, gegen die es konvergiert,
ist es bei dem Prädikat, welches das wallissche Produkt realisiert genau andersherum - hier stellt Pi einen oberen Grenzwert dar, der nie erreicht wird.

%%%%%%%%%%%%%%
Aufgabe 4.1
%%%%%%%%%%%%%%
Praedikat wurden in praedikate.pl definiert.
    Dieses Prädikat ist nicht endrekursiv. Die Berechnung erfolgt beim rekursiven Aufstieg.
    Tests:
    ?- binomial(1,1,Binomialkoeffizient).
    Binomialkoeffizient = 1 ; % Prüfung auf mathematisch korrekte Implementation der rekursiven Darstellung.
    false.

    ?- binomial(1,0,Binomialkoeffizient).
    Binomialkoeffizient = 1 ; % Prüfung auf mathematisch korrekte Implementation der rekursiven Darstellung.
    false.

    ?- binomial(5,3,Binomialkoeffizient).
    Binomialkoeffizient = 10 ;
    false.

    ?- binomial(51,50,Binomialkoeffizient).
    Binomialkoeffizient = 51 ;
    false.

    ?- binomial(6,4,Binomialkoeffizient).
    Binomialkoeffizient = 15 ;
    false.
    
    Ganz offensichtlich funktioniert das Prädikat. Auch die Abbruchbedingungen der rekursiven Vorschrift,
    überprüft mit Test 1 und Test 2, werden eingehalten.
    
%%%%%%%%%%%%%%
Aufgabe 4.2
%%%%%%%%%%%%%%

%%%%%%%%%%%%%%
Aufgabe 4.3
%%%%%%%%%%%%%%
Praedikate wurden in praedikate.pl definiert.    

Erste Bonusimplementation: Berechnung beim rekursiven Aufstieg, nicht endrekursiv.
    Tests:
    ?- binomial2(1,0,Binomialkoeffizient).
    Binomialkoeffizient = 1 ; % Prüfung auf mathematisch korrekte Implementation der rekursiven Darstellung.
    false.
    
    ?- binomial2(5,5,Binomialkoeffizient).
    Binomialkoeffizient = 1 ; % Prüfung auf mathematisch korrekte Implementation der rekursiven Darstellung.
    false.
    
    ?- binomial2(5,3,Binomialkoeffizient).
    Binomialkoeffizient = 10 ;
    false.

Zweite Bonusimplementation: Berechnung beim rekursiven Abstieg -> Endrekursiv.
    Tests:
    ?- binomial3(10,3,Binomialkoeffizient).
    Binomialkoeffizient = 120.0 ;  % Spannend! Ergebnis wird mit Nachkommastellen zurueckgegeben.
    false.
    
    ?- binomial3(10,10,Binomialkoeffizient). % Prüfung auf mathematisch korrekte Implementation der rekursiven Darstellung.
    Binomialkoeffizient = 1.0 ;
    false.
    
    ?- binomial3(10,0,Binomialkoeffizient). % Prüfung auf mathematisch korrekte Implementation der rekursiven Darstellung.
    Binomialkoeffizient = 1 ;
    false.
    
    
