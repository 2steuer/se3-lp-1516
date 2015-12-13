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