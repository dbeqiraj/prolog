maxMember([X],X):-!.
maxMember([H|T],Max) :- maxMember(T, M),(H>M -> Max is H ; Max is M).

% Usage: maxMember([1,2,3,4], M). => Output: M=4