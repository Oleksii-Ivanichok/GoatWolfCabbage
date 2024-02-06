% State is described as state(Farmer, Wolf, Goat, Cabbage),
% where each variable can be either 'left' or 'right'.

% Checking if a state is safe.
safe_state(state(F, W, G, C)) :-
    \+ unsafe(F, W, G, C).

unsafe(F, W, G, C) :-
    (F \= W, W = G);  % Wolf and Goat are on the same side, Farmer is not
    (F \= G, G = C).  % Goat and Cabbage are on the same side, Farmer is not

% Moving the farmer alone or with an animal.
move(state(X, W, G, C), state(Y, W, G, C)) :- opposite(X, Y).
move(state(X, X, G, C), state(Y, Y, G, C)) :- opposite(X, Y).
move(state(X, W, X, C), state(Y, W, Y, C)) :- opposite(X, Y).
move(state(X, W, G, X), state(Y, W, G, Y)) :- opposite(X, Y).

% Defining the opposite side.
opposite(left, right).
opposite(right, left).

% Recursive solution search.
solution(State, Visited, Path) :-
    target_state(State),
    reverse(Visited, Path).

solution(State, Visited, Path) :-
    move(State, NextState),
    safe_state(NextState),
    \+ member(NextState, Visited),  % Ensure the state has not been visited before
    solution(NextState, [NextState | Visited], Path).

% Defining the target state.
target_state(state(right, right, right, right)).

% Initiating the solution search.
find_solution(Solution) :-
    solution(state(left, left, left, left), [state(left, left, left, left)], Solution).
