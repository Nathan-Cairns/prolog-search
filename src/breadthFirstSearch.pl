% Contains implementation of breadFirstSearch/3
%
% AUTHOR: NATHAN CAIRNS

% Imports %

:- [queues].
:- [eightPuzzle].
:- [counter].

% Rules %

& breadthFirstSearch(+InitialState, -Solution, -Statistics) - defines a depth first search algorithm
breadthFirstSearch(+InitialState, -Solution, -Statistics) :-

