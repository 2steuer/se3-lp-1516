dynamic rule/2.
% rule(+Pattern,+Response)

rule([[ich,habe],Menge,Art,[gegessen]],[[warum,hast,du],Menge,Art,[gegessen,'?']]).						    					  
                      
% Eine Liste, die ueber die Konsole eingegeben wird, ruft das folgende Praedikat auf.	 
[X]:- workit(X).
[X1|X]:- workit([X1|X]).	 
workit(X):- rule(Y,_), 
			checkpattern(Y,X,[],Y2),    % baut das instanziierte Pattern
		    reverse(Y2,Y3),          
			rule(Y3,Z),                 % Holt das zugehoerige Response
			write(Z),!.                 % Schreibt das Response auf die Konsole
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
											reverse(K,K1),
                                            checkpattern([A2|A],B,[K1|C],D).
											
checkpattern([[A1|A2]|A],[A1|B],C,D):- checkpattern([A2|A],B,[[A1]|C],D).

% Case: Im Pattern ist eine leere Liste entstanden oder
% es gibt im Userpattern im Kopf der Liste kein entsprechendes Gegenstueck.

checkpattern([[]|A],B,C,D):- checkpattern(A,B,C,D).	
											
checkpattern([A1|A],[B1|B],C,D):- A1 \== B1, 
								  checkpattern([A1|A],B,C,D).
% Fuer das Backtracking.								  
checkpattern([A1|A],[_|B],C,D):- checkpattern([A1|A],B,C,D).							  
								 						  


