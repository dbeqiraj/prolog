power(_, 0, 1):-!.

power(M, N, Res):-  D is N-1, power(M, D, Rt), Res is M * Rt.

% Usage: power(3,2,R). => R=9