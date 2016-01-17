%%%%%%%%%%%%%%%%%%%
% Aufgabe 1
%%%%%%%%%%%%%%%%%%%
% vogel(?Vogel, ?fliegen)
% Gibt für den gegebenen Vogel an, ob dieser fliegen kann.
% Es ist möglich die Voegel abzufragen, die nicht fliegen koennen.
% Jedoch nicht solche, die fliegen koennen.

vogel(pinguin, kann_nicht_fliegen).
vogel(strauss, kann_nicht_fliegen).
vogel(juergen, kann_nicht_fliegen).
vogel(X, kann_fliegen) :- \+ vogel(X, kann_nicht_fliegen).

%%%%%%%%%%%%%%%%%%
% Aufgabe 2
%%%%%%%%%%%%%%%%%%

%% Die Pilze aus der Regelliste... keine Garantie fuer Vollstaendigkeit!
%% Achtung: Aus vom Testen ist abzusehen!
merkmale(steinpilz, [roehren]).
merkmale(maronen, [roehren]).
merkmale(butterpilz, [roehren]).
merkmale(champignon, [braune_lamellen, trockene_oberflaeche]). % Zu Testzwecken die trockene oberflaeche eingefuegt.
merkmale(giftchampignon, [braune_lamellen, gelbe_flecken]).
merkmale(karbolchampignon, [braune_lamellen, stinkt]).
merkmale(fliegenpilz, [lamellen, punkte]).
merkmale(pantherpilz, [lamellen, punkte]).
merkmale(perlpilz, [lamellen, braune_kappe, abwischbare_punkte]).
merkmale(hexenroehrling, [roehren, roter_stiel]).
merkmale(baumpilz, [roehren, am_baum]).
merkmale(leberpilz, [roehren, am_baum, roter_saft]).

%%%%%%%%%%%%%%%%%%%%
%% Aufgabe 2.1
%%%%%%%%%%%%%%%%%%%%
% hat_merkmal(?Objekt, ?Merkmal)
% Gibt true zurück, wenn das gegebene Objekt existiert und das angegebene Merkmal hat.
hat_merkmal(Objekt, Merkmal) :- merkmale(Objekt, Liste), member(Merkmal, Liste).

% member_all(+Elements, +List)
% Gibt true, wenn List alle Elemente der Liste Elements enthaelt.
member_all([Member|MemberList], List) :- member(Member, List), member_all(MemberList, List).
member_all([], _).

% hat_merkmale(?Objekt, +Merkmale)
% Gibt true zurück, wenn das angegebene Objekt alle gegebenen Merkmale besitzt.
% Kann genutzt werden, um alle Objekte mit den gegebenen Merkmalen zu finden (Backtracking),
% jedoch nicht, um alle Merkmale eines Objekts zu finden (hierzu bitte merkmale/2 nutzen).
hat_merkmale(Objekt, Merkmale) :- merkmale(Objekt, MerkmalListe), member_all(Merkmale, MerkmalListe).

% ratgeber(?Pilz, ?Merkmale, -Essbarkeit)
% Erreichnet fuer einen gegebenen Pilz oder eine gegebene Liste von Merkmalen die Essbarkeit oder
% geniessbarkeit eines von Pilzfreunden gefundenen Pilzes.
% Ist eine Merkmalliste uebergeben, so werden alle passenden Pilze inklusive ihrer essbarkeit ausgegeben.
% Trifft die Merkmalliste jedoch auf einen Pilz exakt zu, so wird nur dieser Pilz ausgegeben.
% Dies setzt voraus, dass alle Pilze mit allen ihren Merkmalen oben angegeben waeren, sonst
% fuehrt dieses feature zu oft zu schnellen abbruechen.
% Wird in diesem vollumfaenglichen Nachschlagwerk fuer fungiphile wider erwarten
% kein passender Eintrag gefunden, so wird der Pilz als unbekannt deklariert und anhand bestehender
% Regelwerke die essbarkeit des gefundenen Prachtstueckes geschaetzt.
% Natuerlich widerspricht der Autor dieses Lexikons jeglichen Haftungsanspruechen!

% Damit wir auch einen Pilz direkt auswaehlen koennen
ratgeber(Pilz, Merkmale, Essbarkeit) :- merkmale(Pilz, Merkmale), merkmal_ratgeber(Merkmale, Essbarkeit), !.

ratgeber(Pilz, Merkmale, Essbarkeit) :- 
	hat_merkmale(Pilz, Merkmale), merkmale(Pilz, PilzMerkmale),  merkmal_ratgeber(PilzMerkmale, Essbarkeit).

% Treffen die o.g. Regeln nicht zu, so wird der Pilz als unbekannt deklariert und
% anhand der uebergebenenen Merkmale die essbarkeit abgeschaetzt.
% Die Negierung am Anfang muss leider sein, um zu verhindern, dass dieses Praedikat durch Backtracking auch
% von obigem Praedikat angesprungen wird. Backtracking wollen wir aber oben behalten, um alle moeglichen Pilze auszugeben.
ratgeber(unbekannt, Merkmale, Essbarkeit) :- \+ hat_merkmale(_, Merkmale), merkmal_ratgeber(Merkmale, Essbarkeit).

% merkmal_ratgeber(+Merkmale, -Essbarkeit)
% Gibt fuer eine Liste an Merkmalen zurück, ob der Pilz mit den entsprechenden Eigenschaften essbar
% sein koennte.
% ACHTUNG: Es wird die Positiv-Annahme getroffen, also werden alle Merkmalkombinationen, die das System nicht kennt,
% Als ESSBAR deklariert. Das basiert natuerlich auf der Annahme, dass wir alle giftigen Pilze hier abgebildet haben.
% Mutige Forscher, die dies ausprobieren wollen, senden bitte ihre Ergebnisse (sofern noch moeglich) an
% das NATS-Institut der Uni HH. Andere aendern die Implementation so, dass nicht identifizierte Merkmalkombinationen
% irgendwie gekennzeichnet werden.
merkmal_ratgeber(Merkmale, geniessbar) :- member_all([lamellen, braune_kappe, abwischbare_punkte], Merkmale), !.
merkmal_ratgeber(Merkmale, geniessbar) :- member_all([roehren, am_baum, roter_saft], Merkmale), !.

merkmal_ratgeber(Merkmale, giftig) :- member_all([roehren, roter_stiel], Merkmale), !.
merkmal_ratgeber(Merkmale, ungeniessbar) :- member_all([roehren, am_baum], Merkmale), !.

merkmal_ratgeber(Merkmale, giftig) :- member_all([lamellen, punkte], Merkmale), !.
merkmal_ratgeber(Merkmale, giftig) :- member_all([braune_lamellen, gelbe_flecken], Merkmale), !.
merkmal_ratgeber(Merkmale, ungeniessbar) :- member_all([braune_lamellen, stinkt], Merkmale), !.

merkmal_ratgeber(Merkmale, essbar) :- member(roehren, Merkmale), !.
merkmal_ratgeber(Merkmale, giftig) :- member(lamellen, Merkmale), !.
merkmal_ratgeber(Merkmale, geniessbar) :- member(braune_lamellen, Merkmale), !.

merkmal_ratgeber(_, essbar). % Alle unbekannten Kombinationen sind essbar. No risk, no fun!