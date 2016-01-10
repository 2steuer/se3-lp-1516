% Praedikate wurden in code.pl definiert.

%%%%%%%%%%%%%%%%%
%   Aufgabe 1   %
%%%%%%%%%%%%%%%%%
 % 1)
 % Zeit und Energie werden unter "values" als Paare notiert.
 % Die Zeitinformation findet sich an erster Stelle dieser Paare. Dort ist die Unixzeit in Millisekunden angegeben.
 % Die Information zur elektrischen Energie findet sich an zweiter Stelle dieser Paare. Dort ist die Energie in Gigawatt angegeben.
 
 % 2)
 % Die Anforderung wurde durch das Praedikat convertJSON/1 realisiert, welches als Argument einen Filepath entgegen nimmt,
 % und die erzeugten Eintraege im gewuenschten Format in data.pl schreibt.

%%%%%%%%%%%%%%%%%
%   Aufgabe 2   %
%%%%%%%%%%%%%%%%%

 % 1a)
 % Realisiert durch das Praedikat gran_changer/3.
 % Test:
	% ?- gran_changer('Solar',86400,New).
	% New = energy_time_series('Solar', 1388530800000, 86400, [30.491, 13.677999999999999, 23.509999999999998, 15.229000000000001, 18.068000000000005, 26.281000000000006, 44.462999999999994, 35.227, 23.978, 30.979000000000003, 23.923, 45.882, 21.968000000000004, 15.4, 30.895999999999997, 14.973, 20.624000000000002, 35.463, 20.364, 6.372000000000001, 5.836, 11.994000000000002, 13.661999999999999, 9.806000000000001, 19.05, 15.071, 23.636, 38.964999999999996, 24.076999999999998, 37.222, 45.49999999999999]).

 % 1b)
 % ?- gran_changer('Wind',86400,NewWind).
 % NewWind = energy_time_series('Wind', 1388530800000, 86400, [214.813, 310.02500000000003, 330.009, 273.314, 170.957, 366.9149999999999, 365.61100000000005, 293.13599999999997, 416.003, 388.89900000000006, 299.657, 254.33900000000003, 126.911, 33.622, 80.86099999999999, 172.43800000000005, 124.10399999999998, 153.46800000000002, 307.99299999999994, 84.231, 16.084, 57.190000000000005, 122.933, 109.011, 138.416, 183.75199999999995, 187.83599999999998, 155.44600000000003, 213.548, 169.29200000000003, 108.87699999999998]).
 
 % ?- gran_changer('Steinkohle',86400,NewKohle).
 % NewKohle = energy_time_series('Steinkohle', 1388530800000, 86400, [90.031, 196.087, 164.33299999999994, 139.304, 112.459, 154.217, 252.427, 328.64, 276.834, 294.872, 192.977, 147.18900000000002, 414.90299999999996, 465.784, 462.4440000000001, 421.17799999999994, 414.317, 246.72299999999998, 152.07399999999998, 413.179, 462.7, 470.58400000000006, 469.26599999999996, 465.835, 364.62700000000007, 212.631, 400.76300000000003, 453.414, 420.9669999999999, 434.074, 429.6549999999999]).
 
 % Durch Einfaches Ablesen koennen wir uns von den in der Aufgabe genannten Tatsachen ueberzeugen.
 
 % 2a)
 % Realisiert durch das Praedikat transp/2.
 % Test:
	% ?- transp([[1,2,3,4],[5,6,7,8]],Transp).
	% Transp = [[1, 5], [2, 6], [3, 7], [4, 8]].
	
 % 2b)
 % Realisiert durch total.
 
 % 3a)
 % Realisiert durch pearson_kor/3.
 % Test:
	% ?- pearson_kor([1,2,3,4,5],[5,6,7,8,9],Korrelation).
	% Korrelation = 0.9999999999999999.
	
	% ?- pearson_kor([1,2,3,4,5],[3,2,4,1,5],Korrelation).
	% Korrelation = 0.29999999999999993.
	
 % 3b)
 % Realisiert durch korrelation/1.
 % Test:
	% ?- korrelation(Strongest).
	% Strongest = 'Öl'.
	
 % 4a)
 % Realisiert durch lastprofil/3. Siehe code.pl

 
 % 4b)
 % Wir haben zu diesem Zweck den Eintrag in lostdate_facts.pl in 'TotalUnknown' umbenannt.
 % ?- gran_changer('TotalUnknown',86400,U),lastprofil(U,604800,P).
 % U = energy_time_series('TotalUnknown', 0, 86400, [1377.8279999999997, 1136.6079999999997, 1040.225, 1310.8579999999997, 1348.6180000000002, 1337.518, 1337.283, 1315.872|...]),
 % P = [1382.9299999999998, 1221.26875, 1183.483, 1358.33025, 1310.20525, 1317.47125, 1382.7247499999999].
 % Beginnt Freitags! (Da Sonntag = niedrigster Stromverbrauch)
 
 