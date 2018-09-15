% Contains logic definitions for the family predicates motherOf/2, sisterOf/2 and inSameTree/2.
% Contains the prolog implementations of these definitions.
%
% AUTHOR: NATHAN CAIRNS

% Rules %

% motherOf(mother, person) - decides whether a person is a mother of another person
% Assumes we have the fact predicates childOf(child, parent), male(person), female(person)
% Mother is the mother of Person if Person is a child of Mother and Mother is female.
% motherOf(Mother, Person) = childOf(Person, Mother) ^ female(Mother)
motherOf(Mother, Person):- childOf(Person, Mother), female(Mother).
 
% sisterOf(sister, person) - decides whether a person is a sister of another person
% Assumes we have the fact predicates childOf(child, parent), male(person), female(person)
% Sister is the sister of Person is Sister is female and Person and Sister are the child of the same Parent.
% sisterOf(Sister, Person) = female(Sister) ^ Exists(Parent, (childOf(Person, Parent) ^ childOf(Sister, Parent)))
sisterOf(Sister, Person) :-  female(Sister), childOf(Person, Parent), childOf(Sister, Parent).
 
% inSameTree(node1, node2) - decides whether node1 and node2 are in the same tree
% Assumes we have the fact predicates of parentOf(parent, child)
% Two nodes node1 and node2 are in the same tree if they share a common ancestor. 
inSameTree(Node1, Node2) :- ancestorOf(Ancestor, Node1), ancestorOf(Ancestor, Node2).

% ancestorOf(Ancestor, Descendent) - decides whether Ancestor is an ancestor of Descendent.
% Assumes we have the fact predicates of parentOf(parent, child)
ancestorOf(Ancestor, Descendent) :- parentOf(Ancestor, Descendent).
ancestorOf(Ancestor, Descendent) :- parentOf(Ancestor, Child), ancestorOf(Child, Descendent).

