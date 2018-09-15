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

% Test facts for inSameTree/2

% calling inSameTree(node1, node2) should return true
parentOf(node3, node1).
parentOf(node3, node2).

% calling inSameTree(nodeA1, nodeA2) should return false
parentOf(nodeA3, nodeA1).
parentOf(nodeA4, nodeA2).

% calling inSameTree(nodeB1, nodeB2) should return true
parentOf(nodeB2, nodeB1).
parentOf(nodeB3, nodeB2).
parentOf(nodeB4, nodeB3).

parentOf(nodeB6, nodeB5).
parentOf(nodeB7, nodeB4).