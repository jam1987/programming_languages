

%% Implantacion del predicado ceros(+Tamano,-ListaCero). Este predicado triunfa si
%% ListaCero es el resultado de construir una lista de ceros de tamano Tamano.
ceros(Tamano,ListaCero):- 
    TamanoLista is Tamano-1, 
    length(ListaCero,TamanoLista), 
    cerosAux(ListaCero).

%% Implantacion del predicado auxiliar cerosAux(?Ceros). Triunfa si se construye la
%% lista de Ceros.
cerosAux([]).
cerosAux([Elemento|Resto]):-
    Elemento is 0,
    cerosAux(Resto).


%% Implantacion del predicado primero(+Lista,-Cabeza). 
%% Triunfa si Cabeza es el primer elemento de la Lista que
%% recibe como parametro izquierdo.
primero([Cabeza|_],Cabeza).


%% Implantacion del predicado quitar(+Cantidad,+ListaOriginal,+ListaResultado). 
%% Este predicado triunfa si ListaNueva es el resultado 
%% de quitarle una cantidad de elementos a la lista pasada
%% como segundo parametro.
quitar(0,Lista,Lista).
quitar(Cantidad,[_|Resto],ListaNueva):- 
    Cantidad>0, 
    CantidadNueva is Cantidad-1, 
    quitar(CantidadNueva,Resto,ListaNueva).


%% Implantacion del predicado quitarUltimo. Este predicado 
%% triunfa si la segunda lista es el resultado de quitar el
%% ultimo elemento a la primera lista.
quitarUltimo([_|Resto],[]):-Resto==[].
quitarUltimo([Cabeza|Resto],[Cabeza|RestoNuevo]):- 
    Resto\==[],
    quitarUltimo(Resto,RestoNuevo).

%% Implantacion del predicado sublista(+ListaOriginal,+Inferior,+Superior,
%% -ListaResultado). 
%% Este predicado triunfa si la lista que 
%% esta como cuarto parametro es el resultado
%% de obtener la sublistaa de la primera lista, entre los Limi-
%% tes Inferior y Superior.
sublista([],_,_,[]).
sublista([CabezaListaOriginal|RestoListaOriginal],Inferior,Superior,
    [CabezaListaOriginal|RestoListaNueva]):-
        Inferior=<Superior, 
        Inferior1 is Inferior+1, 
        sublista(RestoListaOriginal,Inferior1,Superior,RestoListaNueva).
        
sublista([_|RestoListaOriginal],Inferior,Superior,ListaNueva):- 
    Inferior>Superior, 
    sublista(RestoListaOriginal,Inferior,Superior,ListaNueva).

%% Implantacion del predicado buscar(+Elemento,+ListaInstrucciones,-ListaResultado).
%% Este predicado triunfa si ListaResultado 
%% contiene las posiciones en el que aparece Ele-
%% mento en Lista.
buscar(Elemento,Lista,ListaResultado) :- 
    buscarAux(Elemento,0,Lista,ListaResultado).


%% Implantacion del predicado buscarAux(+Elemento,+Contador,+ListaInstrucciones,-ListaResultado) 
%% Este predicado triunfa si la segunda 
%% lista es el resultado de obtener las 
%% posiciones en el que ese encuentra Elemento.
buscarAux(_,_,[],[]).
buscarAux(Elemento,Contador,[Cabeza|Resto],[Contador|RestoResultante]):-
    Elemento=:=Cabeza,
    ContadorNuevo is Contador+1,
    buscarAux(Elemento,ContadorNuevo,Resto,RestoResultante).
    
buscarAux(Elemento,Contador,[Cabeza|Resto],ListaResultante):- 
    Elemento\==Cabeza,
    Contador1 is Contador+1, 
    buscarAux(Elemento,Contador1,Resto,ListaResultante).


%% Implantacion del predicado ejecutar/4. Este 
ejecutar(_,estado([],Actuali,_), [InstruccionActual|Resto], estado([],Actualf,_)) :- 
    Resto==[],
    InstruccionActual =:= 43,
    Actualf is Actuali+1.
    
