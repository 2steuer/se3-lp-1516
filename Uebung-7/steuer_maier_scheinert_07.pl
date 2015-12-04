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
    
