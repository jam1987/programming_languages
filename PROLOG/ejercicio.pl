reverso([],[]).
reverso([H|T],L):- reverso(T,L1), append(L1,[H],L).

concat(L,L1):- concatAux(L,[],L1).

concatAux([],Acc, Acc).
concatAux([H|T],Acc,L1):- append(Acc,H,Acc1), concatAux(T,Acc1,L1).

divides(X,Y):- X1 is X mod Y, X1=:=0.

head([H|_],H).



primes(X):- primesAux(X,1,[Z,Y]), Z==1, Y==X.  


primesAux(X,Y,_):- X<Y.
primesAux(X,Y,[Y|T]):- Y=<X, divides(X,Y), Y1 is Y+1, primesAux(X,Y1,T).
 
padres(juan,monica,pedro).
padres(pedro,sonia,hector).
abuelos(X,Y):- padres(X,_,Z),padres(Z,_,Y).
abuelos(X,Y):- padres(_,X,Z),padres(Z,_,Y).
abuelos(X,Y):- padres(X,_,Z), padres(_,Z,Y).
abuelos(X,Y):- padres(_,X,Z), padres(_,Z,Y).


ascendiente(X,Y):- padres(X,_,Y).
ascendiente(X,Y):- padres(_,X,Y).
ascendiente(X,Y):- padres(X,_,Z), ascendiente(Z,Y).
ascendiente(X,Y):- padres(_,X,Z), ascendiente(Z,Y).

longitud([],0).
longitud([_|T],N):- longitud(T,N1), N is N1+1.

concatenar([],Y,Y).
concatenar(X,[],X).
concatenar([X|XS],[Y|YS],[X,Y|R]):- XS == [], concatenar(YS,[],R).
concatenar([X|XS],[Y|YS],[X|R]) :- XS\==[], concatenar(XS,[Y|YS],R).

merge([],Y,Y).
merge(X,[],X).
merge([X|T],[Y|T1],[X|R]):- X<Y, merge(T,[Y|T1],R).
merge([X|T],[Y|T1],[Y|R]):- X>Y, merge([X|T],T1,R).
merge([X|T],[Y|T1],[X|R]):- X=:=Y, merge(T,[Y|T1],R).

edad(javier,14).
edad(sofia,26).
edad(mariana,13).
edad(andres,19).

mas_viejo(Persona,X):- edad(Persona,X), not(mayor(X)).

mayor(X):- edad(_,Y), Y>X.
  
contador(Acc):- edad(_,_), Acc1 is Acc+1, contador(Acc1).