ejecutar(_,estado([],Actuali,_), [InstruccionActual|Resto], estado([],Actuali,_)) :- 
    Resto==[],
    InstruccionActual =:= 44,
    get(Actuali).
    
ejecutar(_,estado([],Actuali,Posteriori), [InstruccionActual|Resto], 
    estado([],Actualf,Posteriori)) :- 
        Resto==[],
        InstruccionActual =:= 45, 
        Actualf is Actuali-1.
    
ejecutar(_,estado([],Actuali,Posteriori), [InstruccionActual|Resto], 
    estado(Anteriorf,Actualf,Posteriorf)) :-
        Resto==[], 
        InstruccionActual =:= 62, 
        append([],[Actuali],Anteriorf), 
        primero(Posteriori,Actualf),
        quitar(1,Posteriori,Posteriorf).
    
ejecutar(_,estado([],Actuali,Posteriori), [InstruccionActual|Resto], 
    estado([],Actuali,Posteriori)) :-
        Resto==[],
        InstruccionActual =:= 60.
    
ejecutar(_,estado([],Actuali,Posteriori), [InstruccionActual|Resto], 
    estado([],Actuali,Posteriori)) :- 
        Resto==[], 
        InstruccionActual=:= 46, 
        char_code(Valor,Actuali), 
        print(Valor).

ejecutar(_,estado(Anteriori,Actuali,Posteriori), [InstruccionActual|Resto], 
    estado(Anteriori,Actualf,Posteriori)) :- 
         Resto==[],
         InstruccionActual =:= 43,
         Actualf is Actuali+1.
         
ejecutar(_,estado(Anteriori,Actuali,Posteriori), [InstruccionActual|Resto], 
    estado(Anteriori,Actuali,Posteriori)) :- 
         Resto==[],
         InstruccionActual =:= 44,
         get(Actuali).
    
ejecutar(_,estado(Anteriori,Actuali,Posteriori), [InstruccionActual|Resto], estado(Anteriori,Actualf,Posteriori)) :- 
    Resto==[],
    InstruccionActual =:= 45, 
    Actualf is Actuali-1.
    
ejecutar(_,estado(Anteriori,Actuali,Posteriori), [InstruccionActual|Resto], 
    estado(Anteriorf,Actualf,Posteriorf)) :-
        Resto==[], 
        InstruccionActual =:= 62, 
        append(Anteriori,[Actuali],Anteriorf), 
        primero(Posteriori,Actualf),
        quitar(1,Posteriori,Posteriorf).
    
ejecutar(_,estado(Anteriori,Actuali,Posteriori), [InstruccionActual|Resto], 
    estado(Anteriorf,Actualf,Posteriorf)) :- 
         Resto==[],
         InstruccionActual =:= 60, 
         append(Posteriori,[Actuali],Posteriorf),
         primero(Anteriori,Actualf),
         quitar(1,Anteriori,Anteriorf).
    
ejecutar(_,estado(Anteriori,Actuali,Posteriori), [InstruccionActual|Resto], 
    estado(Anteriori,Actuali,Posteriori)) :- 
         Resto==[], 
         InstruccionActual=:= 46, 
         char_code(Valor,Actuali), 
         print(Valor).

ejecutar(Nivel,estado([],Actuali,Posteriori), [InstruccionActual|Resto], 
    estado([],Actualf,Posteriori)) :- 
         InstruccionActual =:= 43,
         Actualf is Actuali+1,
         ejecutar(Nivel,estado([],Actualf,Posteriori), Resto, _).
         
ejecutar(Nivel,estado([],Actuali,Posteriori), [InstruccionActual|Resto], 
    estado([],Actuali,Posteriori)) :- 
         InstruccionActual =:= 44,
         get(Actuali),
         ejecutar(Nivel,estado([],Actuali,Posteriori), Resto, _).
    
ejecutar(Nivel,estado([],Actuali,Posteriori), [InstruccionActual|Resto], 
    estado([],Actualf,Posteriori)) :- 
        InstruccionActual =:= 45, 
        Actualf is Actuali-1,
        ejecutar(Nivel,estado([],Actualf,Posteriori), Resto, _).
    
