% draw(Size)
% draws a graphics with a given Size

draw(Size) :-
   % prepare a Display to draw the object on
   % generate a new display name
   gensym(w,Display),
   free(@Display),
   % define size of the display (picture size + scroll bar area)
   SizeD is Size,
   % create a new display and open it
   new(@Display,picture('Graphik',size(SizeD,SizeD))),
   send(@Display,open),
   % send(@Display,background,colour(black)), %* MK: ggf. Farbe auf 'white' stellen

   % draw the object on the display
   (
        draw_object(@Display,SizeD,SizeD /* , ***add additional parameters if needed *** */);
        false
   ),
   % if desired save the display as .jpg
   write_ln('Save the graphics (y/n): '),
   get_single_char(A),
   put_code(A),nl,
   (A=:=121 ->
     (write_ln('enter file name: '),
      read_line_to_codes(user_input,X),
      atom_codes(File,X),
      atom_concat(File,'.jpg',FileName),
      get(@Display,image,Image),
      send(Image,save,FileName,jpeg) ) ; true ),

   !.


% draw_object(Display,Size,CurrentSize,*** add additional parameters here, if needed ***)
% draws a gradient graphics of size Size into Display
% CurrentSize is decreased recursively fom Size to 0
draw_object(_,_,0 /* , *** add additional parameters here, if needed *** */). 
draw_object(Name,Size,CSize /* , *** add additional parameters here, if needed *** */) :- 
   CSize > 0 ,        % only for positive integers

  % *** insert the computation of graphical parameters here ***
	
  % generate a new box name
   gensym(w,Box),
   gensym(y,Farbe),
   free(@Box),
	
	V is 65535*CSize/Size,
	X is (Size-CSize)/2,

  % *** create and draw the current graphical object here ***

	new(@Box,box(CSize,CSize)),
	send(Name, display, @Box, point(X,X)),

  % *** send all additional parameters to the current graphical object ***

	send(@Box,texture, none),
	send(@Box,fill_pattern, colour(Farbe, 65535-V, 65535-V, 65535-V, rgb)),

  % decrement CurrentSize and call draw_object recursively
  CSizeNew is CSize - 20,
% writeln(CSizeNew),
  draw_object(Name,Size,CSizeNew).



% Call the program and see the result
:- draw( 1000 ).   % specify the desired display size in pixel here (required argument)   




% ========== Tests from XPCE-guide Ch 5 ==========

% destroy objects
mkfree :-
   free(@p),
   free(@bo),
   free(@ci),
   free(@bm),
   free(@tx),
   free(@bz).

% create picture / window
mkp :-
   new( @p , picture('Demo Picture') ) ,
   send( @p , open ).

% generate objects in picture / window
mkbo :-
   send( @p , display , new(@bo,box(100,100)) ).
mkci :-
   send( @p , display , new(@ci,circle(50)) , point(25,25) ).
mkbm :-
   send( @p , display , new(@bm,bitmap('32x32/books.xpm')) , point(100,100) ).
mktx :-
   send( @p , display , new(@tx,text('Hello')) , point(120,50) ).
mkbz :-
   send( @p , display , new(@bz,bezier_curve(
	 point(50,100),point(120,132),point(50,160),point(120,200))) ).

% modify objects
mkboc :-
   send( @bo , radius , 10 ).
mkcic :-
   send( @ci , fill_pattern , colour(orange) ).
mktxc :-
   send( @tx , font , font(times,bold,18) ).
mkbzc :-
   send( @bz , arrows , both ).


