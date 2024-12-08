% a) suma/3
suma(zero, Y, Y).
suma(next(X), Y, next(Z)) :- suma(X, Y, Z).

% b) resta/3
resta(X, zero, X).
resta(next(X), next(Y), Z) :- resta(X, Y, Z).

% c) producto/3
producto(zero, _, zero).
producto(next(X), Y, Z) :- producto(X, Y, W), suma(W, Y, Z).