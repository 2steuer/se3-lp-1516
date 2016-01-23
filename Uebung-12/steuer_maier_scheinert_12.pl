%%%%%%%%%%%%%%%
%% Aufgabe 1 %%
%%%%%%%%%%%%%%%

% 1.
%(list (car (cdr (quote (1 2 3 4))))(cdr (quote (1 2 3 4))) )
% (car(cdr(quote(1 2 3 4))))
% --> (quote (1 2 3 4))
% --> (1 2 3 4)
% --> '(2 3 4)
% --> 2

% (cdr(quote(1 2 3 4)))
% --> (quote(1 2 3 4))
% --> (1 2 3 4)
% --> '(2 3 4)

% ---> '(2 (2 3 4))

% 2.
% (if (< (car (cdr (quote (5 -3 4 -2)))) (- 2 6)) 0 1)
% (< (car (cdr (quote (5 -3 4 -2)))) (- 2 6))
% --> (quote (5 -3 4 -2))
% --> (5 -3 4 -2)
% --> '( -3 4 -2)
% --> -3
% (- 2 6)
% --> -4

% --> #f

% ---> 1

% 3.
% (cons (cdr (quote (1 2 3 4)))(car (quote (1 2 3 4))) )
% evaluiert zu: '((2 3 4) . 1), denn:
% (cdr '(1 2 3 4)) --> '(2 3 4)
% (car '(1 2 3 4)) --> 1
% die cons-Funktion macht daraus ein Paar: '((2 3 4) . 1)

% 4.
% (map (lambda (x) (if (pair? x) (car x) x))(quote (lambda (x) (if (pair? x) (car x) x))))
% evaluiert zu: '(lambda x if), denn:
% Die Lambda-Funktion wird auf alle Elemente der Liste angewendet,
% schmeisst bei Paaren immer das erste Element in die neue Liste,
% und bei Nicht-Paaren alles.
% lambda --> lambda (weil einzelnes Element)
% (x) --> x (weil einzelnes Element)
% (if (pair? x) (car x) x) --> if (denn es handelt sich um eine Liste, und Listen sind in der Scheme-Repraesentation ebenfalls Paare(geschachtelt))
% die map-Funktion macht daraus eine Liste: '(lambda x if)

% 5.
% (filter (curry > 5)(reverse (quote (1 3 5 7 9))))
% evaluiert zu: '(3 1), denn:
% reverse macht aus der Liste: '(1 3 5 7 9) --> '(9 7 5 3 1)
% filter wendet eine Boolean-Funktion auf die Liste an. Bei #t wird das Element in die neue Liste getan.
% Die curry-Funktion setzt die Bedingung um. für ein Element x aus der Liste muss gelten: 5 > x
% Deshalb erhalten wir die folgende Liste : '(3 1)

% 6.
% (filter (compose positive?(lambda (x) (- x 5)))(quote (1 3 5 7 9)))
% evaluiert zu: '(7 9), denn:
% compose fuegt zwei Funktionen zusammen. Zuerst wird fuer jedes Element der Liste die Lambda-Funktion ausgefuehrt,
% und dann im Anschluss getestet, ob das Element nun immer noch > 0 ist. Nach diesen Bedingungen filtert dann filter.
% Da aber nur die Elemente 7 und 9 groß genug sind, als dass eine Subtraktion von 5 sie immer noch positiv sein laesst,
% erhalten wir durch filter folgende Liste: '(7 9)



%%%%%%%%%%%%%%%
%% Aufgabe 2 %%
%%%%%%%%%%%%%%%

% 1.
% Diese Funktion fuehrt einen Teilmengentest zweier Listen aus. Dies geschieht rekursiv.
% Die Funktion gibt #t aus, wenn die Liste y mindestens alle Elemente von x enthaelt, in der gleichen Reihenfolge.
% Beispiel: (foobar '(1 2) '(1 2 3)) --> #t

% Umsetzung in Prolog:
% foobar(+Liste1,+Liste2)
foobar([],_). % Rekursionsabschluss
foobar([A|X],[A|Y]):- foobar(X,Y).
% Die Prolog-Implementation ist deutlich intuitiver und schneller zu verstehen. 
% Die Scheme-Implementation benoetigt viel mehr einzelne Absicherungen.
% Gemeinsam haben beide die Vorgehensweise:
% Zuerst wird die Abbruchbedingung geprueft (if-Abfrage vs. erste Regel),
% danach wird die Rekursion eingeleitet.

% 2.
% Diese Funktion nimmt eine Liste entgegen und gibt eine redundanzfreie Liste zurueck (keine Duplikate).
% Beispiel: (foo2 '(1 2 2 3)) --> '(1 2 3)

% Umsetzung in Prolog:
% foo2(+Liste,?ReduzierteListe)
foo2([],[]). % Rekursionsabschluss
foo2([A1|A],[A1|B]):- not(member(A1,A)), foo2(A,B),!.
foo2([_|A],B):- foo2(A,B).
% Dieses mal ist die Schmeme-Implementation einfacher.
% Bei Prolog muessen wir explizit verhindern, dass nach weiteren Alternativen mittels Backtracking gesucht wird.

% 3.
% Diese Funktion sammelt alle Elemente einer Liste x, die auch in der Liste y vorkommen.
% Beispiel: (foo3 '(1 2 3 4 5) '(4 5 6 7)) --> '(4 5)

% Umsetzung in Prolog:
% foo3(+Liste1,+Liste2,?Schnitt)
foo3([],_,[]). % Rekursionsabschluss
foo3([A1|A],B,[A1|C]):- member(A1,B), foo3(A,B,C),!.
foo3([_|A],B,C):- foo3(A,B,C).
% Vom Code her nehmen sich hier beide Implementationen nicht viel.
% Bei Prolog muessen wir wieder explizit verhindern, dass nach weiteren Alternativen mittels Backtracking gesucht wird. 
% das Ergebnis in Scheme wiederum ist eindeutig.

% 4.
% Diese Funktion nimmt eine Liste als Argument entgegen, und gibt sie umgedreht zurueck.

% Umsetzung in Prolog:
% foo4(+Liste1,+Akku,?ReverseListe)
foo4([],A,A). % Rekursionsabschluss
foo4([A1|A],B,C):- foo4(A,[A1|B],C).
% Beide Implementationen brauchen einen Akkumulator.
% Die Prolog-Implementation ist DEUTLICH einfacher zu verstehen.
% Bei beiden Implementationen ist das Ergebnis eindeutig.

% 5.
% Diese Funktion macht aus einer Liste mit inneren Listen, Paaren oder Elementen EINE Liste ohne irgendwelche weiteren Verschachtelungen.
% Beispiel: (foo5 '(1 2 (3  4) (5 6 7 8))) --> '(1 2 3 4 5 6 7 8)

% Umsetzung in Prolog:
% foo5(+Liste,?FreeListe)
foo5([],[]). % Rekursionsabschluss
foo5([[A1|A2]|A],[A1|B]):- foo5([A2|A],B),!.
foo5([[]|A],B):- foo5(A,B).		
foo5([A1|A],[A1|B]):- foo5(A,B).
% Bei Prolog muessen wir wieder explizit verhindern, dass nach weiteren Alternativen mittels Backtracking gesucht wird. 
% Die cons-Funktion in Scheme bietet ein etwas leichteres Handling mit der leeren Liste.


%%%%%%%%%%%%%%%
%% Aufgabe 3 %%
%%%%%%%%%%%%%%%

% Idee: Repraesentation als Liste von s'en. 
% Also: s(s(0)) (prolog) ---> '(s s) (scheme)

% Reimplementation vom Prolog-Praedikat lt/2 in Scheme:
% (define (lt p1 p2) (if (< (length p1) (length p2)) #t #f))
% Sehr einfach, da nur ein Vergleich der beiden Listenlaengen noetig ist.

% Reimplementation vom Prolog-Prolog-Praedikat integer2peano/2 in Scheme:
% (define (integer2peano int [peano '(s)])
%  (if (positive? int)
%        (if (= int 1) peano (integer2peano (- int 1) (append peano '(s))))
%        (display "ungueltige Eingabe")))

% Implementation weniger schlicht als in Prolog, aber trotzdem leicht umsetzbar.
% Nachteil: Keine Richtungsunabhaengigkeit mehr!
% Dafuer muesste eine zweite Funktion geschrieben werden, die einfach die Laenge der Liste zurueckgibt.

% Reimplementation vom Prolog-Praedikat add/3 in Scheme:
% (define (add p1 p2)(append p1 p2))
% Viel einfacher als in Prolog! Einfach die Listen aneinanderhaengen.

% Allgemein wird dem Anwender in vielen Faellen durch die umfassenden Funktionsbibliotheken das Leben in Scheme einfach gemacht.
% Andere Beispiele haben aber auch gezeigt, das sehr oft die Prolog-Implementation einfacher, intuitiver und kuerzer ist.
