ejecutar(Nivel,estado([],Actuali,Posteriori), [InstruccionActual|Resto], 
    estado([Actuali],Actualf,Posteriorf)) :-
        InstruccionActual =:= 62,  
        primero(Posteriori,Actualf),quitar(1,Posteriori,Posteriorf),
        ejecutar(Nivel,estado([Actuali],Actualf,Posteriorf), Resto, _).
    
ejecutar(Nivel,estado([],Actuali,Posteriori), [InstruccionActual|Resto], 
estado([],Actuali,Posteriori)) :- 
    InstruccionActual =:= 60,
    ejecutar(Nivel,estado([],Actuali,Posteriori), Resto, _).
    
ejecutar(Nivel,estado([],Actuali,Posteriori), [InstruccionActual|Resto],
    estado([],Actuali,Posteriori)) :- 
        InstruccionActual=:= 46, 
        char_code(Valor,Actuali), 
        print(Valor),
        ejecutar(Nivel,estado([],Actuali,Posteriori), Resto,_).

ejecutar(Nivel,estado(Anteriori,Actuali,Posteriori),[InstruccionActual|Resto],
    estado(Anteriori,Actualf,Posteriori)) :- 
         InstruccionActual =:= 43, 
         Actualf is Actuali +1,
         ejecutar(Nivel,estado(Anteriori,Actualf,Posteriori), Resto, _).

ejecutar(Nivel,estado(Anteriori,Actuali,Posteriori),[InstruccionActual|Resto],
    estado(Anteriori,Actuali,Posteriori)) :- 
         InstruccionActual =:= 44, 
         get(Actuali),
         ejecutar(Nivel,estado(Anteriori,Actuali,Posteriori), Resto, _).
    
ejecutar(Nivel,estado(Anteriori,Actuali,Posteriori),[InstruccionActual|Resto],
    estado(Anteriori,Actualf,Posteriori)) :-  
        InstruccionActual =:= 45, 
        Actualf is Actuali -1,
        ejecutar(Nivel,estado(Anteriori,Actualf,Posteriori), Resto, _).
    
ejecutar(Nivel,estado(Anteriori,Actuali,Posteriori),[InstruccionActual|Resto],
    estado(Anteriori,Actuali,Posteriori)) :- 
    InstruccionActual=:= 46, 
    char_code(Valor,Actuali), 
    print(Valor),
    ejecutar(Nivel,estado(Anteriori,Actuali,Posteriori), Resto, _).
    
ejecutar(Nivel,estado(Anteriori,Actuali,Posteriori), [InstruccionActual|Resto], 
    estado(Anteriorf,Actualf,Posteriorf)) :- 
         InstruccionActual =:= 62, 
         append(Anteriori,[Actuali],Anteriorf), 
         primero(Posteriori,Actualf),quitar(1,Posteriori,Posteriorf),
         ejecutar(Nivel,estado(Anteriorf,Actualf,Posteriorf), Resto, _).
    
ejecutar(Nivel,estado(Anteriori,Actuali,Posteriori), [InstruccionActual|Resto], 
    estado(Anteriorf,Actualf,Posteriorf)) :- 
         InstruccionActual =:= 60,
         last(Anteriori,Actualf), 
         append([Actuali],Posteriori,Posteriorf), 
         quitarUltimo(Anteriori,Anteriorf), 
         ejecutar(Nivel,estado(Anteriorf,Actualf,Posteriorf), Resto, _).
    
ejecutar(Nivel,estado(Anteriori,Actuali,Posteriori),[InstruccionActual|Resto],
    estado(Anteriori,Actuali,Posteriori)) :- 
        InstruccionActual=:= 91, 
        Actuali\==0, 
        NivelNuevo is Nivel+1,
        buscar(93,Resto,ListaPosicionesCorcheteCierra), 
        last(ListaPosicionesCorcheteCierra,Superior),
        Superior1 is Superior+1, 
        sublista(Resto,0,Superior1,Ciclo),
        quitar(Superior,Resto,RestoProgramaDespuesCiclo),
        ejecutarCiclo(NivelNuevo,estado(Anteriori,Actuali,Posteriori),[],Ciclo,_,
        RestoProgramaDespuesCiclo,_).
    
