% Definición de arcos
arco(a, b).
arco(a, c).
arco(b, d).
arco(c, d).
arco(c, e).

% a) Predicado hermano
hermano(A, B) :-
    arco(C, A),
    arco(C, B),
    A \= B.

% b) Predicado alcanzable
alcanzable(A, B) :-
    alcanzable(A, B, []).

alcanzable(A, B, _) :-
    arco(A, B).

alcanzable(A, B, Visitados) :-
    arco(A, C),
    C \= B,
    \+ member(C, Visitados),
    alcanzable(C, B, [C|Visitados]).

% c) Predicado lca
lca(A, B, C) :-
    alcanzable(C, A),
    alcanzable(C, B),
    \+ (arco(C, D), alcanzable(D, A), alcanzable(D, B)).

% d) Predicado tree
tree(A) :-
    findall(Node, alcanzable(A, Node), Nodes),
    \+ ciclo(A, []),
    forall(member(Node, Nodes), unico_camino(A, Node)).

% Predicado auxiliar para verificar si hay un ciclo en el grafo
ciclo(Node, Visitados) :-
    arco(Node, Vecino),
    member(Vecino, Visitados).
ciclo(Node, Visitados) :-
    arco(Node, Vecino),
    \+ member(Vecino, Visitados),
    ciclo(Vecino, [Node|Visitados]).

% Predicado auxiliar para verificar si hay un camino unico entre A y B
unico_camino(A, B) :-
    findall(Camino, camino(A, B, [], Camino), Caminos),
    length(Caminos, 1).

% Predicado auxiliar para encontrar un camino entre A y B
camino(A, B, Visitados, [A, B]) :-
    arco(A, B),
    \+ member(A, Visitados).
camino(A, B, Visitados, [A|Camino]) :-
    arco(A, C),
    \+ member(A, Visitados),
    camino(C, B, [A|Visitados], Camino).