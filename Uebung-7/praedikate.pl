
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

% Die Strategie lautet folgendermaßen:
% - Erstellen einer Liste, die Tupel enthält, in denen das Änderungsdatum einer Datei, der Name, die ID sowie das enthaltende Verzeichnis vermerkt sind.
% - Sortieren dieser Liste nach dem Datum, Absteigenderweise
% - Die ersten N Tupel aus der Liste extrahieren
% - Anhand der zwischengespeicherten ID, Verzeichnis-ID und des Namens Tupel in eine Liste schreiben, welche Datei-ID und Pfad enthalten.

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

% Der Rechenzeitbedarf ist hier insofern relativ groß, als dass im ersten Schritt alle Dateien in eine große Liste schreiben (O(?)),
% Diese Liste dann sortieren (O(n log n)), und hiernach noch zwei mal durch die Liste gehen um sie ein mal umzukehren
% und um die ersten N Elemente aus ihr zu extrahieren. (2*O(n)).
% Verbesserungsbedarf wäre hier, wie bereits angesprochen noch in der sort-Funktion, welche im besten Falle die Reverse-Funktion insofern überflüssig macht,
% als dass man direkt das Absteigende Sortieren erlaubt.

%%%%% (2.2)

% list2tree(+Liste,?Baum)

list2tree([ ],end). % Rekursionsabschluss
% Mit I kann ein String uebergeben werden, der den direkten Vorgaenger in der Liste beschreibt.
list2tree([[E,I]|R],t(w(E,I),VB,HB)) :-
compound([E,I]),
string(I),
split(R,E,VL,HL),
list2tree(VL,VB),
list2tree(HL,HB).
% Wenn keine Informationen abgespeichert werden sollen, wird dies standardmaessig ausgefuehrt.
list2tree([E|R],t(E,VB,HB)) :-
split(R,E,VL,HL),
list2tree(VL,VB),
list2tree(HL,HB).

%split(+Liste,+MittleresElement,?VordereElemente,?HintereElemente)
split([ ],_,[ ],[ ]).
% angepasst an die Forderung, Informationen abspeichern zu koennen.
split([[E,I]|R],M,[[E,I]|VL],HL) :-
compound([E,I]),
string(I),
E@=<M, split(R,M,VL,HL).
split([[E,I]|R],M,VL,[[E,I]|HL]) :-
compound([E,I]),
string(I),
E@>M, split(R,M,VL,HL).

% aus dem Skript, unmodifiziert.
split([E|R],M,[E|VL],HL) :-
E@=<M, split(R,M,VL,HL).
split([E|R],M,VL,[E|HL]) :-
E@>M, split(R,M,VL,HL).

%%%%% (2.3)

% Aus dem Skript.
% tree2list(+Baum,?Liste)
tree2list(end,[ ]).
tree2list(t(E,VB,HB),L) :-
tree2list(VB,VL),
tree2list(HB,HL),
append(VL,[E|HL],L).

% Ermittelt die an ein Element gebundene Information.
% Gibt False zurueck, wenn das Element nicht in der Liste enthalten ist, oder zu dem Element keine Informationen existieren.
% getinfo(+Element,+Baum,?Information)
getinfo(E,B,I):-
        tree2list(B,L), % Wandelt Baum in Liste um.
        information(E,L,I). % Ermittelt die Information.
% Hilfspraedikat.
% information(+Element,+Liste,?Information)
information(E,[w(E,I)|_],I).
information(_,[],I):- compound(I). % Generiert ein False. Wir wussten nicht, wie man dies sonst implementieren koennte. 
information(E,[w(X,_)|RL],I):-
        compound(w(X,_)),
        E =\= X,
        information(E,RL,I).
information(E,[X|RL],I):- % Ueberspringt "normale" Elemente der Liste, also jene, die informationslos sind.
        not(compound(X)),
        information(E,RL,I).
        
%%%%%%%%%%%%%%
% Aufgabe 4.1
%%%%%%%%%%%%%%

% ham_eqlength(?List1,?List2,?Distanz), nicht völlig unterspezifiziert

