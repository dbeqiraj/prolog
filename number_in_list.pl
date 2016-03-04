numberInList([]):-fail.
numberInList([H|T]):-number(H) -> true; numberInList(T).

% If there is a number in the list => true, else => false
% Usage: numberInList([a,b,c,d,1]).