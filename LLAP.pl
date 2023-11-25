%:- include ('KB.pl').

ids(X, L):-
(call_with_depth_limit(goal(X), L, R), number(R));
(call_with_depth_limit(goal(X), L, R), R=depth_limit_exceeded;
                                              L1 is L+1, ids(X, L1)).

increment(0, 1).
increment(X, Y) :- Y is X+1.

% result(A, s0):-
% A = reqf 

% Base case for requests
food(result(reqf, s0), X):-
food(X1), X is X1 + 1.

materials(result(reqm, s0), X):-
materials(X1), X is X1 + 1.

energy(result(reqe, s0), X):-
energy(X1), X is X1 + 1.

% Recursive case for requests
food(result(reqf, S), X):-
food(S, X1), X is X1 + 1.

materials(result(reqm, S), X):-
materials(S, X1), X is X1 + 1.

energy(result(reqe, S), X):-
energy(S, X1), X is X1 + 1.

% Base case for builds
food(result(b1, s0), X):-
food(X1), materials(X2), energy(X3), build1(Y1, Y2, Y3), X1 >= Y1, X2 >= Y2, X3 >= Y3, X is X1 - Y1.

materials(result(b1, s0), X):-
food(X1), materials(X2), energy(X3), build1(Y1, Y2, Y3), X1 >= Y1, X2 >= Y2, X3 >= Y3, X is X2 - Y2.

energy(result(b1, s0), X):-
food(X1), materials(X2), energy(X3), build1(Y1, Y2, Y3), X1 >= Y1, X2 >= Y2, X3 >= Y3, X is X3 - Y3.

food(result(b2, s0), X):-
food(X1), materials(X2), energy(X3), build2(Y1, Y2, Y3), X1 >= Y1, X2 >= Y2, X3 >= Y3, X is X1 - Y1.

materials(result(b2, s0), X):-
food(X1), materials(X2), energy(X3), build2(Y1, Y2, Y3), X1 >= Y1, X2 >= Y2, X3 >= Y3, X is X2 - Y2.

energy(result(b2, s0), X):-
food(X1), materials(X2), energy(X3), build2(Y1, Y2, Y3), X1 >= Y1, X2 >= Y2, X3 >= Y3, X is X3 - Y3.

% Recursive case for builds
food(result(b1, S), X):-
food(S, X1), materials(S, X2), energy(S, X3), build1(Y1, Y2, Y3), X1 >= Y1, X2 >= Y2, X3 >= Y3, X is X1 - Y1.

materials(result(b1, S), X):-
food(S, X1), materials(S, X2), energy(S, X3), build1(Y1, Y2, Y3), X1 >= Y1, X2 >= Y2, X3 >= Y3, X is X2 - Y2.

energy(result(b1, S), X):-
food(S, X1), materials(S, X2), energy(S, X3), build1(Y1, Y2, Y3), X1 >= Y1, X2 >= Y2, X3 >= Y3, X is X3 - Y3.


food(result(b2, S), X):-
food(S, X1), materials(S, X2), energy(S, X3), build2(Y1, Y2, Y3), X1 >= Y1, X2 >= Y2, X3 >= Y3, X is X1 - Y1.

materials(result(b2, S), X):-
food(S, X1), materials(S, X2), energy(S, X3), build2(Y1, Y2, Y3), X1 >= Y1, X2 >= Y2, X3 >= Y3, X is X2 - Y2.


energy(result(b2, S), X):-
food(S, X1), materials(S, X2), energy(S, X3), build2(Y1, Y2, Y3), X1 >= Y1, X2 >= Y2, X3 >= Y3, X is X3 - Y3.

food(result(A, s0), X):-
A \= b1, A \= b2, food(X).
materials(result(A, s0), X):-
A \= b1, A \= b2, materials(X).
energy(result(A, s0), X):-
A \= b1, A \= b2, energy(X).
food(result(A, S), X):-
A \= b1, A \= b2, food(S, X).
materials(result(A, S), X):-
A \= b1, A \= b2, materials(S, X).
energy(result(A, S), X):-
    A \= b1, A \= b2, energy(S, X).


goal(S):-
    goal1(S, []).

goal1(result(_, S), [b1, b2]):-
    food(S, X1), materials(S, X2), energy(S, X3), food(X1), materials(X2), energy(X3), S = s0;

goal1(s0, [b1, b2]).


goal1(result(b1, S), []):-
    goal1(S, [b1]), food(result(b1, S), _), materials(result(b1, S), _), energy(result(b1, S), _).
goal1(result(b2, S), []):-
    goal1(S, [b2]), food(result(b2, S), _), materials(result(b2, S), _), energy(result(b2, S), _).
goal1(result(b1, S), [b2]):-
    goal1(S, [b1, b2]), food(result(b1, S), _), materials(result(b1, S), _), energy(result(b1, S), _).
goal1(result(b2, S), [b1]):-
    goal1(S, [b1, b2]), food(result(b2, S), _), materials(result(b2, S), _), energy(result(b2, S), _).
goal1(result(_, S), [b1, b2]):-
    goal1(S, [b1, b2]).
goal1(result(reqf, S), L):-
    goal1(S, L).
goal1(result(reqe, S), L):-
    goal1(S, L).
goal1(result(reqm, S), L):-
    goal1(S, L).
