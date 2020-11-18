


/*******************   Prédicat sousliste   *******************/

sousliste([], _).
sousliste([X|S], [X|L]) :- sousliste(S, L).
sousliste([X|S], [_|L]) :- sousliste([X|S], L).

/*******************   Prédicat supprimer_element   *******************/

supprimer_element(X, [X|L1], L1).
supprimer_element(X,[Y|L1], [Y|L2]):- supprimer_element(X,L1, L2).

/*******************   Prédicat permutation   *******************/

permutation([], []).
permutation(L, [X|L1]) :-
    		supprimer_element(X,L, L2),
    		permutation(L2, L1).

/*******************   Prédicat concatenation   *******************/

concatenation([], _, _):- !, fail.
concatenation(_,[], _):- !, fail.
concatenation(L1, L2, L):- append(L1,L2,L).

/*******************   Prédicat chaine   *******************/

chaine( X, Y, Op, Full):-
    		concatenation([X], Op, Half),
    		concatenation(Half, [Y], Full).

/*******************   Prédicat associe   *******************/

associe([A, LA], [B, LB], [C, LC]):-
    		C is A + B,
    		chaine(LA, LB, [+], LC).

associe([A, LA], [B, LB], [C, LC]):-
    		C is A * B,
    		chaine(LA, LB, [*], LC).

associe([A, LA], [B, LB], [C, LC]):-
    		C is A-B,
    		chaine(LA, LB, [-], LC).

associe([A, LA], [B, LB], [C, LC]):-
	    	B =\= 0,
	    	0 =:= A mod B,
	    	C is A / B,
	    	chaine(LA, LB, [/], LC).


/*******************   Prédicat calcule   *******************/

calcule([], _):- !, fail.
calcule([X], [X, X]) :- !.
calcule(L, [C, LC]):-
    		sousliste(SousListeA,L),
    		sousliste(SousListeB,L),
    		concatenation(SousListeA, SousListeB, SousListeTemp),
       		permutation(SousListeTemp, L),
           	calcule(SousListeA, [A, LA]),
    		calcule(SousListeB, [B, LB]),
    		associe([A, LA], [B, LB], [C, LC]).


/*******************   Prédicat chiffre   *******************/

chiffres(L, S,[S, LC]) :-
    		sousliste(L1, L),
    		calcule(L1, [S, LC]).






















