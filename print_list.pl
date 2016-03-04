printList([]):-!.
printList([H|T]):-printList(T), write(H), write('\n').

% Usage printList([1,2,3,4]).
