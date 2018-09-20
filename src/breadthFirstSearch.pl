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

% Rules %

% Node predicate
initNode(Gvalue, State, Parent) :-
	assert(node(Gvalue, State, Parent)).

% This bfs will solve an eight-puzzle problem.
breadthFirstSearch(InitialState, Solution, Statistics) :-
	make_queue(Q1),
	initNode(0, InitialState, []),	
	join_queue(InitialState, Q1, Q2),
		recurseBfs(Q2).
	
% RecurseBfs
% Base Case - goal state
recurseBfs(Queue) :-
	serve_queue(Queue, State, NewQueue),
	goal8(State).
% Recursive
recurseBfs(Queue) :-
	% Get succ states and join them to the queue
	serve_queue(Queue, State, NewQueue),
	succ8(State, Successors),
	recurseStateList(Successors, NewQueue),
	
	% Recurse
	recurseBfs(NewQueue).
	
% recurseStateList
% Traverses a list of states adding each one to the queue
% Base Case
recurseStateList([], Queue).
% Recursive
recurseStateList([H|T], Queue) :-
		join_queue(H, Queue, NewQueue),
		recurseStateList(T, NewQueue).
	
	
	
