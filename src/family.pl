% Contains logic definitions for the family predicates motherOf/2, sisterOf/2 and inSameTree/2.
% Contains the prolog implementations of these definitions.
% Assumes we have the fact predicates childOf(child, parent), male(person), female(person)
%
% AUTHOR: NATHAN CAIRNS

% Rules %

% motherOf(mother, person) - decides whether a person is a mother of another person
motherOf(Mother, Person):- childOf(Person, Mother), female(Mother).
 
% sisterOf(sister, person) - decides whether a person is a sister of another person
sisterOf(Sister, Person) :-  female(Sister), childOf(Person, Parent), childOf(Sister, Parent).
 
% inSameTree(node1, node2) - decides wheter node1 and node2 are in the same tree
inSameTree(node1, node2) :-