ejecutar(Nivel,estado(Anteriori,Actuali,Posteriori),[InstruccionActual|Resto],
    estado(Anteriori,Actuali,Posteriori)) :- 
        InstruccionActual=:=91, 
        Actuali=:=0,
        NivelNuevo is Nivel-1, 
        buscar(93,Resto,ListaPosicionesCorcheteAbre), 
        last(ListaPosicionesCorcheteAbre,Superior), 
        Superior1 is Superior+1, 
        quitar(Superior1,Resto,RestoDespuesCiclo), 
        ejecutar(NivelNuevo,estado(Anteriori,Actuali,Posteriori), RestoDespuesCiclo, _).
    
ejecutar(Nivel,estado(Anteriori,Actuali,[]),[InstruccionActual|Resto],
    estado(Anteriori,Actuali,[])) :-  
        InstruccionActual =:= 62, 
        ejecutar(Nivel,estado(Anteriori,Actuali,[]), Resto, _).
        
ejecutar(Nivel,estado(Anteriori,Actuali,[]),[InstruccionActual|Resto],
    estado(Anteriori,Actuali,[])) :-  
        InstruccionActual =:= 60, 
        last(Anteriori,Actualf), 
        append([Actuali],[],Posteriorf), 
        quitarUltimo(Anteriori,Anteriorf), 
        ejecutar(Nivel,estado(Anteriorf,Actualf,Posteriorf), Resto, _).
        
ejecutar(Nivel,estado(Anteriori,Actuali,[]),[InstruccionActual|Resto],
    estado(Anteriori,Actualf,[])) :- 
         InstruccionActual =:= 43, 
         Actualf is Actuali +1,
         ejecutar(Nivel,estado(Anteriori,Actualf,[]), Resto, _).

ejecutar(Nivel,estado(Anteriori,Actuali,[]),[InstruccionActual|Resto],
    estado(Anteriori,Actuali,[])) :- 
         InstruccionActual =:= 44, 
         get(Actuali),
         ejecutar(Nivel,estado(Anteriori,Actuali,[]), Resto, _).
    
ejecutar(Nivel,estado(Anteriori,Actuali,[]),[InstruccionActual|Resto],
    estado(Anteriori,Actualf,[])) :-  
        InstruccionActual =:= 45, 
        Actualf is Actuali -1,
        ejecutar(Nivel,estado(Anteriori,Actualf,[]), Resto, _).
        
ejecutar(Nivel,estado(Anteriori,Actuali,Posteriori),[InstruccionActual|Resto],
    estado(Anteriori,Actuali,Posteriori)) :-  
        InstruccionActual \== 60,
        InstruccionActual \==91,
        InstruccionActual \==93,
        InstruccionActual \==62,
        InstruccionActual \==43,
        InstruccionActual \==44,
        InstruccionActual \==45,
        InstruccionActual \==46, 
        ejecutar(Nivel,estado(Anteriori,Actuali,Posteriori), 
        Resto,estado(Anteriori,Actuali,Posteriori)).

ejecutar(Nivel,estado([],Actuali,Posteriori),[InstruccionActual|Resto],
    estado([],Actuali,Posteriori)) :-  
        InstruccionActual \== 60,
        InstruccionActual \==91,
        InstruccionActual \==93,
        InstruccionActual \==62,
        InstruccionActual \==43,
        InstruccionActual \==44,
        InstruccionActual \==45,
        InstruccionActual \==46, 
        ejecutar(Nivel,estado([],Actuali,Posteriori), 
        Resto,estado([],Actuali,Posteriori)).

ejecutar(Nivel,estado(Anteriori,Actuali,[]),[InstruccionActual|Resto],
    estado(Anteriori,Actuali,[])) :-  
        InstruccionActual \== 60,
        InstruccionActual \==91,
        InstruccionActual \==93,
        InstruccionActual \==62,
        InstruccionActual \==43,
        InstruccionActual \==44,
        InstruccionActual \==45,
        InstruccionActual \==46, 
        ejecutar(Nivel,estado(Anteriori,Actuali,[]), 
        Resto,estado(Anteriori,Actuali,[])).
