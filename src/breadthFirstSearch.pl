% Contains implementation of breadFirstSearch/3
%
% AUTHOR: NATHAN CAIRNS

% TODO init nodes
% TODO add stats
% TODO maintain a close list

% Imports %

:- consult(queues).
:- consult(counter).
:- consult(eightPuzzle).

% Predicate defs %

% closed(state)
:- dynamic closed/1.
% node(Gvalue, State, Parent)
:- dynamic node/3.

% Rules %

% This bfs will solve an eight-puzzle problem.
breadthFirstSearch(InitialState, Solution, Statistics) :-
	% Init queue
	make_queue(Q1),
	join_queue(InitialState, Q1, Q2),
	
	% Init counters
	initialiseCounter(_, generated),
	initialiseCounter(_, expanded),
	initialiseCounter(_, duplicated),
	
	% Retract all asserted facts
	retractall(closed(_)),
	retractall(node(_, _, _)),
	
	% Assert init state as node
	assert(node(0, InitialState, _)),
	
	% Do bfs
	recurseBfs(Q2, SolutionState),
	
	%Reconstruct solution
	reconstructSolution(InitialState, SolutionState, Solution).
	
% Reconstructs the solution given the solution node and the initial state
% Base Case
reconstructSolution(InitialState, InitialState, [InitialState]).
% Recursive
reconstructSolution(InitialState, CurrentState, Solution).
	node(_, CurrentState, ParentState),
	append([CurrentState], Solution2, Solution).
	reconstructSolution(InitialState, ParentState, Solution2).
		
% Recursive BFS algorithm
% Base Case
recurseBfs(Queue, State) :- 
	serve_queue(Queue, State, _),
	goal8(State).
% Recursive
recurseBfs(Queue, Solution) :-
	% Get state from head of queue and mark as closed
	serve_queue(Queue, State, Q2),
	assert(closed(State)),
	
	% Get successors of state and add them to the queue	
	succ8(State, Successors),
	trimSucc(Successors, [], TrimmedSucc),
	recurseSucc(TrimmedSucc, State, , Q2, Q3), % TODO G VALUE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	
	incrementCounter( , expanded), % TODO G VALUE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	
	recurseBfs(Q3, Solution).

% Trims the successor tuples
% Base Case
trimSucc([], TrimmedSucc, TrimmedSucc).
% Recursive
trimSucc([(_, State)|T], TrimmedSucc, Output) :-
	append(TrimmedSucc, [State], TrimmedSucc2),
	trimSucc(T, TrimmedSucc2, Output).
	
% Adds a list of states to the queue
% Base Case
recurseSucc([], Parent, Gvalue Queue, Queue).
% Recursive
recurseSucc([H|T], Parent, Gvalue, Queue, NewQueue) :-
	(closed(H) ->
		(node(Gvalue, H, _) -> 
			incrementCounter(Gvalue, duplicated)
		),
		recurseSucc(T, Queue, NewQueue)
		; join_queue(H, Queue, Q2),
		assert(node(Gvalue, H, Parent)),
		incrementCounter(Gvalue, generated),
		recurseSucc(T, Q2, NewQueue)
	).