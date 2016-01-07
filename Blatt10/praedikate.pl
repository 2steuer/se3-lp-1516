
:- dynamic energy_time_series/4.

convertJSON(File):- 	use_module(library(http/json)),
							open(File,read,Input),
							json_read(Input,JSON),
							handleJSON(JSON).
				 
handleJSON([]).
handleJSON([A1|A]):- makeJSON(A1), handleJSON(A).

makeJSON(json([key=[json([_,Type,_,_])],_,_,_,values=[[Starttime|A]|B]])):- valuemaker([[Starttime|A]|B],[],Values),
																			assert(energy_time_series(Type,Starttime,3600,Values)).
																			
makeJSON(json([key=[json([_,Type,_,_])],_,_,values=[[Starttime|A]|B]])):- valuemaker([[Starttime|A]|B],[],Values),
																			assert(energy_time_series(Type,Starttime,3600,Values)).

makeJSON(json([key=[json([_,Type,_,_])],_,values=[[Starttime|A]|B]])):- valuemaker([[Starttime|A]|B],[],Values),
																			assert(energy_time_series(Type,Starttime,3600,Values)).

																			
valuemaker([],A,B):- reverse(A,B).
valuemaker([[_|A2]|A],B,C):- valuemaker(A,[A2|B],C).