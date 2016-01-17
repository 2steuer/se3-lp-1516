%% Aufgaben Blatt 11
%% Loesungen von:
%%% Dominik Scheinert
%%% Colin Maier
%%% Merlin Steuer

%%% Alle Praedikatdefinitionen siehe steuer_maier_scheinert_praedikate_11.pl

%%% Aufgabe 1

% Amsel, Drossel, Fink und Star... koennen fliegen:
?- vogel(amsel, X).
% X = kann_fliegen.

?- vogel(drossel, X).
% X = kann_fliegen.

?- vogel(fink_und_star, X).
% X = kann_fliegen.

% Pinguin, Strauss und Juergen Vogel aber nicht :-(
?- vogel(pinguin, X).
% X = kann_nicht_fliegen ;
% false.

?- vogel(strauss, X).
% X = kann_nicht_fliegen ;
% false.

?- vogel(juergen, X).
% X = kann_nicht_fliegen ;
% false.

% Wir nehmen an, alle nicht fliegenden Voegel zu kennen,
% nehmen außerdem an, dass wir, wenn wir einen Vogel nehmen, welcher nicht nicht fliegen kann (doppelt verneint),
% Dieser fliegen kann.
% Dies ist hier allerdings nicht mit einem cut (!) implementiert, sondern mit einer Abfrage im default-Praedikat,
% ob es einen Eintrag fuer den Vogel gibt, dass dieser nicht fliegen kann. Mit cut waere wohl effizienter.


%%% Aufgabe 2

%% (2.1)

% Test mit Pilzname:
?- ratgeber(steinpilz, Merkmale, Essbarkeit).
% Merkmale = [roehren],
% Essbarkeit = essbar.

% Test mit Merkmalliste, welche auf mehrere Pilze in der Datenbank zutrifft:
?- ratgeber(Pilz, [braune_lamellen], Essbarkeit).
% Pilz = champignon,
% Essbarkeit = geniessbar ;
% Pilz = giftchampignon,
% Essbarkeit = giftig ;
% Pilz = karbolchampignon,
% Essbarkeit = ungeniessbar ;
% false.

% Test Mit Merkmalliste, welche auf einen Pilz eindeutig zutrifft:
?- ratgeber(Pilz, [roehren], Essbarkeit).
% Pilz = steinpilz,
% Essbarkeit = essbar.
% Wuerde man die Eigenschaften eines jeden Pilzes erweitern, wuerde dieser Fall natuerlich viel seltener eintreffen.

% Unbekannte Eigenschaftsliste:
?- ratgeber(Pilz, [roehren, am_baum, roter_stiel], Essbarkeit).
% Pilz = unbekannt,
% Essbarkeit = giftig.

% Hier ist die Regel-Reihenfolge wichtig, waere die Regel (roehren, am_baum) -> ungeniessbar oben gestanden,
% So waere der Pilz als ungiftig, aber ungeniessbar gekennzeichnet worden.