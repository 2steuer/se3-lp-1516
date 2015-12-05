%%%%%%%%%%%%%%%%%%%
%% Aufgabe 1 %%%%%%
%%%%%%%%%%%%%%%%%%%

% Praedikate in praedikate.pl.

% (1) Pfad zu einem Verzeichnis:
?- get_dir_path(9, L).
% L = [root, musik, pop] .

?- get_dir_path(X, [root, musik]).
% X = 3 .

?- get_dir_path(X, L).
% Der vollstaendig unterspezifizierte Aufruf gibt den Pfad fuer jedes Verzeichnis ein mal zurueck.

% (2) Pfad zu Datei:
?- get_file_path(12,scheidungsklage,L).
% L = [root, dokumente, scheidung, scheidungsklage] ;
% false.

?- get_file_path(12,X,L).
% Gibt fuer alle Dateien in einem Verzeichnis den Pfad zurueck.

%% Vollstandig unterspezifiziert gibt das Praedikat fuer alle Dateien den Pfad zurueck.

% (3) N zuletzte geänderte Dateien
?- last_changed_files(5, L).
% L = [[34, [root, dokumente, scheidung, scheidungsklage]], [7, [root, dokumente, urlaub, quartieranfrage]], [1, [root, musik, pop, in_the_summertime]], [3, [root, musik, pop|...]], [2, [root, musik|...]]] ;
% L = [[34, [root, dokumente, scheidung, scheidungsklage]], [7, [root, dokumente, urlaub, quartieranfrage]], [1, [root, musik, pop, in_the_summertime]], [3, [root, musik, pop|...]], [2, [root, musik|...]], [13, [root|...]], [14, [...|...]], [15|...], [...|...]|...] ;
% false.

% Es faellt auf, dass durch Backtracking im zweiten Durchlauf stets ALLE Dateien zurueckgegeben werden.
% Ich habe diesen Fehler nicht mehr beheben koennen.
% Im ersten Anlauf jedoch funktioniert dies. Auch mit großen N (> Dateizahl) wird kein Fehler geworden, sondern
% der Fall wird korrekt behandelt.

%%%%%%%%%%%%%%%%%%%
%% Aufgabe 2 %%%%%%
%%%%%%%%%%%%%%%%%%%

% 1) Das Praedikat macht bei der als Argument uebergebenen Liste das erste Element zur Wurzel des Baums. Alle anderen Elemente
% werden dann daraufhin untersucht, ob sie groesser oder kleiner als das Wurzelelement sind. Generell gilt: Ist ein Element kleinergleich 
% einem gegebenen Wurzelelement, wird es zum "linken" Kind der Wurzel. Ist ein Element groesser als das Wurzelelement,wird es zum "rechten" Kind.
% Beispiel:
% ?- list2tree([1,0,2],Baum).
% Baum = t(1, t(0, end, end), t(2, end, end)) 
% Die 1 wird zum Wurzelelement. Die 0 ist das einzige Element kleinergleich der 1, sie wird also zum linken Kind.
% Die 2 ist das einzige Element groesser der 1, sie wird also zum rechten Kind. In diesem Fall sind 0 und 1 sogar Blaetter, da sie
% selbst keine Kinder mehr haben.
% Dies zeigt auch schon, wie eine Eingabeliste sortiert sein muesste, damit ein daraus entstehender Baum balanciert ist.
% Zum einen muss die Eingabeliste eine ungerade Laenge haben, denn abzueglich des ersten Elements, was als Wurzel des Baumes dient,
% muessen gerade viele Elemente vorhanden sein, um einen balancierenden Baum zu erzeugen.
% Auch muss es von dieser geraden Anzahl an Elementen gleich viele Elemente kleinergleich und groesser des ersten Elements der Liste geben.
% Eine Liste der Form [2,1,0,3,4] wuerde also zum Erfolg fuehren, nicht aber eine Liste der Form [1,0,2,3].