%% Implantacion del Predicado auxiliar 
%% ejecutarCiclo(+Nivel,+estado(Inicial,Actual,Final),+Historico,+InstruccionesCiclo,
%% +RestoInterno,+Resto,?estado(Inicial1,Actual1,Final1)).
%% Este predicado se satisface si logra ejecutar las instrucciones que estan entre los 
%% corchetes. El primer parametro es el numero de niveles, el segundo parametro es el
%% estado inicial, el tercer parametro es un Historico de las instrucciones del ciclo 
%% que ha ejecutado. El cuarto parametro es la lista de instrucciones actual, El quinto
%% parametro es para llevar el Resto Interno en caso de tener ciclos anidados. El sexto 
%% parametro es el estado final.
ejecutarCiclo(Nivel,estado([],Actuali,Posteriori),Historico, [CabezaCiclo|RestoCiclo],_,
    Resto,estado([],Actualf,Posteriori)):- 
        CabezaCiclo =:= 43, 
        Actualf is Actuali +1, 
        append(Historico,[CabezaCiclo],Historico1), 
        ejecutarCiclo(Nivel,estado([],Actualf,Posteriori),Historico1,RestoCiclo,_,
        Resto,_).
        
ejecutarCiclo(Nivel,estado([],Actuali,Posteriori),Historico, [CabezaCiclo|RestoCiclo],_,
    Resto,estado([],Actuali,Posteriori)):- 
        CabezaCiclo =:= 44, 
        get(Actuali), 
        append(Historico,[CabezaCiclo],Historico1), 
        ejecutarCiclo(Nivel,estado([],Actuali,Posteriori),Historico1,RestoCiclo,_,
        Resto,_).
    
ejecutarCiclo(Nivel,estado([],Actuali,Posteriori),Historico, [CabezaCiclo|RestoCiclo],_,
    Resto,estado([],Actualf,Posteriori)):-
        CabezaCiclo =:= 45, 
        append(Historico,[CabezaCiclo],Historico1), 
        Actualf is Actuali -1, 
        ejecutarCiclo(Nivel,estado([],Actualf,Posteriori),Historico1,RestoCiclo,_,
        Resto,_).
    
ejecutarCiclo(Nivel,estado([],Actuali,Posteriori),Historico, [CabezaCiclo|RestoCiclo],_,
    Resto,estado([],Actualf,Posteriorf)):-  
        CabezaCiclo =:=62, 
        append(Historico,[CabezaCiclo],Historico1), 
        append([],[Actuali],Anteriorf), 
        primero(Posteriori,Actualf),
        quitar(1,Posteriori,Posteriorf), 
        ejecutarCiclo(Nivel,estado(Anteriorf,Actualf,Posteriorf),Historico1,RestoCiclo,
        _,Resto,_).
    
ejecutarCiclo(Nivel,estado([],Actuali,Posteriori),Historico, [CabezaCiclo|RestoCiclo],_,
    Resto,estado([],Actualf,Posteriorf)):-  
        CabezaCiclo =:=60, 
        append(Historico,[CabezaCiclo],Historico1),
        last(Anteriori,Actualf), 
        append([Actuali],Posteriori,Posteriorf), 
        quitarUltimo(Anteriori,Anteriorf), 
        ejecutarCiclo(Nivel,estado(Anteriorf,Actualf,Posteriorf),Historico1,
        RestoCiclo,_,Resto,_).
    
ejecutarCiclo(Nivel,estado([],Actuali,Posteriori),Historico, [CabezaCiclo|RestoCiclo],_,
    Resto,estado([],Actuali,Posteriori)):- 
        CabezaCiclo=:= 46, 
        append(Historico,[CabezaCiclo],Historico1), 
        char_code(Valor,Actuali), 
        print(Valor), 
        ejecutarCiclo(Nivel,estado([],Actuali,Posteriori),Historico1,RestoCiclo,_,Resto,_).
    
