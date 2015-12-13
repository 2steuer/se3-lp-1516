<<<<<<< HEAD
%%% 1.1 Münzautomat %%%
darstellung([A,B,C,D,E,F,G,H],Darstellung):- 
                            Darstellung = [eincent(A),zweicent(B),fuenfcent(C),zehncent(D),zwanzigcent(E),fuenfzigcent(F),eineuro(G),zweieuro(H)].


changeback(Geld,Zerlegung):- wechselgeld(Geld,[0,0,0,0,0,0,0,0],Zerlegung).
   
wechselgeld(0,Liste,Zerlegung):- darstellung(Liste,Zerlegung). % Abbruchbedingung.

wechselgeld(Geld,[A,B,C,D,E,F,G,H],Zerlegung):- Geld >= 200, 
                                               NewGeld is Geld - 200, 
                                               H1 is H + 1,
                                               wechselgeld(NewGeld,[A,B,C,D,E,F,G,H1],Zerlegung).
wechselgeld(Geld,[A,B,C,D,E,F,G,H],Zerlegung):- Geld >= 100, 
                                               NewGeld is Geld - 100, 
                                               G1 is G + 1,
                                               wechselgeld(NewGeld,[A,B,C,D,E,F,G1,H],Zerlegung).
wechselgeld(Geld,[A,B,C,D,E,F,G,H],Zerlegung):- Geld >= 50, 
                                               NewGeld is Geld - 50, 
                                               F1 is F + 1,
                                               wechselgeld(NewGeld,[A,B,C,D,E,F1,G,H],Zerlegung).   
wechselgeld(Geld,[A,B,C,D,E,F,G,H],Zerlegung):- Geld >= 20, 
                                               NewGeld is Geld - 20, 
                                               E1 is E + 1,
                                               wechselgeld(NewGeld,[A,B,C,D,E1,F,G,H],Zerlegung).     
wechselgeld(Geld,[A,B,C,D,E,F,G,H],Zerlegung):- Geld >= 10, 
                                               NewGeld is Geld - 10, 
                                               D1 is D + 1,
                                               wechselgeld(NewGeld,[A,B,C,D1,E,F,G,H],Zerlegung). 
wechselgeld(Geld,[A,B,C,D,E,F,G,H],Zerlegung):- Geld >= 5, 
                                               NewGeld is Geld - 5, 
                                               C1 is C + 1,
                                               wechselgeld(NewGeld,[A,B,C1,D,E,F,G,H],Zerlegung).    
wechselgeld(Geld,[A,B,C,D,E,F,G,H],Zerlegung):- Geld >= 2,
                                               NewGeld is Geld - 2,
                                               B1 is B + 1,
                                               wechselgeld(NewGeld,[A,B1,C,D,E,F,G,H],Zerlegung).  
wechselgeld(Geld,[A,B,C,D,E,F,G,H],Zerlegung):- Geld >= 1,
                                               NewGeld is Geld - 1,
                                               A1 is A + 1,
                                               wechselgeld(NewGeld,[A1,B,C,D,E,F,G,H],Zerlegung).                                              

%%% 1.2 Münzautomat %%%

%%% 1.3 Münzautomat %%%
bestchangeback(Geld,Zerlegung):- changeback(Geld,Zerlegung),!.
=======
%%% Aufgabe 1 %%%

% changeback(Geld, Zerlegung, Muenzsystem)

changeback(G,Z,M) :- sort(M,A), reverse(A,B), wechselgeld(G,[0],Z,B).

wechselgeld(0,L,Z,[_]) :- reverse(L,Z).
wechselgeld(0,L,Z,[_|M]) :- wechselgeld(0,[0|L],Z,M).
wechselgeld(G,[L1|L],Z,[M1|M]) :- G >= M1, G1 is G - M1, L2 is L1 + 1, 
	wechselgeld(G1,[L2|L],Z,[M1|M]).
wechselgeld(G,L,Z,[_|M]) :- G > 0, wechselgeld(G,[0|L],Z,M).

% opt_changeback(Geld, Zerlegung, Muenzsystem)

opt_changeback(G,Z,M) :- changeback(G,Z,M),!. 

% kasse(+Geldbetrag, +Muenzsystem, +Vorher, ?Wechselgeld, ?Nachher)

kasse(G,M,V,W,N) :- changeback(G,W,M), vorhanden(W,V,N).

vorhanden([],[],[]).
vorhanden([W1|W],[V1|V],[V2|N]) :- V1 >= W1, V2 is V1 - W1, vorhanden(W,V,N).

% opt_kasse(+Geldbetrag, +Muenzsystem, +Vorher, ?Wechselgeld, ?Nachher)

opt_kasse(G,M,V,W,N) :- kasse(G,M,V,W,N), !.

% warenautomat(+Muenzen, +Preis, +Muenzsystem, +Vorher, ?Wechselgeld, ?Nachher)

warenautomat(M,P,MS,V,W,N) :- sort(MS,X), reverse(X,Y), summe(M,Y,A), B is A - P, B >= 0, opt_kasse(B,Y,V,W,N).

summe([],[],0).
summe([M1|M],[MS1|MS],S) :- summe(M,MS,S1) , S is S1 + M1 * MS1.


% kaufen(+Muenzen, +Preis, ?Wechselgeld, -Nachher)

kaufen(M,P,W,N) :- reverse(M,A), my_ms(MS), kassenstand(V), warenautomat(A,P,MS,V,W,N), retract(kassenstand(V)), assert(kassenstand(N)).

my_ms([1,2,5,10,20,50,100,200]). %Eurosystem
:- dynamic kassenstand/1.
kassenstand([10,10,10,10,10,10,10,10]).
>>>>>>> origin/master

%%% 2.3 word2trie %%%

% word2trie(+Word, +Payload, ?Trie)
% Erzeugt aus einer Liste von Buchstaben sowie einem übergebenen Nutzdatenwert
% einen Elementarbaum wie im Aufgabenblatt beschrieben.
% word2trie/3 fungiert als wrapper um word2subtrie, um die Eigenschaft eines Elementarbaums
% zu gewährleisten, d.h. eine Ein-Elementige Liste zurück zu geben.

word2trie(Word, Payload, Trie) :-
	word2subtrie(Word, Payload, IntTrie),
	Trie = [IntTrie].

% word2subtrie(+Word, +Payload, ?Subtrie)
% Erzeugt aus einem übergebenen Wort, einem Nutzdatensatz beliebiger Natur einen
% Unter-Buchstabenbaum. * ist als Stop-Zeichen gewählt.

word2subtrie([], Payload, [*, Payload]).
word2subtrie([Letter|Restword], Payload, [Letter|RestTrie]) :- 
			word2subtrie(Restword, Payload, SubTrie),
			RestTrie = [SubTrie].