% 2)
% Wir haben das Praedikat so angepasst, das grundsaetzlich zwei Operationen notwendig sind.
% Es ist weiterhin moeglich, wie vorher einfach nur einzelne Elemente in eine Liste einzutragen, und diese
% Liste dann zu einem Baum zu machen.
% Auf der anderen Seite ist es aber auch moeglich, zusaetzliche Informationen in Form eines einzelnen Strings abzuspeichern.
% Dies sieht dann wie folgt aus: [[2,"Wurzel"],[1,"KnotenLinks"],[3,"KnotenRechts"]]. Nach laengerem Ueberlegen kam uns diese
% Realisierung am sinnvollsten vor. Moechte man also Informationen einem Element der Liste mitgeben, kann man dies mit 
% [Element, Information] tun. Funktionieren tut das ganze auch:

    % Test, wobei man jedem Element Informationen hinzufuegt.
    % ?- list2tree([[2,"Wurzel"],[3,"KnotenRechts"],[2,"KnotenLinks"]],Baum).
    % Baum = t(w(2, "Wurzel"), t(w(2, "KnotenLinks"), end, end), t(w(3, "KnotenRechts"), end, end)) .
    
    % Test, wobei man der Haelfte der Elemente Informationen hinzufuegt.
    % ?- list2tree([[2,"Wurzel"],3,[1,"KnotenLinks"],0,[4,"KnotenRechts"]],Baum).
    % Baum = t(w(2, "Wurzel"), t(w(1, "KnotenLinks"), t(0, end, end), end), t(3, end, t(w(4, "KnotenRechts"), end, end))) .
    
    % Test, ob die alte Funktionalitaet unbeschaedigt ist.
    Baum = t(2, t(1, t(0, end, end), end), t(3, end, t(4, end, end))) .
   
% 3)
% Idee: Wir benutzen das Praedikat aus dem Skript, mit dem man einen Baum in eine Liste umwandeln kann.
% In der fertigen Liste suchen wir dann einfach nach dem Key(dem Element) und koennen so die Information,
% die an das jeweilige Element gebunden ist, abfragen. Dafuer muessen wir noch ein neues Praedikat schreiben.
% Dieses Praedikat schaut sich jedes Element der Liste an, vergleicht es mit dem Element aus der Anfrage,
% und gibt bei einer Uebereinstimmung die hinterlegte Information zurueck.
 
    % Test: Funktioniert das Umwandeln, auch von unseren modifizierten Baeumen, in eine Liste?
    % ?- tree2list(t(w(2, "Wurzel"), t(w(2, "KnotenLinks"), end, end), t(w(3, "KnotenRechts"), end, end)),Liste).
    % Liste = [w(2, "KnotenLinks"), w(2, "Wurzel"), w(3, "KnotenRechts")].
    % Test ist geglueckt.
    
    % Test: Arbeitet das definierte Praedikat information so, wie erwartet?
    
    % ?- information(3,[w(2, "Wurzel"), w(3, "KnotenRechts")],Information).
    % Information = "KnotenRechts" .
    % True fuer Elemente, die in der Liste enthalten sind und Informationen besitzen.
    
    % ?- information(5,[w(2, "Wurzel"), w(3, "KnotenRechts")],Information).
    % false.
    % False fuer Elemente, die zwar Informationen besitzen, aber nicht in der Liste sind.
    
    % ?- information(4,[w(2, "Wurzel"),4,5,6],Information).
    % false.
    % False fuer Elemente, die zwar in der Liste sind, aber keine Informationen besitzen.
    
    % Test des Gesamtpraedikats getinfo, welches als Argumente ein Element und einen Baum nimmt,
    % und die entsprechende Information, wenn existent, zurueckgibt.
    
    % ?- getinfo(3,t(w(2, "Wurzel"), t(w(2, "KnotenLinks"), end, end), t(w(3, "KnotenRechts"), end, end)),Information).
    % Information = "KnotenRechts" .
    
    % ?- getinfo(3,t(w(2, "Wurzel"), t(w(2, "KnotenLinks"), end, end),end),Information).
    % false.
    
    % ?- getinfo(3,t(w(2, "Wurzel"), t(w(2, "KnotenLinks"), end, end), t(3, end, end)),Information).
    % false.
    
%%%%%%%%%%%%%%%%%%%
%% Aufgabe 4(3) %%%
%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%
% Aufgabe 4.1
%%%%%%%%%%%%%%