ejecutarCiclo(Nivel,estado([],Actuali,Posteriori),_, [CabezaCiclo|_],_,Resto,
    estado([],Actuali,Posteriori)):- 
        CabezaCiclo=:=93, 
        Actuali=:=0, 
        NivelNuevo is Nivel-1,
        quitar(1,Resto,Resto1), 
        ejecutar(NivelNuevo,estado([],Actuali,Posteriori),Resto1,_).
    
ejecutarCiclo(Nivel,estado([],Actuali,Posteriori),Historico, [CabezaCiclo|_],_,Resto,
    estado([],Actuali,Posteriori)):- 
        CabezaCiclo=:=93,  
        Actuali\==0,
        append(Historico,[CabezaCiclo],Historico1), 
        ejecutarCiclo(Nivel,estado([],Actuali,Posteriori),[],Historico1, _,Resto,_).
    
ejecutarCiclo(Nivel,estado([],Actuali,Posteriori),_, [CabezaCiclo|_],_,Resto,
    estado([],Actuali,Posteriori)) :-
        CabezaCiclo=:=91,  
        Actuali=:=0, 
        NivelNuevo is Nivel-1, 
        ejecutar(NivelNuevo,estado([],Actuali,Posteriori),Resto, _). 
 

    
ejecutarCiclo(Nivel,estado([],Actuali,Posteriori),Historico, [CabezaCiclo|_],_,Resto,
    estado([],Actuali,Posteriori)) :- 
        CabezaCiclo=:=91,
        Actuali\==0,  
        buscar(91,Historico,Result), 
        length(Result,Tam), 
        Tam1 is Tam+1, 
        Tam1=:=Nivel,
        append(Historico,[CabezaCiclo],Historico1), 
        ejecutarCiclo(Nivel,estado([],Actuali,Posteriori),[],Historico1 , _,Resto,_).
    
ejecutarCiclo(Nivel,estado([],Actuali,Posteriori),Historico, [CabezaCiclo|_],RestoInterno,
    Resto,estado([],Actuali,Posteriori)) :- 
        CabezaCiclo=:=91,  
        Actuali\==0, 
        buscar(91,Historico,Result), 
        length(Result,Tam), 
        Tam1 is Tam+1, 
        Tam1\==Nivel, 
        NivelNuevo is Nivel+1,
        append(RestoInterno,Resto,L), 
        buscar(93,L,ListaPosicionesCorcheteCierra), 
        primero(ListaPosicionesCorcheteCierra,Superior),
        sublista(T,0,Superior,Ciclo),
        quitar(Superior,T,RestoInterno),
        ejecutarCiclo(NivelNuevo,estado([],Actuali,Posteriori),[],Ciclo,
        RestoInterno,Resto,_).

ejecutarCiclo(Nivel,estado(Anteriori,Actuali,Posteriori),Historico, 
    [CabezaCiclo|RestoCiclo],_,Resto,estado(Anteriori,Actualf,Posteriori)):-  
        CabezaCiclo =:= 43, 
        append(Historico,[CabezaCiclo],Historico1),
        Actualf is Actuali +1, 
        ejecutarCiclo(Nivel,estado(Anteriori,Actualf,Posteriori),Historico1,
        RestoCiclo,_,Resto,_).
        
ejecutarCiclo(Nivel,estado(Anteriori,Actuali,Posteriori),Historico, 
    [CabezaCiclo|RestoCiclo],_,Resto,estado(Anteriori,Actuali,Posteriori)):-  
        CabezaCiclo =:= 44, 
        append(Historico,[CabezaCiclo],Historico1),
        get(Actuali),
        ejecutarCiclo(Nivel,estado(Anteriori,Actuali,Posteriori),Historico1,
        RestoCiclo,_,Resto,_).
    
ejecutarCiclo(Nivel,estado(Anteriori,Actuali,Posteriori),Historico, 
    [CabezaCiclo|RestoCiclo],_,Resto,estado(Anteriori,Actualf,Posteriori)):- 
        CabezaCiclo =:= 45, 
        append(Historico,[CabezaCiclo],Historico1),  
        Actualf is Actuali -1, 
        ejecutarCiclo(Nivel,estado(Anteriori,Actualf,Posteriori),Historico1,
        RestoCiclo,_,Resto,_).
    
