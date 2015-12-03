
%%%%% (1.1)
% get_dir_path(?VerzNr, ?List)
% Holt fuer ein durch eine ID identifiziertes Verzeichnis den vollstandigen Pfad.
get_dir_path(VerzNr, List) :- dir_path(VerzNr, List, []).

%% Intern genutztes Praedikat. Der Aggregator wird hier verwendet, um die Liste per Endrekursion zurueck zu geben.
dir_path(0,Aggr,Aggr).
dir_path(VerzNr, List, Aggr) :- 
	directory(VerzNr,Name,Parent,_,_),
	dir_path(Parent, List, [Name|Aggr]).

%%%%% (1.2)

% get_file_path(?VerzNr, ?DatName, ?List)
% Holt fuer eine per Namen identifizierte Datei in einem Verzeichnis den vollstandigen Pfad.
get_file_path(VerzNr, DatName, List) :-
	file(_,VerzNr,DatName,_,_,_),
	dir_path(VerzNr, List, [DatName]).

%%%%% (1.3)

Die Strategie lautet folgendermaßen:
- Erstellen einer Liste, die Tupel enthält, in denen das Änderungsdatum einer Datei, der Name, die ID sowie das enthaltende Verzeichnis vermerkt sind.
- Sortieren dieser Liste nach dem Datum, Absteigenderweise
- Die ersten N Tupel aus der Liste extrahieren
- Anhand der zwischengespeicherten ID, Verzeichnis-ID und des Namens Tupel in eine Liste schreiben, welche Datei-ID und Pfad enthalten.

% get_n_first_elements(+N, +InList, -OutList).
% Gibt aus einer Liste der Tupel [Aenderungsdatum, Dateiname, DateiID, VerzeichnisID]
% die ersten N Elemente zurueck. Hierbei wird direkt in das als Loesung vorgegebene Format [ID, Pfad]
% umgewandelt, um einen weiteren Listendurchlauf per Rekursion zu vermeiden. Grundsaetzlich haette
% man der Uebersicht halber auch lieber in last_changed_files/2 noch eine Zeile einbauen können,
% in welcher dann per Listendurchlauf die Tupel in die Loesungsform umgewandelt werden.

get_n_first_elements(N, InList, OutList) :- get_n_first_elements(N, InList, OutList, []).

% Internes Praedikat mit Aggregator:
get_n_first_elements(0,_,Aggr,Aggr). %% when we counted to 0, stop recursion
get_n_first_elements(_, [], Aggr,Aggr). %% When the input list is empty, stop recursion.

get_n_first_elements(N,[First|Rest],OutList, Aggr) :- 
	NewN is N - 1,
	First = [_, Name, ID, DirID], % Aufsplitten der Liste in die darin gespeicherten Eigenschaften
	get_file_path(DirID, Name, Path), % Den Pfad holen...
	append(Aggr, [[ID, Path]], NewAggr), % Und alles gemeinsam in der Liste speichern (Als Tupel ID, Path)
	get_n_first_elements(NewN, Rest, OutList, NewAggr).

% last_changed_files(+N, -L).
% Gibt in OutList die N zuletzt modifizierten Dateien als Tupel von ID und Zugriffspfad zurueck.
% Leider kannte mein swipl kein sort/4 (http://www.swi-prolog.org/pldoc/doc_for?object=sort/4),
% Daher musste ich mit dem sort/2 sortieren und dann die Liste invertieren.
last_changed_files(N, L) :-
	findall([Date, Name, ID, DirID], file(ID,DirID,Name,_,_,Date), FileList), % Datum nach vorn
	sort(FileList,SortedFileList), 				% Sortiert nach Datum
	reverse(SortedFileList,ReversedList), 		% Hole die letzte Aenderung nach vorn
	get_n_first_elements(N, ReversedList, L). 	% Und hole die ersten N Eintraege

Der Rechenzeitbedarf ist hier insofern relativ groß, als dass im ersten Schritt alle Dateien in eine große Liste schreiben (O(?)),
Diese Liste dann sortieren (O(n log n)), und hiernach noch zwei mal durch ie Liste gehen um sie ein mal umzukehren
und um die ersten N Elemente aus ihr zu extrahieren. (2*O(n)).
Verbesserungsbedarf wäre hier, wie bereits angesprochen noch in der sort-Funktion, welche im besten Falle die Reverse-Funktion insofern überflüssig macht,
als dass man direkt das Absteigende Sortieren erlaubt.