?- ham_eqlength([3,1,4,1],[0,1,4,1],1).
% true ;
% false.
%
?- ham_eqlength([3,1,4,1],[0,1,4,1],X).
% X = 1 ;
% false.
%
?- ham_eqlength([3,1,4,1],L,1).        
% L = [3, 1, 4, _G1063] ;
% L = [3, 1, _G1057, 1] ;
% L = [3, _G1051, 4, 1] ;
% L = [_G1045, 1, 4, 1] ;
% false.
% 
?- ham_eqlenght([3,1,4,1],L,X).
% L = [3, 1, 4, 1],
% X = 0 ;
% L = [3, 1, 4, _G1315],
% X = 1 ;
% L = [3, 1, _G1309, 1],
% X = 1 ;
% L = [3, 1, _G1309, _G1315],
% X = 2 ;
% L = [3, _G1303, 4, 1],
% X = 1 ;
% L = [3, _G1303, 4, _G1315],
% X = 2 ;
% L = [3, _G1303, _G1309, 1],
% X = 2 ;
% L = [3, _G1303, _G1309, _G1315],
% X = 3 ;
% L = [_G1297, 1, 4, 1],
% X = 1 ;
% L = [_G1297, 1, 4, _G1315],
% X = 2 ;
% L = [_G1297, 1, _G1309, 1],
% X = 2 ;
% L = [_G1297, 1, _G1309, _G1315],
% X = 3 ;
% L = [_G1297, _G1303, 4, 1],
% X = 2 ;
% L = [_G1297, _G1303, 4, _G1315],
% X = 3 ;
% L = [_G1297, _G1303, _G1309, 1],
% X = 3 ;
% L = [_G1297, _G1303, _G1309, _G1315],
% X = 4 ;
% false.
% 
?- ham_eqlength(L1,L2,X).      
% L1 = L2, L2 = [],
% X = 0 ;
% L1 = L2, L2 = [_G1048],
% X = 0 ;
% L1 = L2, L2 = [_G1048, _G1054],
% X = 0 ;
% L1 = L2, L2 = [_G1048, _G1054, _G1060],
% X = 0 ;
% L1 = L2, L2 = [_G1048, _G1054, _G1060, _G1066],
% X = 0 ;
% L1 = L2, L2 = [_G1048, _G1054, _G1060, _G1066, _G1072],
% X = 0 ;
% L1 = L2, L2 = [_G1048, _G1054, _G1060, _G1066, _G1072, _G1078],
% X = 0 ;
% L1 = L2, L2 = [_G1048, _G1054, _G1060, _G1066, _G1072, _G1078, _G1084],
% X = 0 ;
% L1 = L2, L2 = [_G1048, _G1054, _G1060, _G1066, _G1072, _G1078, _G1084, _G1090],
% X = 0 ;
% L1 = L2, L2 = [_G1048, _G1054, _G1060, _G1066, _G1072, _G1078, _G1084, _G1090, _G1096],
% X = 0 ;
% L1 = L2, L2 = [_G1048, _G1054, _G1060, _G1066, _G1072, _G1078, _G1084, _G1090, _G1096|...],
% X = 0 ;
% ...
% => Unendlich viele Lösungen!

%%%%%%%%%%%%%%
% Aufgabe 4.2
%%%%%%%%%%%%%%

