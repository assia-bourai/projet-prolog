



/*******************   Prédicat readword   *******************/


readWord(InStream,W, WCount):-
   		get_code(InStream,Char),
   		checkCharAndReadRest(Char,Chars,InStream, WCount, 0),
   		atom_codes(W,Chars).


/*************   Prédicat checkCharAndReadRest   **************/

checkCharAndReadRest(10,[],_, WCount, WCount):-!.

checkCharAndReadRest(32,[],_, WCount, WCount):-!.

checkCharAndReadRest(-1,[],_, WCount, WCount):-!.

checkCharAndReadRest(end_of_file,[],_, WCount , WCount):-!.

checkCharAndReadRest(Char,[Char|Chars],InStream,WCount,WCountemp):-
   		Temp is WCountemp + 1,
   		get_code(InStream,NextChar),
   		checkCharAndReadRest(NextChar,Chars,InStream, WCount, Temp).


/*******************   Prédicat dicbuilder   *******************/


dicbuilder(File):-
   		open(File,read,Str),
   		builddic(Str),
   		close(Str).

/*******************   Prédicat builddic   *******************/

builddic(Stream):- at_end_of_stream(Stream),!.

builddic(Stream):-
		readWord(Stream, W, Count),
    		assert(dico(W,Count)),
    		builddic(Stream).

/*******************   Prédicat lettres   *******************/
 
lettres(L2, M, Taille, File):-
		dicbuilder(File),
        	sublist(L2,_, L, _),
		permutation(L,L1),
		atom_chars(M, L1),
		dico(M, Taille), !.

/*******************   Prédicat sublist   *******************/

sublist(L, [], L, N):- length(L, N).
sublist(L, S, R, Leng) :-
		length(L, N),
		between(1, N, M),
 		length(S, M),
 		append([A,S,B], L),
  		append(A,B,R), Leng is N - M.

