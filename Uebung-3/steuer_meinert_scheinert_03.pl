% Blatt 3

% Merlin Steuer (6415125)
% Dominik Scheinert (6680325)
% Colin Maier (6701950)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Aufgabe 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Syntax: Die Syntax einer (Programmier)Sprache beschreibt mittels eines Systems von Regeln, welche Zeichenfolgen und Konstruktionen zulässig sind.
Semantik: Die Semantik einer Sprache beschreibt, wie die zulässigen Zeichenfolgen interpretiert werden. Denotationell geschieht dies mittels
Zustandsübergangsfunktionen, operational mittels Zustandstransformationen.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Aufgabe 2.1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
?- assert((name_schlüssel_file(A, B) :- file(B,_,A,_,_,_))).
true.

?- name_schlüssel_dir(X,7).
X = quartieranfrage.

?- name_schlüssel_file(paris,X).
X = 4 ;
X = 13.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Aufgabe 2.2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

?- assert((name_schlüssel_dir(A, B) :- directory(B,A,_,_,_))).
true.

?- name_schlüssel_dir(X,7).
X = kinder.

?- name_schlüssel_dir(urlaub,X).
X = 5 ;
X = 10.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Aufgabe 2.3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

?- assert((name_dirschlüssel_file(A, B) :- file(_,B,A,_,_,_))).
true.

?- assert((filename_dirname_dirschlüssel(A, B, C) :- name_dirschlüssel_file(A, C), name_schlüssel_dir(B, C))).
true.

?- filename_dirname_dirschlüssel(paris, X, Y).          
X = pop,
Y = 9 ;
X = urlaub,
Y = 5.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Aufgabe 2.4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

?- assert((name_rname_rschlüssel(A, B, C) :- directory(_,A,C,_,_), directory(C,B,_,_,_))).
true.

?- name_rname_rschlüssel(urlaub, X, Y).
X = bilder,
Y = 2 ;
X = dokumente,
Y = 4.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Aufgabe 3.1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

?- assert((namenliste_von_dir(DIRID, Ergebnis):- findall(B,file(_,DIRID,B,_,_,_),Ergebnis))).
true.

?- namenliste_von_dir(9,Ergebnis).
Ergebnis = [in_the_summertime, i_am_so_romantic_tonight, ich_und_du_fuer_immer, paris].

?- namenliste_von_dir(DIR,Ergebnis).
Ergebnis = [in_the_summertime, i_am_so_romantic_tonight, ich_und_du_fuer_immer, paris, quartieranfrage, paris, dijon, die_bruecke_von_avignon, polterabend|...].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Aufgabe 3.2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

?- assert((dirliste_von_dir(DIRID, Ergebnis):- findall(B,directory(_,B,DIRID,_,_), Ergebnis))).
true.

?- dirliste_von_dir(1,Ergebnis).
Ergebnis = [bilder, musik, dokumente].

?- dirliste_von_dir(DIR,Ergebnis).
Ergebnis = [root, bilder, musik, dokumente, urlaub, hochzeit, kinder, klassik, pop|...].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Aufgabe 3.3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

?- assert((fileanzahl_von_dir(DIRID,Ergebnis):- length(Liste,Ergebnis), namenliste_von_dir(DIRID,Liste))).
true.

?- fileanzahl_von_dir(9,Anzahl).
Anzahl = 4 

?- fileanzahl_von_dir(DIR,Anzahl).
Anzahl = 14 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Aufgabe 4.1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

?- assert((dir_existiert(DirID):- directory(DirID,_,_,_,_))).
true.

?- dir_existiert(1).
true.

?- dir_existiert(13).
false.


?- assert((changeDateHelper(DirID,NeuesDatum):- dir_existiert(DirID), retract((directory(DirID,N,P,D,_))), assert((directory(DirID,N,P,D,date(NeuesDatum)))))).
true.

?- assert((aendereDatum(DirID,NeuesDatum,Status) :- changeDateHelper(DirID,NeuesDatum), Status = transaktion_erfolgreich)).
true.

?- listing(directory/5).
:- dynamic directory/5.

directory(1, root, 0, date(2007, 5, 2), date(2007, 5, 2)).
directory(2, bilder, 1, date(2007, 5, 2), date(2009, 11, 2)).
directory(3, musik, 1, date(2007, 5, 2), date(2009, 10, 4)).
directory(4, dokumente, 1, date(2007, 5, 2), date(2009, 11, 5)).
directory(5, urlaub, 2, date(2008, 6, 22), date(2009, 8, 15)).
directory(6, hochzeit, 2, date(2008, 1, 27), date(2008, 1, 31)).
directory(7, kinder, 2, date(2007, 5, 2), date(2009, 9, 5)).
directory(8, klassik, 3, date(2007, 5, 2), date(2007, 5, 2)).
directory(9, pop, 3, date(2007, 5, 2), date(2009, 11, 5)).
directory(10, urlaub, 4, date(2008, 5, 23), date(2008, 11, 1)).
directory(11, hochzeit, 4, date(2007, 12, 4), date(2008, 1, 25)).
directory(12, scheidung, 4, date(2009, 9, 2), date(2009, 11, 5)).

true.

?- aendereDatum(12,(2015,11,11),Status).
Status = transaktion_erfolgreich.

?- listing(directory/5).
:- dynamic directory/5.

directory(1, root, 0, date(2007, 5, 2), date(2007, 5, 2)).
directory(2, bilder, 1, date(2007, 5, 2), date(2009, 11, 2)).
directory(3, musik, 1, date(2007, 5, 2), date(2009, 10, 4)).
directory(4, dokumente, 1, date(2007, 5, 2), date(2009, 11, 5)).
directory(5, urlaub, 2, date(2008, 6, 22), date(2009, 8, 15)).
directory(6, hochzeit, 2, date(2008, 1, 27), date(2008, 1, 31)).
directory(7, kinder, 2, date(2007, 5, 2), date(2009, 9, 5)).
directory(8, klassik, 3, date(2007, 5, 2), date(2007, 5, 2)).
directory(9, pop, 3, date(2007, 5, 2), date(2009, 11, 5)).
directory(10, urlaub, 4, date(2008, 5, 23), date(2008, 11, 1)).
directory(11, hochzeit, 4, date(2007, 12, 4), date(2008, 1, 25)).
directory(12, scheidung, 4, date(2009, 9, 2), date((2015, 11, 11))).

true.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Aufgabe 4.2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


