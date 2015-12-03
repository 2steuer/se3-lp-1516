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