?- ham([0,1,4,1],[3,1,4,1,5,9],3).
% true ;
% false.
% 
?- ham([0,1,4,1],[3,1,4,1,5,9],X).
% X = 3 ;
% false.
%
?- ham([3,1,4,1],L,3).            
% L = [3] ;
% L = [3, 1, 4, 1, _G1087, _G1090, _G1093] ;
% L = [3, 1, 4, _G1084, _G1087, _G1090] ;
% ERROR: Out of global stack
% => Zu viel Rechenaufwand!
% Warum an dieser Stelle? Warum diese plötzliche Steigerung des Rechenaufwandes?
%
?- ham([3,1,4,1],L,X).
% L = [],
% X = 4 ;
% L = [3],
% X = 3 ;
% L = [3, 1],
% X = 2 ;
% L = [3, 1, 4],
% X = 1 ;
% L = [3, 1, 4, 1],
% X = 0 ;
% L = [3, 1, 4, 1],
% X = 0 ;
% L = [3, 1, 4, 1, _G1081],
% X = 1 ;
% L = [3, 1, 4, 1, _G1081, _G1084],
% X = 2 ;
% L = [3, 1, 4, 1, _G1081, _G1084, _G1087],
% X = 3 ;
% L = [3, 1, 4, 1, _G1081, _G1084, _G1087, _G1090],
% X = 4 ;
% L = [3, 1, 4, 1, _G1081, _G1084, _G1087, _G1090, _G1093],
% X = 5 ;
% L = [3, 1, 4, 1, _G1081, _G1084, _G1087, _G1090, _G1093|...],
% X = 6 ;
% L = [3, 1, 4, 1, _G1081, _G1084, _G1087, _G1090, _G1093|...],
% X = 7 ;
% ...
% => Unendlich viele Lösungen!
% Nur Aufbau der Liste am Ende, keine Abweichung.
% 
?- ham(L1,L2,X).
% L1 = L2, L2 = [],
% X = 0 ;
% L1 = L2, L2 = [],
% X = 0 ;
% L1 = [],
% L2 = [_G1048],
% X = 1 ;
% L1 = [],
% L2 = [_G1048, _G1051],
% X = 2 ;
% L1 = [],
% L2 = [_G1048, _G1051, _G1054],
% X = 3 ;
% L1 = [],
% L2 = [_G1048, _G1051, _G1054, _G1057],
% X = 4 ;
% L1 = [],
% L2 = [_G1048, _G1051, _G1054, _G1057, _G1060],
% X = 5 ;
% L1 = [],
% L2 = [_G1048, _G1051, _G1054, _G1057, _G1060, _G1063],
% X = 6 ;
% L1 = [],
% L2 = [_G1048, _G1051, _G1054, _G1057, _G1060, _G1063, _G1066],
% X = 7 ;
% L1 = [],
% L2 = [_G1048, _G1051, _G1054, _G1057, _G1060, _G1063, _G1066, _G1069],
% X = 8 ;
% L1 = [],
% L2 = [_G1048, _G1051, _G1054, _G1057, _G1060, _G1063, _G1066, _G1069, _G1072],
% X = 9 ;
% L1 = [],
% L2 = [_G1048, _G1051, _G1054, _G1057, _G1060, _G1063, _G1066, _G1069, _G1072|...],
% X = 10 ;
% L1 = [],
% L2 = [_G1048, _G1051, _G1054, _G1057, _G1060, _G1063, _G1066, _G1069, _G1072|...],
% X = 11 
% ...
% => Unendlich viele Lösungen!
% Nur Aufbau der zweiten Liste, Doppelergebnis am Anfang


%%%%%%%%%%%%%%
% Aufgabe 4.3
%%%%%%%%%%%%%%

