convertJSON(File):- 	use_module(library(http/json)),
	open(File,read,Input),
	json_read(Input,JSON),
	close(Input),
	open('data.pl',write,Write),
	handleJSON(JSON,Write),
	close(Write),
	[data].

handleJSON([],_).
handleJSON([A1|A],W):- makeJSON(A1,W), handleJSON(A,W).

makeJSON(json([key=[json([_,Type,_,_])],_,_,_,values=[[Starttime|A]|B]]),W):- 
	mJ(Type,Starttime,A,B,W).
makeJSON(json([key=[json([_,de= Type,_,_])],_,_,values=[[Starttime|A]|B]]),W):- 
	mJ(Type,Starttime,A,B,W).
makeJSON(json([key=[json([_,de= Type,_,_])],_,values=[[Starttime|A]|B]]),W):-
	mJ(Type,Starttime,A,B,W).

mJ(Type,Starttime,A,B,Write):-
	valuemaker([[Starttime|A]|B],[],Values),
	write_canonical(Write,energy_time_series(Type,Starttime,3600,Values)),
	writeln(Write,'.').
																			
valuemaker([],A,B):- reverse(A,B).
valuemaker([[_,A2]|A],B,C):- valuemaker(A,[A2|B],C).

:- dynamic energy_time_series/4.
:- convertJSON('month_2014_01.json').


gran_changer(Type, G, F) :- 
	energy_time_series(Type, Starttime,T1,V1),
	F = energy_time_series(Type, Starttime,G,V2),
	A is G/T1,
	A >= 1,
	integer(A),
	calc_val(V1,A,[],A,0,V2),!.
	

calc_val(A,0,V2a,B,X,V2) :-
	calc_val(A,B,[X|V2a],B,0,V2).
calc_val([],_,V2a,_,_,V2) :- reverse(V2a,V2).
calc_val([V1|V],A,V2a,B,X,V2):-
	A > 0,
	A1 is A-1,
	X1 is V1+X,
	calc_val(V,A1,V2a,B,X1,V2).



transp([A1|A],B2):-
	t1(A1,[],B),
	transp2(A,B,B1),
	reverse_lists(B1,B2,[]).

transp2([],B,B).
transp2([A1|A],B,B1) :-
	t2(A1,B,B2,[]),
	transp2(A,B2,B1).

t1([],B,B1) :- reverse(B,B1).
t1([A1|A],B,B1) :- t1(A,[[A1]|B],B1).

t2([],_,B1,B) :- B = B1.
t2([A1|A],[B1|B],B2,B3) :- is_list(B1), t2(A,B,B2,[[A1|B1]|B3]).


reverse_lists([],B,B).
reverse_lists([A1|A],B,C) :- reverse(A1,A2), reverse_lists(A,B,[A2|C]).


total :- findall([Art,Values],energy_time_series(Art, 1388530800000,3600, Values),



















