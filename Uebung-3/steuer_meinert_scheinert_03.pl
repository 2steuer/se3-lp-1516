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





