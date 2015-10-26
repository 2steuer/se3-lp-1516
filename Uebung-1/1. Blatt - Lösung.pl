	%1.1 AUFGABE

?- consult('/Users/colinmaier/Downloads/familie.pl').                                                                                                                             
true.

	%1.2 AUFGABE

?- listing.                                          

:- dynamic mutter_von/2.

mutter_von(marie, hans).
mutter_von(marie, helga).
mutter_von(julia, otto).
mutter_von(barbara, klaus).
mutter_von(barbara, andrea).
mutter_von(charlotte, barbara).
mutter_von(charlotte, magdalena).

:- dynamic expand_answer/2.
:- multifile expand_answer/2.

expand_answer(A, B) :-
	toplevel_variables:expand_answer(A, B).

:- dynamic vater_von/2.

vater_von(otto, hans).
vater_von(otto, helga).
vater_von(gerd, otto).
vater_von(johannes, klaus).
vater_von(johannes, andrea).
vater_von(walter, barbara).
vater_von(walter, magdalena).

:- dynamic expand_query/4.
:- multifile expand_query/4.

expand_query(A, B, C, D) :-
	toplevel_variables:expand_query(A, B, C, D).

:- multifile prolog_list_goal/1.


:- dynamic prolog_event_hook/1.
:- multifile prolog_event_hook/1.


:- dynamic exception/3.
:- multifile exception/3.


:- dynamic file_search_path/2.
:- multifile file_search_path/2.

file_search_path(library, A) :-
	library_directory(A).
file_search_path(swi, A) :-
	system:current_prolog_flag(home, A).
file_search_path(foreign, swi(B)) :-
    system:
    (   current_prolog_flag(arch, A),
	atom_concat('lib/', A, B)
    ).
file_search_path(foreign, swi(A)) :-
    system:
    (   (   current_prolog_flag(windows, true)
	->  A=bin
	;   A=lib
	)
    ).
file_search_path(path, C) :-
    system:
    (   getenv('PATH', A),
	(   current_prolog_flag(windows, true)
	->  atomic_list_concat(B, ;, A)
	;   atomic_list_concat(B, :, A)
	),
	'$member'(C, B),
	'$no-null-bytes'(C)
    ).
file_search_path(user_profile, app_preferences('.')).
file_search_path(app_data, A) :-
	'$toplevel':catch(expand_file_name('~/lib/swipl', [A]), _, fail).
file_search_path(app_preferences, A) :-
	'$toplevel':catch(expand_file_name(~, [A]), _, fail).
file_search_path(autoload, library('.')).
file_search_path(pack, app_data(pack)).
file_search_path(pack, swi(pack)).
file_search_path(library, A) :-
	'$pack':pack_dir(_, prolog, A).
file_search_path(foreign, A) :-
	'$pack':pack_dir(_, foreign, A).
file_search_path(pce, A) :-
	link_xpce:pcehome_(A).
file_search_path(library, pce('prolog/lib')).
file_search_path(foreign, pce(B)) :-
    link_xpce:
    (   current_prolog_flag(arch, A),
	atom_concat('lib/', A, B)
    ).

:- thread_local thread_message_hook/3.
:- dynamic thread_message_hook/3.
:- volatile thread_message_hook/3.


:- dynamic portray/1.
:- multifile portray/1.


:- dynamic prolog_file_type/2.
:- multifile prolog_file_type/2.

prolog_file_type(pl, prolog).
prolog_file_type(prolog, prolog).
prolog_file_type(qlf, prolog).
prolog_file_type(qlf, qlf).
prolog_file_type(A, executable) :-
	system:current_prolog_flag(shared_object_extension, A).

:- dynamic prolog_load_file/2.
:- multifile prolog_load_file/2.


:- multifile message_property/2.


:- dynamic library_directory/1.
:- multifile library_directory/1.

library_directory(B) :-
    '$parms':
    (   cached_library_directory(local, A=lib, A),
	B=A
    ).
library_directory(B) :-
    '$parms':
    (   cached_library_directory(user,
				 expand_file_name('~/lib/prolog', [A]),
				 A),
	B=A
    ).
