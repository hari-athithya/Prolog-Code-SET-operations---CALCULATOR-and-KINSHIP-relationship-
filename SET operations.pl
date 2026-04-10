
Set operation:
----------------

% ----------------------
% MEMBER
% ----------------------
member(X, [X|_]).
member(X, [_|T]) :-
    member(X, T).

% ----------------------
% UNION
% ----------------------
union([], L, L).
union([H|T], L, R) :-
    member(H, L),
    union(T, L, R).
union([H|T], L, [H|R]) :-
    not(member(H, L)),
    union(T, L, R).

% ----------------------
% INTERSECTION
% ----------------------
intersect([], _, []).
intersect([H|T], L, [H|R]) :-
    member(H, L),
    intersect(T, L, R).
intersect([H|T], L, R) :-
    not(member(H, L)),
    intersect(T, L, R).

% ----------------------
% DIFFERENCE (A - B)
% ----------------------
difference([], _, []).
difference([H|T], L, R) :-
    member(H, L),
    difference(T, L, R).
difference([H|T], L, [H|R]) :-
    not(member(H, L)),
    difference(T, L, R).

% ----------------------
% CARDINALITY (length)
% ----------------------
cardinality([], 0).
cardinality([_|T], N) :-
    cardinality(T, N1),
    N is N1 + 1.

% ----------------------
% SUBSET
% ----------------------
subset([], _).
subset([H|T], L) :-
    member(H, L),
    subset(T, L).

% ----------------------
% EQUIVALENT SETS
% (same elements both subsets)
% ----------------------
equivalent(A, B) :-
    subset(A, B),
    subset(B, A).

------------------------------------------
