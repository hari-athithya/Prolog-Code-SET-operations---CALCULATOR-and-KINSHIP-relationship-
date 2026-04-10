% ------------------------
% Gender
% ------------------------
male(john). male(bob). male(jim). male(tom). male(fred).
male(scott). male(jack). male(rich). male(steve). male(mike). male(harry).

female(mary). female(carol). female(patty). female(alice).
female(valerie). female(barbara). female(donna).
female(rachel). female(linda). female(jane). female(cindy).

% ------------------------
% Spouse
% ------------------------
spouse(john, mary). spouse(mary, john).
spouse(tom, alice). spouse(alice, tom).
spouse(fred, valerie). spouse(valerie, fred).
spouse(barbara, scott). spouse(scott, barbara).
spouse(jack, donna). spouse(donna, jack).
spouse(rich, rachel). spouse(rachel, rich).
spouse(linda, steve). spouse(steve, linda).

% ------------------------
% Parent
% ------------------------
parent(patty, carol). parent(john, carol).

parent(john, tom). parent(mary, tom).
parent(john, linda). parent(mary, linda).
parent(bob, jim). parent(mary, jim).

parent(tom, valerie). parent(alice, valerie).
parent(tom, barbara). parent(alice, barbara).

parent(fred, jane). parent(valerie, jane).

parent(barbara, cindy). parent(scott, cindy).

parent(linda, jack). parent(steve, jack).
parent(linda, rich). parent(steve, rich).

parent(jack, mike). parent(donna, mike).
parent(rich, harry). parent(rachel, harry).

% ------------------------
% Basic Relations
% ------------------------
father(X,Y) :- male(X), parent(X,Y).
mother(X,Y) :- female(X), parent(X,Y).

child(X,Y) :- parent(Y,X).

sibling(X,Y) :-
    father(F,X), father(F,Y),
    mother(M,X), mother(M,Y),
    X \= Y.

brother(X,Y) :- male(X), sibling(X,Y).
sister(X,Y) :- female(X), sibling(X,Y).

grandparent(X,Y) :- parent(X,Z), parent(Z,Y).

grandfather(X,Y) :- male(X), grandparent(X,Y).
grandmother(X,Y) :- female(X), grandparent(X,Y).

grandchild(X,Y) :- grandparent(Y,X).
grandson(X,Y) :- male(X), grandparent(Y,X).
granddaughter(X,Y) :- female(X), grandparent(Y,X).

uncle(X,Y) :-
    male(X),
    sibling(X,P),
    parent(P,Y).

aunt(X,Y) :-
    female(X),
    sibling(X,P),
    parent(P,Y).

nephew(X,Y) :-
    male(X),
    parent(P,X),
    sibling(P,Y).

niece(X,Y) :-
    female(X),
    parent(P,X),
    sibling(P,Y).

cousin(X,Y) :-
    parent(P1,X),
    parent(P2,Y),
    sibling(P1,P2),
    X \= Y.

% ------------------------
% Step Relations
% ------------------------
step_father(X,Y) :-
    male(X),
    spouse(X,P),
    parent(P,Y),
    \+ parent(X,Y).

step_mother(X,Y) :-
    female(X),
    spouse(X,P),
    parent(P,Y),
    \+ parent(X,Y).

step_brother(X,Y) :-
    male(X),
    parent(P1,X),
    parent(P2,Y),
    spouse(P1,P2),
    \+ sibling(X,Y),
    X \= Y.

step_sister(X,Y) :-
    female(X),
    parent(P1,X),
    parent(P2,Y),
    spouse(P1,P2),
    \+ sibling(X,Y),
    X \= Y.

% ------------------------
% Relation Mapping
% ------------------------
relation(X, Y, 'Father') :- father(X, Y).
relation(X, Y, 'Mother') :- mother(X, Y).
relation(X, Y, 'Son') :- male(X), child(X, Y).
relation(X, Y, 'Daughter') :- female(X), child(X, Y).
relation(X, Y, 'Spouse') :- spouse(X, Y).
relation(X, Y, 'Brother') :- brother(X, Y).
relation(X, Y, 'Sister') :- sister(X, Y).
relation(X, Y, 'Grandfather') :- grandfather(X, Y).
relation(X, Y, 'Grandmother') :- grandmother(X, Y).
relation(X, Y, 'Uncle') :- uncle(X, Y).
relation(X, Y, 'Aunt') :- aunt(X, Y).
relation(X, Y, 'Cousin') :- cousin(X, Y).
relation(X, Y, 'Nephew') :- nephew(X, Y).
relation(X, Y, 'Niece') :- niece(X, Y).

% Step relations added
relation(X, Y, 'Step Father') :- step_father(X, Y).
relation(X, Y, 'Step Mother') :- step_mother(X, Y).
relation(X, Y, 'Step Brother') :- step_brother(X, Y).
relation(X, Y, 'Step Sister') :- step_sister(X, Y).

% Optional
relation(X,Y,'Self') :- X = Y.

% ------------------------
% Query with Cut
% ------------------------
what_is(Person1, Person2) :-
    relation(Person1, Person2, Rel), !,
    format('~w is the ~w of ~w.~n', [Person1, Rel, Person2]).

what_is(Person1, Person2) :-
    format('No relationship found between ~w and ~w.~n', [Person1, Person2]).


