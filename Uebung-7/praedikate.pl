% get_dir_path(?VerzNr, ?List)
% Holt fuer ein durch eine ID identifiziertes Verzeichnis den vollstandigen Pfad.
get_dir_path(VerzNr, List) :- dir_path(VerzNr, List, []).

%% Intern genutztes Praedikat. Der Aggregator wird hier verwendet, um die Liste per Endrekursion zurueck zu geben.
dir_path(0,Aggr,Aggr).
dir_path(VerzNr, List, Aggr) :- 
	directory(VerzNr,Name,Parent,_,_),
	dir_path(Parent, List, [Name|Aggr]).

% get_file_path(?VerzNr, ?DatName, ?List)
% Holt fuer eine per Namen identifizierte Datei in einem Verzeichnis den vollstandigen Pfad.
get_file_path(VerzNr, DatName, List) :-
	file(_,VerzNr,DatName,_,_,_),
	dir_path(VerzNr, List, [DatName]).