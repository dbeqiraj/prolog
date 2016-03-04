:- initialization(writeln("Finding chess's knight shortest path!")).
:- initialization(writeln('Usage: path((x1,y1),(x2,y2)).')).

% --------------------------------------------------- The execution starts here -----------------------------------------------------------------------------
 
path(From, To) :-
	traverse(From),                   
	edge([To|ReversedPath], Dist)->         % If the destination is reachable, display an appropriate message.
	  reverse([To|ReversedPath], Path),      
	  Distance is Dist,
	  writef('Path = %w and the distance is %w = %w\n',
	       [Path, Dist, Distance]);
	writef('There is no path that connects %w with %w\n', [From, To]).
 
% -----------------------------------------------------------------------------------------------------------------------------------------------------------


% --------------------------------------------------- Traverse the nodes ------------------------------------------------------------------------------------
traverse(From) :-
	retractall(edge(_,_)),           % Remove all the facts edge(_,_)
	traverse(From,[],0).              % Let's begin to construct the path, starting from the origin node.
	
traverse(From, Path, Dist) :-		    % Traverse all the neighbors of node From.
	path(From, T, D),		    % For each neighbour T
	not(memberchk(T, Path)),	    %	if node T hasn't been visited earlier (it's not in the path)
	shorterPath([T,From|Path], Dist+D), %	Create a fact edge(Path, Dist) if that fact doesn't exist, or update it if it exists
	traverse(T,[From|Path],Dist+D).	    %	Do the same thing for node T, find all its neighbors...
	
traverse(_).
 
% -----------------------------------------------------------------------------------------------------------------------------------------------------------

% --------------------------------------------------- Finding the neighbors --------------------------------------------------------------------------------
 
path(From,To,Dist) :- neighbour(From,To,Dist).
 
% -----------------------------------------------------------------------------------------------------------------------------------------------------------	


% -------------------------------------Create or update (when the fact exists) facts edge(_,_). -------------------------------------------------------------
 
shorterPath([H|Path], Dist) :-		       % if there is a fact edge(H|_, D), this means that we know the distance from node From to node H.
	edge([H|_], D), !, Dist < D,          %  But if the distance D is greater than the new distance Dist that we discovered, 
	retract(edge([H|_],_)),				%  then we are going to remove (assert) the fact edge([H|_], D) and add a new one edge([H|Path], Dist).  
	assert(edge([H|Path], Dist)).		% This is the shortest path that we have found so far to reach the node H.
	
shorterPath(Path, Dist) :-		       % Let's create a new fact to memorize the path from the origin node From, to another node.
	assert(edge(Path,Dist)).			% Keep track the distance Dist of that path.
 
% -----------------------------------------------------------------------------------------------------------------------------------------------------------

	
% ------------------ Check if there is an edge that connects [(X1, Y1) (X2,Y2)] and verify if they both are within the allowed area -------------------------

checkCell((X1,Y1),(X2,Y2)) :- checkCell1(X1), checkCell1(Y1), checkCell1(X2), checkCell1(Y2).
checkCell1(X) :-     1 =< X, X =< 8.

neighbour((X1,Y1),(X2,Y2), 1) :- X2 is X1+2, Y2 is Y1+1, checkCell((X1,Y1),(X2,Y2)).

neighbour((X1,Y1),(X2,Y2), 1) :- X2 is X1+1, Y2 is Y1+2, checkCell((X1,Y1),(X2,Y2)).

neighbour((X1,Y1),(X2,Y2), 1) :- X2 is X1+2, Y2 is Y1-1, checkCell((X1,Y1),(X2,Y2)).

neighbour((X1,Y1),(X2,Y2), 1) :- X2 is X1+1, Y2 is Y1-2, checkCell((X1,Y1),(X2,Y2)).

neighbour((X1,Y1),(X2,Y2), 1) :- X2 is X1-2, Y2 is Y1+1, checkCell((X1,Y1),(X2,Y2)).

neighbour((X1,Y1),(X2,Y2), 1) :- X2 is X1-1, Y2 is Y1+2, checkCell((X1,Y1),(X2,Y2)).

neighbour((X1,Y1),(X2,Y2), 1) :- X2 is X1-2, Y2 is Y1-1, checkCell((X1,Y1),(X2,Y2)).

neighbour((X1,Y1),(X2,Y2), 1) :- X2 is X1-1, Y2 is Y1-2, checkCell((X1,Y1),(X2,Y2)).

% -----------------------------------------------------------------------------------------------------------------------------------------------------------


% Usage: path(startNode, endNode).
% For example, in an 8x8 chess border: path((1,1), (8,1)).