library_directory(B) :-
    '$parms':
    (   cached_library_directory(system,
				 absolute_file_name(swi(library), A),
				 A),
	B=A
    ).
library_directory(B) :-
    '$parms':
    (   cached_library_directory(clp,
				 absolute_file_name(swi('library/clp'), A),
				 A),
	B=A
    ).

:- dynamic resource/3.
:- multifile resource/3.


:- dynamic message_hook/3.
:- multifile message_hook/3.

true.

?- listing(mutter_von).
:- dynamic mutter_von/2.

mutter_von(marie, hans).
mutter_von(marie, helga).
mutter_von(julia, otto).
mutter_von(barbara, klaus).
mutter_von(barbara, andrea).
mutter_von(charlotte, barbara).
mutter_von(charlotte, magdalena).

true.

?- listing(vater_von). 
:- dynamic vater_von/2.

vater_von(otto, hans).
vater_von(otto, helga).
vater_von(gerd, otto).
vater_von(johannes, klaus).
vater_von(johannes, andrea).
vater_von(walter, barbara).
vater_von(walter, magdalena).

true.

	%1.3 AUFGABE

?- assert(mutter_von(a1, a2)). % Fuegt einen Term als letzten Fakt eines Praedikats ein
true. % assert ist in der Dokumentation als deprecated markiert und es sollte assertz/1 verwendet werden.

?- asserta(mutter_von(b1, b2)). % Fuegt einen Term als ersten Fakt eines Praedikats ein.
true.

?- assertz(mutter_von(c1, c2)). % Fuegt einen Term als letzten Fakt eines Praedikats ein
true.

?- listing(mutter_von).        
:- dynamic mutter_von/2.

mutter_von(b1, b2).
mutter_von(marie, hans).
mutter_von(marie, helga).
mutter_von(julia, otto).
mutter_von(barbara, klaus).
mutter_von(barbara, andrea).
mutter_von(charlotte, barbara).
mutter_von(charlotte, magdalena).
mutter_von(a1, a2).
mutter_von(c1, c2).

true.


	%2.1 AUFGABE

?- vater_von(walter, magdalena).
true.

?- mutter_von(julia, klaus).
false.

?- vater_von(A, helga).
A = otto.

?- mutter_von(A, julia).
false.

?- vater_von(johannes, A).
A = klaus ;
A = andrea.

?- vater_von(Vater, Kind), mutter_von(Mutter, Kind).
Vater = otto,
Kind = hans,
Mutter = marie ;
Vater = otto,
Kind = helga,
Mutter = marie ;
Vater = gerd,
Kind = otto,
Mutter = julia ;
Vater = johannes,
Kind = klaus,
Mutter = barbara ;
Vater = johannes,
Kind = andrea,
Mutter = barbara ;
Vater = walter,
Kind = barbara,
Mutter = charlotte ;
Vater = walter,
Kind = magdalena,
Mutter = charlotte.


?- \+ mutter_von(magdalena, A).
true.

?- \+ mutter_von(marie, A).    
false.

?- \+ \+ mutter_von(marie, A)).    
true.

	%2.2 AUFGABE

?- assert((elternteil_von(X,Y):- vater_von(X,Y))).
true.

?- assert((elternteil_von(X,Y):- mutter_von(X,Y))).       
true.

?- assert((enkelkind_von(X,Y):- elternteil_von(X,A), elternteil_von(A,Y))).
true.

?- enkelkind_von(charlotte, A).
A = klaus ;
A = andrea ;
false.



	%2.3 AUFGABE

?- trace.
true.

[trace]  ?- vater_von(walter, magdalena).     
   Call: (7) vater_von(walter, magdalena) ? creep
   Exit: (7) vater_von(walter, magdalena) ? creep
true.

[trace]  ?- mutter_von(julia, klaus).         
   Call: (7) mutter_von(julia, klaus) ? creep
   Fail: (7) mutter_von(julia, klaus) ? creep
false.

[trace]  ?- vater_von(A, helga).              
   Call: (7) vater_von(_G544, helga) ? creep
   Exit: (7) vater_von(otto, helga) ? creep
