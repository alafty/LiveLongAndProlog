% :-include('KB.pl').

ids(X, L):-
(call_with_depth_limit(goal(X), L, R), number(R));
(call_with_depth_limit(goal(X), L, R), R=depth_limit_exceeded;
                                              L1 is L+1, ids(X, L1)).

goal(S):-
    goal1(S).

goal1(S):-
    state(_, _, _, 1, 1, S).

state(F, M, E, 0, 0, s0):-
    food(F), materials(M), energy(E).

state(F, M, E, B1, B2, result(A, S)):-
    state(F0, M0, E0, B10, B20, S),
    (
        (A = b1, 
            build1(Fx, Mx, Ex), F0 >= Fx, M0 >= Mx, E0 >=  Ex, 
            F is F0 - Fx, M is M0 - Mx, E is E0 - Ex, B1 = 1, B2 = B20
        );
        (A = b2, 
            build2(Fx, Mx, Ex), F0 >= Fx, M0 >= Mx, E0 >=  Ex, 
            F is F0 - Fx, M is M0 - Mx, E is E0 - Ex, B1 = B10, B2 = 1
        );
        (A = reqf, 
            F is F0 + 1, M = M0, E = E0, B1 = B10, B2 = B20
        );
        (A = reqm, 
            F = F0, M is M0 + 1, E = E0, B1 = B10, B2 = B20
        );
        (A = reqe, 
            F = F0, M = M0, E is E0 + 1, B1 = B10, B2 = B20
        )
    ).