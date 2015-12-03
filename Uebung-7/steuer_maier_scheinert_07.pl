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