A = otto.

[trace]  ?- mutter_von(A, julia).             
   Call: (7) mutter_von(_G544, julia) ? creep
   Fail: (7) mutter_von(_G544, julia) ? creep
false.

[trace]  ?- vater_von(johannes, A).           
   Call: (7) vater_von(johannes, _G545) ? creep
   Exit: (7) vater_von(johannes, klaus) ? creep
A = klaus ;
   Redo: (7) vater_von(johannes, _G545) ? creep
   Exit: (7) vater_von(johannes, andrea) ? creep
A = andrea.

[trace]  ?- vater_von(A, B); mutter_von(A, B).
   Call: (8) vater_von(_G544, _G545) ? creep
   Exit: (8) vater_von(otto, hans) ? creep
A = otto,
B = hans ;
   Redo: (8) vater_von(_G544, _G545) ? creep
   Exit: (8) vater_von(otto, helga) ? creep
A = otto,
B = helga ;
   Redo: (8) vater_von(_G544, _G545) ? creep
   Exit: (8) vater_von(gerd, otto) ? creep
A = gerd,
B = otto ;
   Redo: (8) vater_von(_G544, _G545) ? creep
   Exit: (8) vater_von(johannes, klaus) ? creep
A = johannes,
B = klaus ;
   Redo: (8) vater_von(_G544, _G545) ? creep
   Exit: (8) vater_von(johannes, andrea) ? creep
A = johannes,
B = andrea ;
   Redo: (8) vater_von(_G544, _G545) ? creep
   Exit: (8) vater_von(walter, barbara) ? creep
A = walter,
B = barbara ;
   Redo: (8) vater_von(_G544, _G545) ? creep
   Exit: (8) vater_von(walter, magdalena) ? creep
A = walter,
B = magdalena ;
   Call: (8) mutter_von(_G544, _G545) ? creep
   Exit: (8) mutter_von(b1, b2) ? creep
A = b1,
B = b2 ;
   Redo: (8) mutter_von(_G544, _G545) ? creep
   Exit: (8) mutter_von(marie, hans) ? creep
A = marie,
B = hans ;
   Redo: (8) mutter_von(_G544, _G545) ? creep
   Exit: (8) mutter_von(marie, helga) ? creep
A = marie,
B = helga ;
   Redo: (8) mutter_von(_G544, _G545) ? creep
   Exit: (8) mutter_von(julia, otto) ? creep
A = julia,
B = otto ;
   Redo: (8) mutter_von(_G544, _G545) ? creep
   Exit: (8) mutter_von(barbara, klaus) ? creep
A = barbara,
B = klaus ;
   Redo: (8) mutter_von(_G544, _G545) ? creep
   Exit: (8) mutter_von(barbara, andrea) ? creep
A = barbara,
B = andrea ;
   Redo: (8) mutter_von(_G544, _G545) ? creep
   Exit: (8) mutter_von(charlotte, barbara) ? creep
A = charlotte,
B = barbara ;
   Redo: (8) mutter_von(_G544, _G545) ? creep
   Exit: (8) mutter_von(charlotte, magdalena) ? creep
A = charlotte,
B = magdalena ;
   Redo: (8) mutter_von(_G544, _G545) ? creep
   Exit: (8) mutter_von(a1, a2) ? creep
A = a1,
B = a2 ;
   Redo: (8) mutter_von(_G544, _G545) ? creep
   Exit: (8) mutter_von(c1, c2) ? creep
A = c1,
B = c2.

[trace]  ?- \+ mutter_von(magdalena, A).      
   Call: (8) mutter_von(magdalena, _G545) ? creep
   Fail: (8) mutter_von(magdalena, _G545) ? creep
true.

[trace]  ?- \+ mutter_von(marie, A).          
   Call: (8) mutter_von(marie, _G545) ? creep
   Exit: (8) mutter_von(marie, hans) ? creep
false.

[trace]  ?- not(\+mutter_von(marie, A)).
   Call: (9) mutter_von(marie, _G5075) ? creep
   Exit: (9) mutter_von(marie, hans) ? creep
true.

[trace]  ?- nodebug.
true.