?- ham_list([3,1,4,1],[3,1,4,1,5,9],2,[[3, 3], [1, 1], [4, 4], [1, 1], [*, 5], [*, 9]]).                           
% true ;
% false.
%
?- ham_list([3,1,4,1],[3,1,4,1,5,9],2,L).
% L = [[3, 3], [1, 1], [4, 4], [1, 1], [*, 5], [*, 9]] ;
% false.
%
?- ham_list([3,1,4,1],[3,1,4,1,5,9],D,[[3, 3], [1, 1], [4, 4], [1, 1], [*, 5], [*, 9]]).                           
% D = 2 ;
% false.
% 
?- ham_list([3,1,4,1],L,D,Z).
% L = [],
% D = 4,
% Z = [[*, 3], [*, 1], [*, 4], [*, 1]] ;
% L = [3],
% D = 3,
% Z = [[3, 3], [*, 1], [*, 4], [*, 1]] ;
% L = [3, 1],
% D = 2,
% Z = [[3, 3], [1, 1], [*, 4], [*, 1]] ;
% L = [3, 1, 4],
% D = 1,
% Z = [[3, 3], [1, 1], [4, 4], [*, 1]] ;
% L = [3, 1, 4, 1],
% D = 0,
% Z = [[3, 3], [1, 1], [4, 4], [1, 1]] ;
% L = [3, 1, 4, 1, _G1134],
% D = 1,
% Z = [[3, 3], [1, 1], [4, 4], [1, 1], [*, _G1134]] ;
% L = [3, 1, 4, 1, _G1134, _G1146],
% D = 2,
% Z = [[3, 3], [1, 1], [4, 4], [1, 1], [*, _G1134], [*, _G1146]] ;
% L = [3, 1, 4, 1, _G1134, _G1146, _G1158],
% D = 3,
% Z = [[3, 3], [1, 1], [4, 4], [1, 1], [*, _G1134], [*, _G1146], [*, _G1158]] ;
% L = [3, 1, 4, 1, _G1134, _G1146, _G1158, _G1170],
% D = 4,
% Z = [[3, 3], [1, 1], [4, 4], [1, 1], [*, _G1134], [*, _G1146], [*, _G1158], [*|...]] ;
% L = [3, 1, 4, 1, _G1134, _G1146, _G1158, _G1170, _G1182],
% D = 5,
% Z = [[3, 3], [1, 1], [4, 4], [1, 1], [*, _G1134], [*, _G1146], [*, _G1158], [*|...], [...|...]] ;
% L = [3, 1, 4, 1, _G1134, _G1146, _G1158, _G1170, _G1182|...],
% D = 6,
% Z = [[3, 3], [1, 1], [4, 4], [1, 1], [*, _G1134], [*, _G1146], [*, _G1158], [*|...], [...|...]|...] ;
% L = [3, 1, 4, 1, _G1134, _G1146, _G1158, _G1170, _G1182|...],
% D = 7,
% Z = [[3, 3], [1, 1], [4, 4], [1, 1], [*, _G1134], [*, _G1146], [*, _G1158], [*|...], [...|...]|...] ;
% L = [3, 1, 4, 1, _G1134, _G1146, _G1158, _G1170, _G1182|...],
% D = 8,
% Z = [[3, 3], [1, 1], [4, 4], [1, 1], [*, _G1134], [*, _G1146], [*, _G1158], [*|...], [...|...]|...] ;
% ...
% => Unendlich viele Lösungen!
% Nur Teile des Ergebnisraumes werden erreicht
% 
?- ham_list(L1,L2,D,Z).
% L1 = L2, L2 = Z, Z = [],
% D = 0 ;
% L1 = [],
% L2 = [_G1065],
% D = 1,
% Z = [[*, _G1065]] ;
% L1 = [],
% L2 = [_G1065, _G1077],
% D = 2,
% Z = [[*, _G1065], [*, _G1077]] ;
% L1 = [],
% L2 = [_G1065, _G1077, _G1089],
% D = 3,
% Z = [[*, _G1065], [*, _G1077], [*, _G1089]] ;
% L1 = [],
% L2 = [_G1065, _G1077, _G1089, _G1101],
% D = 4,
% Z = [[*, _G1065], [*, _G1077], [*, _G1089], [*, _G1101]] ;
% L1 = [],
% L2 = [_G1065, _G1077, _G1089, _G1101, _G1113],
% D = 5,
% Z = [[*, _G1065], [*, _G1077], [*, _G1089], [*, _G1101], [*, _G1113]] ;
% L1 = [],
% L2 = [_G1065, _G1077, _G1089, _G1101, _G1113, _G1125],
% D = 6,
% Z = [[*, _G1065], [*, _G1077], [*, _G1089], [*, _G1101], [*, _G1113], [*, _G1125]] ;
% L1 = [],
% L2 = [_G1065, _G1077, _G1089, _G1101, _G1113, _G1125, _G1137],
% D = 7,
% Z = [[*, _G1065], [*, _G1077], [*, _G1089], [*, _G1101], [*, _G1113], [*, _G1125], [*, _G1137]] ;
% L1 = [],
% L2 = [_G1065, _G1077, _G1089, _G1101, _G1113, _G1125, _G1137, _G1149],
% D = 8,
% Z = [[*, _G1065], [*, _G1077], [*, _G1089], [*, _G1101], [*, _G1113], [*, _G1125], [*, _G1137], [*|...]] ;
% L1 = [],
% L2 = [_G1065, _G1077, _G1089, _G1101, _G1113, _G1125, _G1137, _G1149, _G1161],
% D = 9,
% Z = [[*, _G1065], [*, _G1077], [*, _G1089], [*, _G1101], [*, _G1113], [*, _G1125], [*, _G1137], [*|...], [...|...]] ;
% L1 = [],
% L2 = [_G1065, _G1077, _G1089, _G1101, _G1113, _G1125, _G1137, _G1149, _G1161|...],
% D = 10,
% Z = [[*, _G1065], [*, _G1077], [*, _G1089], [*, _G1101], [*, _G1113], [*, _G1125], [*, _G1137], [*|...], [...|...]|...] ;
% L1 = [],
% L2 = [_G1065, _G1077, _G1089, _G1101, _G1113, _G1125, _G1137, _G1149, _G1161|...],
% D = 11,
% Z = [[*, _G1065], [*, _G1077], [*, _G1089], [*, _G1101], [*, _G1113], [*, _G1125], [*, _G1137], [*|...], [...|...]|...] ;
% ...
% => Unendlich viele Lösungen!
% Nur Teile des Ergebnisraumes werden erreicht

