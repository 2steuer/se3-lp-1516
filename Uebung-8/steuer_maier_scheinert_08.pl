
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Aufgabe 2 %%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% (2.1) %%%
Wir entscheiden uns für die Variante mit den orthografischen Schlüsseln.

%%% (2.2) %%%
Kontextfreie Grammatik:

Sei die Menge der Nichtterminale {Buchstabenbaum, Unterbaum, Schliessel, Endmarkierung, Nutzdaten}
Sei die Menge der Terminale {[, ], ',', *, 'Lautsymbol-Liste'}
Bedeute { xy } "xy kann beliebig oft wiederholt werden".

Buchstabenbaum		-> [ {Unterbaum} ] 
Unterbaum			-> { [  Schluessel, {Unterbaum} ] } | [Endmarkierung, Nutzdaten]
Schluessel			-> a-zA-Z0-9
Endmarkierung		-> *
Nutzdaten			-> 'Lautsymbol-Liste'