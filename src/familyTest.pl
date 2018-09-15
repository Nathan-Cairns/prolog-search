% File for testing the rules established in family.pl
% 
% AUTHOR: NATHAN CAIRNS

% Imports %

:- [family].

% Facts %

% childOF/2

childOf(bob, steve). % should fail motherof
childOf(bob, elizabeth). % should pass motherof
childOf(bob, steph). % should fail motherof

childOf(rob, steve). % rob / bob should fail sisterof
childOf(eden, steve). % eden / bob should succeed sisterof

% Female/1

female(elizabeth).
female(eden).

% Male/1

male(steve).
male(rob).
male(bob).