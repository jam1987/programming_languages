
isM(X,[X|_]).
isM(X,[F|T]):-X\=F, is(X,T).
