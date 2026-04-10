
% Rule: American selling weapon to hostile nation is criminal
criminal(X) :-
american(X),
weapon(Y),
sells(X,Y,Z),
hostile(Z).

% Enemy of America is hostile
hostile(X) :-
enemy(X,america).

% Missile is a weapon
weapon(X) :-
missile(X).

% Facts
american(west).
enemy(nono,america).

% Nono has a missile
missile(m1).
has(nono,m1).

% All missiles of Nono were sold by West
sells(west,Y,nono) :-
missile(Y),
has(nono,Y).