ejecutarCiclo(Nivel,estado(Anteriori,Actuali,Posteriori),Historico, 
    [CabezaCiclo|RestoCiclo],_,Resto,estado(Anteriorf,Actualf,Posteriorf)):- 
        CabezaCiclo =:=62, 
        append(Historico,[CabezaCiclo],Historico1),  
        append(Anteriori,[Actuali],Anteriorf), 
        primero(Posteriori,Actualf),quitar(1,Posteriori,Posteriorf), 
        ejecutarCiclo(Nivel,estado(Anteriorf,Actualf,Posteriorf),Historico1,RestoCiclo,
        _,Resto,_).
    
ejecutarCiclo(Nivel,estado(Anteriori,Actuali,Posteriori),Historico, 
    [CabezaCiclo|RestoCiclo],_,Resto,estado(Anteriorf,Actualf,Posteriorf)):- 
         CabezaCiclo =:=60, 
         append(Historico,[CabezaCiclo],Historico1), 
         last(Anteriori,Actualf), 
         append([Actuali],Posteriori,Posteriorf), 
         quitarUltimo(Anteriori,Anteriorf), 
         ejecutarCiclo(Nivel,estado(Anteriorf,Actualf,Posteriorf),Historico1,
         RestoCiclo,_,Resto,_).
    
ejecutarCiclo(Nivel,estado(Anteriori,Actuali,Posteriori),Historico, 
    [CabezaCiclo|RestoCiclo],_,Resto,estado(Anteriori,Actuali,Posteriori)):- 
        CabezaCiclo=:= 46, 
        char_code(Valor,Actuali), 
        print(Valor),
        append(Historico,[CabezaCiclo],Historico1),
        ejecutarCiclo(Nivel,estado(Anteriori,Actuali,Posteriori),Historico1,RestoCiclo,_,
        Resto,_).
    
ejecutarCiclo(Nivel,estado(Anteriori,Actuali,Posteriori),_, [CabezaCiclo|_],_,Resto,
    estado(Anteriori,Actuali,Posteriori)):- 
        CabezaCiclo=:=93, 
        Actuali=:=0, 
        NivelNuevo is Nivel-1, 
        ejecutar(NivelNuevo,estado(Anteriori,Actuali,Posteriori),Resto,_).
    
ejecutarCiclo(Nivel,estado(Anteriori,Actuali,Posteriori),Historico, [CabezaCiclo|_],_,
    Resto,estado(Anteriori,Actuali,Posteriori)):- 
        CabezaCiclo=:=93, 
        Actuali\==0, 
        ejecutarCiclo(Nivel,estado(Anteriori,Actuali,Posteriori),[],Historico, _,Resto,_).
        
ejecutarCiclo(Nivel,estado(Anteriori,Actuali,Posteriori),Historico, [CabezaCiclo|RestoCiclo],_,Resto,
    estado(Anteriori,Actuali,Posteriori)) :- 
        CabezaCiclo=:=91, 
        Actuali=:=0, 
        NivelNuevo is Nivel-1, 
        buscar(93,RestoCiclo,ListaResult),
        length(ListaResult,Tam),
        Tam>1,
        primero(ListaResult,Cabeza),
        Cabeza1 is Cabeza+1,
        quitar(Cabeza1,RestoCiclo,RestoInterno),
        append(Historico,[CabezaCiclo],Historico1),
        ejecutarCiclo(NivelNuevo,estado(Anteriori,Actuali,Posteriori),Historico1,RestoInterno,[],Resto, _). 
    
ejecutarCiclo(Nivel,estado(Anteriori,Actuali,Posteriori),_, [CabezaCiclo|_],_,Resto,
    estado(Anteriori,Actuali,Posteriori)) :- 
        CabezaCiclo=:=91, 
        Actuali=:=0, 
        NivelNuevo is Nivel-1, 
        ejecutar(NivelNuevo,estado(Anteriori,Actuali,Posteriori),Resto, _). 
        
    
