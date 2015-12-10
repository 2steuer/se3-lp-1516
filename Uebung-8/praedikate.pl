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