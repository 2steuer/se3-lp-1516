%%%%%%%%%%%%%%%%%
%   Aufgabe 1   %
%%%%%%%%%%%%%%%%%
% praedikate in praedikate.pl

% 1.1
% Das Regelformat wurde wie vorgeschlagen definiert und implementiert.

% 1.2 und 1.3
% Realisiert durch das workit-praedikat, das bei Eingabe von Listen auf den Plan tritt.
% Dabei wird die Eingabeliste mit jedem Pattern aus den definierten Regeln durch das checkpattern-praedikat 
% verglichen und parallel das instanziierte Pattern aufgebaut. Bei Erfolg wird dieses weitergegeben, geordnet,
% das zugehoerige response geholt, welches wiederum durch eine Vielzahl von uns definierten Praedikaten optisch
% aufbereitet und schliesslich auf die Konsole geschrieben wird(Klammern entfernen, Liste in String umwandeln).

% 1.4
% Realisiert durch den Cut im workit-praedikat.
% Beispielsweise gibt es zwei Regeln, die eine Eingabe der Form "[ich,bin,Name]" behandeln koennen.
% Bei Abfrage im Programm erhalten wir:
%	?- [ich,bin,markus].
%	schoen dich kennen zu lernen , markus , mein name ist botty !
%	true.
% Es wird also nur ein response ausgegeben.

% 1.8
% Das Regel-Werk ist ziemlich abgespeckt,trotzdem hier ein Versuch...
% ANLEITUNG:
% 1) Starten Sie die Datei praedikate.pl
% 2) geben Sie in der Konsole eine Anfrage mittels Listenrepresentation ein.
% Beispiel: "Ich bin Jürgen" --> [ich,bin,juergen].
% 3) Der Chat-Bot liefert Ihnen eine Antwort, sofern er mit Ihrer Anfrage umgehen kann, bzw. eine Antwort weiss.

% Beispieldialog:
%	1 ?- [hallo,du,!].
%	guten tag !
%	true.
%
%	2 ?- [ich,bin,stefan,und,du,?].
%	schoen dich kennen zu lernen , stefan , mein name ist botty !
%	true.
%
%	3 ?- [wie,geht,es,dir,nach,weihnachten,?].
%	mir geht es gut und dir ?
%	true.
%
%	4 ?- [ich,fuehle,mich,miserabel].
%	warum fuehlst du dich miserabel ?
%	true.
%
%	5 ?- [ich,habe,8,bananen,gegessen].
%	warum hast du 8 bananen gegessen ?
%	true.
%
%	6 ?- [meine,mutter,meinte,die,muessen,noch,weg,bevor,sie,schlecht,werden].
%	erzaehle mir von deiner mutter .
%	true.
%
%	7 ?- [naja,sie,ist,mit,abstand,die,strengste,in,meiner,familie].
%	interessant ! erzaehle mir von deiner familie .
%	true.
%
%	8 ?- [uff,das,wuerde,den,rahmen,sprengen,vielleicht,ein,anderes,mal,!,bye].
%	tschuess !
%	true.


% 1.9
% Wurde insofern versucht umzusetzen, indem die Eingabe nur noch EINE Liste erfordert (keine Verschachtelungen)
% und die Ausgabe gaenzlich ohne Liste daher kommt, sondern leserlich als String praesentiert wird.