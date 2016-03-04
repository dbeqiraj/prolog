joinLists([],L,L):-!.
joinLists([H|L1],L2,[H|LL]):-joinLists(L1,L2,LL).

% Usage: joinLists(L1,L2,Res).
% Example: joinLists([1,2],[3,4],Res). => Output: Res=[1,2,3,4]