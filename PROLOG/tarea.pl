

%% Implantacion del predicado sumar
sumar(estrella,X,X).
sumar(X,estrella,X).
sumar(up(X),Y,up(Z)):-sumar(X,Y,Z).

%% Implantacion del predicado restar
restar(estrella,X,X).
restar(up(X), Y, Z):-restar(X,Y,Z).

%% Implantacion del predicado multiplicar
multiplicar(_,estrella,estrella).
multiplicar(up(estrella),X,X).
multiplicar(X,up(Y),Z):-sumar(X,Y,Z1),multiplicar(X,Z1,Z).
