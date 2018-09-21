% Contains implementation of breadFirstSearch/3
%
% AUTHOR: NATHAN CAIRNS

% TODO init nodes
% TODO add stats
% TODO maintain a close list
% TODO finish the funciton lol

% Imports %

:- consult(queues).
:- consult(counter).
:- consult(eightPuzzle).

% Predicate defs %

:- dynamic closed/1.
:- dynamic node/3.

% Rules %

% Node predicate
initNode(Gvalue, State, Parent) :-
	assert(node(Gvalue, State, Parent)).

% This bfs will solve an eight-puzzle problem.
breadthFirstSearch(InitialState, Solution, Statistics) :-
	make_queue(Q1),
	join_queue(InitialState, Q1, Q2),
	recurseBfs(Q2, Solution).
	
% RecurseBfs
recurseBfs(Queue, State) :- 
	serve_queue(Queue, State, _),
	goal8(State).
recurseBfs(Queue, Solution) :-
	serve_queue(Queue, State, Q2),
	assert(closed(State)),
	succ8(State, Successors),
	trimSucc(Successors, [], TrimmedSucc),
	recurseSucc(TrimmedSucc, Q2, Q3),
	recurseBfs(Q3, Solution).

% Trims the succ tuple
trimSucc([], TrimmedSucc, TrimmedSucc).
trimSucc([(_, State)|T], TrimmedSucc, Output) :-
	append(TrimmedSucc, [State], TrimmedSucc2),
	trimSucc(T, TrimmedSucc2, Output).
	
% Recurse succ
recurseSucc([], Queue, Queue).
recurseSucc([H|T], Queue, NewQueue) :-
	(closed(H) ->
		recurseSucc(T, Queue, NewQueue)
		; join_queue(H, Queue, Q2), recurseSucc(T, Q2, NewQueue)
	).