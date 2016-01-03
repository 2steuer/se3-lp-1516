dynamic rule/2.
% rule(+Pattern,+Response)

% Begruessung
rule([hallo],[guten,tag,'!']).
rule([guten,morgen],[guten,tag,'!']).
rule([guten,abend],[guten,tag,'!']).
rule([moin],[guten,tag,'!']).
rule([bye],[tschuess,'!']).
rule([tschuess],[tschuess,'!']).
rule([auf,wiedersehen],[tschuess,'!']).
rule([bis,dann],[tschuess,'!']).

% Vorstellung
rule([[ich,bin],Name],[[schoen,dich,kennen,zu,lernen,','],Name,[',',mein,name,ist,botty,'!']]).
rule([[ich,bin],Name],[Name,['?',das,ist,aber,ein,haesslicher,name]]).

% Floskeln etc
rule([wie,geht,es,dir],[mir,geht,es,gut,und,dir,'?']).
rule([[ich,fuehle,mich],Gefuehl,[heute]],[[warum,fuehlst,du,dich],Gefuehl,['?']]).	
rule([[ich,fuehle,mich],Gefuehl],[[warum,fuehlst,du,dich],Gefuehl,['?']]).	
rule([[ich,habe],Menge,Art,[gegessen]],[[warum,hast,du],Menge,Art,[gegessen,'?']]).	
rule([mutter],[erzaehle,mir,von,deiner,mutter,'.']).	
rule([familie],[interessant,'!',erzaehle,mir,von,deiner,familie,'.']).			    					  
                      				  

% Eine Liste, die ueber die Konsole eingegeben wird, ruft das folgende Praedikat auf.	 
[X]:- workit(X).
[X1|X]:- workit([X1|X]).	 
workit(X):- rule(Y,_), 
			checkpattern(Y,X,[],Y2),    % baut das instanziierte Pattern
		    reverse(Y2,Y3), 
			rightorder(Y3,[],Y4),	    % bringt die Liste in die richtige Reihenfolge
			rule(Y4,Z), 				% Holt das zugehoerige Response
		    reducelist(Z,[],Z1),        % Reduziert eventuell verschachtelte Listen zu einer.
			reverse(Z1,Z2),
			stringlist(Z3,Z2),          % Macht aus der Liste einen String.
			write(Z3),!.                 % Schreibt das Response auf die Konsole im Stringformat.
			% Durch den Cut beenden wir die Suche nach der ersten erfolgreich angewandten Regel

% checkpattern /4.
% checkpattern(Rulepattern,Usereingabe,Start,InstanziiertesPattern)
% Prueft ein Regelpattern und ein Userpattern, baut nebenbei das instanziierte Pattern auf, und gibt 
% bei erfolgreichem und vollstaendigen Abgleich das instanziierte Pattern zurueck.
checkpattern([],[_],A,A).  % Rekursionsschluss
checkpattern([],[_|_],A,A).  % Rekursionsschluss
checkpattern([],[],A,A). % Rekursionsschluss

% Case: A1 ist keine innere Liste
checkpattern([A1|A],[A1|B],C,D):- checkpattern(A,B,[A1|C],D).

% Case: Der Listenkopf vom Regelpattern ist eine Liste
checkpattern([[A1|A2]|A],[A1|B],[C1|C],D):- is_list(C1),
											K = [A1|C1],
                                            checkpattern([A2|A],B,[K|C],D).
											
checkpattern([[A1|A2]|A],[A1|B],C,D):- checkpattern([A2|A],B,[[A1]|C],D).

% Case: Im Pattern ist eine leere Liste entstanden oder
% es gibt im Userpattern im Kopf der Liste kein entsprechendes Gegenstueck.

checkpattern([[]|A],B,C,D):- checkpattern(A,B,C,D).	
											
checkpattern([A1|A],[B1|B],C,D):- A1 \== B1, 
								  checkpattern([A1|A],B,C,D).
% Fuer das Backtracking.								  
checkpattern([A1|A],[_|B],C,D):- checkpattern([A1|A],B,C,D).	

% Wandelt eine Liste in einen String um.
stringlist(String,List):- atomic_list_concat(List,' ',Atom),
						  atom_string(Atom,String).					 			  

% Reduziert eventuell verschachtelte Listen zu einer großen.
reducelist([],A,A).
reducelist([[]|A],B,C):- reducelist(A,B,C).
reducelist([[A1|A2]|A],B,C):- reducelist([A2|A],[A1|B],C).
reducelist([A1|A],B,C):- not(is_list(A1)),
						 reducelist(A,[A1|B],C).	

% bringt die Liste wieder in die richtige Reihenfolge.
rightorder([],A,C):- reverse(A,C). % Rekursionsschluss
rightorder([A1|A],B,C):- is_list(A1), % Ist der Listenkopf wiederum eine Liste, muss diese ebenfalls einmal umgedreht werden.
						 reverse(A1,A2),
						 rightorder(A,[A2|B],C).

rightorder([A1|A],B,C):- not((is_list(A1))),
						 rightorder(A,[A1|B],C).


						 