%%%%%%%%%%%%%%
% Aufgabe 4.4
%%%%%%%%%%%%%%

?- alignment([3,1,4,1],[3,1,1,4,1],1,[[3, 3], [1, 1], [*, 1], [4, 4], [1, 1]]).
% true ;
% false.
% 
?- alignment([3,1,4,1],[3,1,1,4,1],4,[[3, 3], [1, 1], [4, 1], [1, *], [*, 4], [*, 1]]).
% true ;
% false.
% 
?- alignment([3,1,4,1],[3,1,1,4,1],1,Z).
% Z = [[3, 3], [1, 1], [*, 1], [4, 4], [1, 1]] ;
% false.
% 
?- alignment([3,1,4,1],[3,1,1,4,1],2,Z).
% Z = [[3, 3], [1, 1], [4, 1], [*, 4], [1, 1]] ;
% false.
% 
?- alignment([3,1,4,1],[3,1,1,4,1],3,Z).
% Z = [[3, 3], [1, 1], [4, 1], [1, 4], [*, 1]] ;
% Z = [[3, 3], [1, 1], [4, *], [1, 1], [*, 4], [*, 1]] ;
% false.
% 
?- alignment([3,1,4,1],[3,1,1,4,1],4,Z). 
% Z = [[3, 3], [1, 1], [4, 1], [1, *], [*, 4], [*, 1]] ;
% false.
% 
?- alignment([3,1,4,1],[3,1,1,4,1],5,Z).
% false.
% 
?- alignment([3,1,4,1],[3,1,1,4,1],D,[[3, 3], [1, 1], [4, 1], [1, *], [*, 4], [*, 1]]).
% D = 4 ;
% false.
% 
?- alignment([3,1,4,1],[3,1,1,4,1],D,Z).
% D = 3,
% Z = [[3, 3], [1, 1], [4, 1], [1, 4], [*, 1]] ;
% D = 2,
% Z = [[3, 3], [1, 1], [4, 1], [*, 4], [1, 1]] ;
% D = 4,
% Z = [[3, 3], [1, 1], [4, 1], [1, *], [*, 4], [*, 1]] ;
% D = 1,
% Z = [[3, 3], [1, 1], [*, 1], [4, 4], [1, 1]] ;
% D = 3,
% Z = [[3, 3], [1, 1], [4, *], [1, 1], [*, 4], [*, 1]] ;
% false.
% 
?- alignment([3,1,4,1],L,D,Z).                                                 
% L = [],
% D = 4,
% Z = [[*, 3], [*, 1], [*, 4], [*, 1]] ;
% L = [3],
% D = 3,
% Z = [[3, 3], [*, 1], [*, 4], [*, 1]] ;
% L = [3, 1],
% D = 2,
% Z = [[3, 3], [1, 1], [*, 4], [*, 1]] ;
% L = [3, 1, 4],
% D = 1,
% Z = [[3, 3], [1, 1], [4, 4], [*, 1]] ;
% L = [3, 1, 4, 1],
% D = 0,
% Z = [[3, 3], [1, 1], [4, 4], [1, 1]] ;
% L = [3, 1, 4, 1, _G1137],
% D = 1,
% Z = [[3, 3], [1, 1], [4, 4], [1, 1], [*, _G1137]] ;
% L = [3, 1, 4, 1, _G1137, _G1149],
% D = 2,
% Z = [[3, 3], [1, 1], [4, 4], [1, 1], [*, _G1137], [*, _G1149]] ;
% L = [3, 1, 4, 1, _G1137, _G1149, _G1161],
% D = 3,
% Z = [[3, 3], [1, 1], [4, 4], [1, 1], [*, _G1137], [*, _G1149], [*, _G1161]] ;
% L = [3, 1, 4, 1, _G1137, _G1149, _G1161, _G1173],
% D = 4,
% Z = [[3, 3], [1, 1], [4, 4], [1, 1], [*, _G1137], [*, _G1149], [*, _G1161], [*|...]] ;
% L = [3, 1, 4, 1, _G1137, _G1149, _G1161, _G1173, _G1185],
% D = 5,
% Z = [[3, 3], [1, 1], [4, 4], [1, 1], [*, _G1137], [*, _G1149], [*, _G1161], [*|...], [...|...]] ;
% L = [3, 1, 4, 1, _G1137, _G1149, _G1161, _G1173, _G1185|...],
% D = 6,
% Z = [[3, 3], [1, 1], [4, 4], [1, 1], [*, _G1137], [*, _G1149], [*, _G1161], [*|...], [...|...]|...] ;
% L = [3, 1, 4, 1, _G1137, _G1149, _G1161, _G1173, _G1185|...],
% D = 7,
% Z = [[3, 3], [1, 1], [4, 4], [1, 1], [*, _G1137], [*, _G1149], [*, _G1161], [*|...], [...|...]|...] ;
% ...
% => Unendlich viele Lösungen!
% Nur Teile des Ergebnisraumes werden erreicht
% 
?- alignment([3,1,4,1],L,3,Z).
% L = [3],
% Z = [[3, 3], [*, 1], [*, 4], [*, 1]] ;
% L = [3, 1, 4, 1, _G1122, _G1134, _G1146],
% Z = [[3, 3], [1, 1], [4, 4], [1, 1], [*, _G1122], [*, _G1134], [*, _G1146]] ;
% => Terminierungsproblem!
% 
?- alignment(L1,L2,D,Z).      
% L1 = L2, L2 = Z, Z = [],
% D = 0 ;
% L1 = [],
% L2 = [_G463433],
% D = 1,
% Z = [[*, _G463433]] ;
% L1 = [],
% L2 = [_G463433, _G463445],
% D = 2,
% Z = [[*, _G463433], [*, _G463445]] ;
% L1 = [],
% L2 = [_G463433, _G463445, _G463457],
% D = 3,
% Z = [[*, _G463433], [*, _G463445], [*, _G463457]] ;
% L1 = [],
% L2 = [_G463433, _G463445, _G463457, _G463469],
% D = 4,
% Z = [[*, _G463433], [*, _G463445], [*, _G463457], [*, _G463469]] ;
% L1 = [],
% L2 = [_G463433, _G463445, _G463457, _G463469, _G463481],
% D = 5,
% Z = [[*, _G463433], [*, _G463445], [*, _G463457], [*, _G463469], [*, _G463481]] ;
% L1 = [],
% L2 = [_G463433, _G463445, _G463457, _G463469, _G463481, _G463493],
% D = 6,
% Z = [[*, _G463433], [*, _G463445], [*, _G463457], [*, _G463469], [*, _G463481], [*, _G463493]] ;
% L1 = [],
% L2 = [_G463433, _G463445, _G463457, _G463469, _G463481, _G463493, _G463505],
% D = 7,
% Z = [[*, _G463433], [*, _G463445], [*, _G463457], [*, _G463469], [*, _G463481], [*, _G463493], [*, _G463505]] ;
% L1 = [],
% L2 = [_G463433, _G463445, _G463457, _G463469, _G463481, _G463493, _G463505, _G463517],
% D = 8,
% Z = [[*, _G463433], [*, _G463445], [*, _G463457], [*, _G463469], [*, _G463481], [*, _G463493], [*, _G463505], [*|...]] ;
% L1 = [],
% L2 = [_G463433, _G463445, _G463457, _G463469, _G463481, _G463493, _G463505, _G463517, _G463529],
% D = 9,
% Z = [[*, _G463433], [*, _G463445], [*, _G463457], [*, _G463469], [*, _G463481], [*, _G463493], [*, _G463505], [*|...], [...|...]] ;
% L1 = [],
% L2 = [_G463433, _G463445, _G463457, _G463469, _G463481, _G463493, _G463505, _G463517, _G463529|...],
% D = 10,
% Z = [[*, _G463433], [*, _G463445], [*, _G463457], [*, _G463469], [*, _G463481], [*, _G463493], [*, _G463505], [*|...], [...|...]|...] ;
% L1 = [],
% L2 = [_G463433, _G463445, _G463457, _G463469, _G463481, _G463493, _G463505, _G463517, _G463529|...],
% D = 11,
% Z = [[*, _G463433], [*, _G463445], [*, _G463457], [*, _G463469], [*, _G463481], [*, _G463493], [*, _G463505], [*|...], [...|...]|...] ;
% ...