ejecutarCiclo(Nivel,estado(Anteriori,Actuali,Posteriori),Historico, [CabezaCiclo|_],_,
    Resto,estado(Anteriori,Actuali,Posteriori)) :- 
        CabezaCiclo=:=91, 
        Actuali\==0, 
        buscar(91,Historico,Result), 
        length(Result,Tam), 
        Tam1 is Tam+1, 
        Tam1=:=Nivel, 
        append(Historico,[CabezaCiclo],Historico1), 
        ejecutarCiclo(Nivel,estado(Anteriori,Actuali,Posteriori),[],Historico1,
        _,Resto,_).
    
ejecutarCiclo(Nivel,estado(Anteriori,Actuali,Posteriori),Historico, 
    [CabezaCiclo|_],RestoInterno,Resto,estado(Anteriori,Actuali,Posteriori)) :- 
        CabezaCiclo=:=91, 
        Actuali\==0, 
        buscar(91,Historico,Result), 
        length(Result,Tam), 
        Tam1 is Tam+1, 
        Tam1\==Nivel, 
        NivelNuevo is Nivel+1,
        append(RestoInterno,Resto,L), 
        buscar(93,L,ListaPosicionesCorcheteCierra), 
        primero(ListaPosicionesCorcheteCierra,Superior),
        sublista(T,0,Superior,Ciclo),
        quitar(Superior,T,RestoInterno),
        ejecutarCiclo(NivelNuevo,estado(Anteriori,Actuali,Posteriori),[],Ciclo,
        RestoInterno,Resto,estado(Anteriori,Actuali,Posteriori)).

ejecutarCiclo(Nivel,estado([],Actuali,Posteriori),Historico, [CabezaCiclo|RestoCiclo],_,
    Resto, estado([],Actuali,Posteriori)) :- 
        InstruccionActual \== 60,
        InstruccionActual \==91,
        InstruccionActual \==93,
        InstruccionActual \==62,
        InstruccionActual \==43,
        InstruccionActual \==44,
        InstruccionActual \==45,
        InstruccionActual \==46, 
        append(Historico,[CabezaCiclo],Historico1), 
        ejecutarCiclo(Nivel,estado([],iniciali,Posteriori),Historico1,RestoCiclo , _,
        Resto,estado([],Actuali,Posteriori)).
        
ejecutarCiclo(Nivel,estado(Iniciali,Actuali,Posteriori),Historico, [CabezaCiclo|RestoCiclo],_,
    Resto, estado(Iniciali,Actuali,Posteriori)) :- 
        InstruccionActual \== 60,
        InstruccionActual \==91,
        InstruccionActual \==93,
        InstruccionActual \==62,
        InstruccionActual \==43,
        InstruccionActual \==44,
        InstruccionActual \==45,
        InstruccionActual \==46, 
        append(Historico,[CabezaCiclo],Historico1), 
        ejecutarCiclo(Nivel,estado([],iniciali,Posteriori),Historico1,RestoCiclo , _,
        Resto,estado([],Actuali,Posteriori)).

%% Implantacion del predicado ejecutar(+Tamano,-Instrucciones)/2. Este predicado triunfa
%% cuando la lista Instrucciones se ejecuta.
ejecutar(Tamano,Instrucciones) :- ceros(Tamano,Cinta), primero(Cinta,Actual), 
    quitar(1,Cinta,RestoCinta),ejecutar(0,estado([],Actual,RestoCinta),Instrucciones,_).

%% Implantacion del predicado cargar(+Archivo,-Lista)/2
cargar(Archivo,Lista):- see(Archivo),leer(Lista).

%% Implantacion del predicado auxiliar 
%% leer(?ListaInstrucciones) /1. Este predicado triunfa cuando Lista de Instrucciones
%% es la lista de instrucciones obtenida de un archivo.
leer([ValorLeido|R]):- get(ValorLeido), ValorLeido\==(-1), leer(R).
leer([]):- get(ValorLeido), ValorLeido=:=(-1).

%% Implantacion del predicado Brainfck
brainfk :- 
    repeat, 
    write('Bienvenido al Interprete de Brainfuck. Por favor introduzca el archivo:'),
    read(Archivo), 
    cargar(Archivo,ListaInstrucciones), 
    ejecutar(10,ListaInstrucciones),
    write('Gracias por usar el Interprete.'),
    seen.

 
 

 