ham_eqlength([],[],0).
ham_eqlength(A,B,D) :- A = [AE|A1], B = [BE|B1], AE = BE, ham_eqlength(A1,B1,D).
ham_eqlength(A,B,D) :- A = [AE|A1], B = [BE|B1], AE @< BE, ham_eqlength(A1,B1,D1), D is D1+1.
ham_eqlength(A,B,D) :- A = [AE|A1], B = [BE|B1], AE @> BE, ham_eqlength(A1,B1,D1), D is D1+1.

%%%%%%%%%%%%%%
% Aufgabe 4.2
%%%%%%%%%%%%%%

% ham(+List1,+List2,?Distanz)

ham([],[],0).
ham([],B,D) :- length(B,D).
ham(A,[],D) :- length(A,D).
ham(A,B,D) :- A = [AE|A1], B = [BE|B1], AE = BE, ham(A1,B1,D).
ham(A,B,D) :- A = [AE|A1], B = [BE|B1], AE @< BE, ham(A1,B1,D1), D is D1+1.
ham(A,B,D) :- A = [AE|A1], B = [BE|B1], AE @> BE, ham(A1,B1,D1), D is D1+1.

%%%%%%%%%%%%%%
% Aufgabe 4.3
%%%%%%%%%%%%%%

% ham_list(+List1,+List2,?Distanz,?Zuordnung)

ham_list([],[],0,[]).
ham_list([],[BE|B1],D,L) :- L = [[*,BE]|L1], ham_list([],B1,D1,L1), D is D1+1.
ham_list([AE|A1],[],D,L) :- L = [[AE,*]|L1], ham_list(A1,[],D1,L1), D is D1+1.
ham_list(A,B,D,L) :- A = [AE|A1], B = [BE|B1], AE = BE, L = [[AE,BE]|L1], ham_list(A1,B1,D,L1).
ham_list(A,B,D,L) :- A = [AE|A1], B = [BE|B1], AE @< BE, L = [[AE,BE]|L1], ham_list(A1,B1,D1,L1), D is D1+1.
ham_list(A,B,D,L) :- A = [AE|A1], B = [BE|B1], AE @> BE, L = [[AE,BE]|L1], ham_list(A1,B1,D1,L1), D is D1+1.

%%%%%%%%%%%%%%
% Aufgabe 4.4
%%%%%%%%%%%%%%

% alignment(+List1,+List2,?Distanz,?Zuordnung)

alignment([],[],0,[]).
alignment([],[BE|B1],D,L) :- L = [[*,BE]|L1], alignment([],B1,D1,L1), D is D1+1.
alignment([AE|A1],[],D,L) :- L = [[AE,*]|L1], alignment(A1,[],D1,L1), D is D1+1.
alignment(A,B,D,L) :- A = [AE|A1], B = [BE|B1], AE = BE, L = [[AE,BE]|L1], alignment(A1,B1,D,L1).
alignment(A,B,D,L) :- A = [AE|A1], B = [BE|B1], AE @< BE, L = [[AE,BE]|L1], alignment(A1,B1,D1,L1), D is D1+1.
alignment(A,B,D,L) :- A = [AE|_], B = [BE|B1], AE @< BE, L = [[*,BE]|L1], alignment(A,B1,D1,L1), D is D1+1.
alignment(A,B,D,L) :- A = [AE|A1], B = [BE|_], AE @< BE, L = [[AE,*]|L1], alignment(A1,B,D1,L1), D is D1+1.
alignment(A,B,D,L) :- A = [AE|A1], B = [BE|B1], AE @> BE, L = [[AE,BE]|L1], alignment(A1,B1,D1,L1), D is D1+1.
alignment(A,B,D,L) :- A = [AE|_], B = [BE|B1], AE @> BE, L = [[*,BE]|L1], alignment(A,B1,D1,L1), D is D1+1.
alignment(A,B,D,L) :- A = [AE|A1], B = [BE|_], AE @> BE, L = [[AE,*]|L1], alignment(A1,B,D1,L1), D is D1+1.

%%%%%%%%%%%%%%
% Aufgabe 4.5
%%%%%%%%%%%%%%

% levenstein(+Liste1,+Liste2,?Levenshtein_Distanz)

levenstein(L1,L2,LDistanz) :-
    findall(Distanz,alignment(L1,L2,Distanz,_),Distanzen),
    min_list(Distanzen,LDistanz).        
