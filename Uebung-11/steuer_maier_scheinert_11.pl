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

%%% Aufgabe 3

% Einfache uebersetzungen:

?- translate(X, [er, fing, einen, schmetterling]).
% X = [he, caught, a, butterfly] ;
% false.

?- translate([he, caught, a, butterfly], X).
% X = [er, fing, einen, schmetterling] ;
% X = [er, fing, eine, schmetterling] ;
% false.

?- translate([he, makes, himself, out, of, the, dust], X).
% X = [er, macht, sich, aus, of, dem, staub] ;
% X = [er, macht, sich, aus, of, der, staub] ;
% false.

?- translate(X, [mir, nichts, dir, nichts]).
% X = [me, nothing, you, nothing] ;
% false.

% Idiome:
?- translate(X, [er, ging, schlafen]).
% X = [he, hit, the, sack].

?- translate([he, carries, owls, to, newcastle], X).
% X = [er, traegt, eulen, nach, athen].


% Unbekannte Worte:
?- translate(X, [er, fing, einen, elefanten]).
% X = [he, caught, a, elefanten] ;
% false.

?- translate([he, caught, a, horse], X).
% X = [er, fing, einen, horse] ;
% X = [er, fing, eine, horse] ;
% false.

% Alternative Uebersetzungen schon oben, aber dennoch:
?- translate([the, job], X).
% X = [dem, beruf] ;
% X = [der, beruf] ;
% false.

?- translate(X, [der, beruf]).
% X = [the, job] ;
% X = [the, profession] ;
% false.

% Vollstaendig spezifiziert (Zur Korrektur von Englisch-Klausuren!):
?- translate([the, profession], [der, beruf]).
% true ;
% false.
