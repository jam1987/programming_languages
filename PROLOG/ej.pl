hombre(juan).
hombre(pedro).
mujer(maria).
mujer(juana).
madre(juana,pedro).
madre(maria,juan).
madre(petra,maria).
madre(petra,juana).
abuela(X,Y):- madre(X,Z), madre(Z,Y).
