Bacon.pl
Julio De Abreu 05-38072
Williams Mariño 06-3986

ceros(Tamano,ListaCero)
Es un predicado que nos permite crear la lista de "ceros" que luego sera sustituida para ser lista de instrucciones a interpretar.

cerosAux
Es un predicado que recibe una lista y verifica que la lista creada es de puros 0's, sirve para ayudar a "ceros(Tamano,ListaCero)"

primero(Lista, Cabeza)
Es un predicado que nos permite identificar la cabeza de la lista

quitar(Cantidad,ListaOriginal,ListaResultado)
Es un predicado que nos permite quitar una cantidad de elementos a la lista original y verificar que el resultado sea ListaResultado

quitarUltimo
Es un predicado que recibe como parametros una listaA y una listaB, donde la lista A es la original y la lista B es como deberia quedar, con esto nos aseguramos que el predicado retire el ultimo elemento de la lista A.

sublista(ListaOriginal, Inferior, Superior,ListaResultado)
Es un predicado que nos permite obtener una sublista de ListaOriginal, indicando unos limites (Inferior y Superior).

buscar(Elemento,ListaInstrucciones,ListaResultado)
Es un predicado que permite buscar Elemento en ListaInstrucciones, y en ListaResultado nos da las posiciones de la ListaInstrucciones en las que se encuentra.

buscarAux(Elemento,Contador,ListaInstrucciones,ListaResultado)
Es un predicado auxiliar para buscar en donde implementamos un "contador" para saber en que posicion de la lista nos encontramos a medida que se busca el elemento.

Ejecutar/4
Es el predicado fundamental, ya que a través de el nos movemos dentro de la lista de instrucciones según sea los caracteres de Brainfck que vamos interpretando por codigo ASCII, donde 43 (+), 44(,),  45(-), 46(.), 60(<), 62(>), 91([), 93(]) y siguiendo las reglas de lo que hace cada una de estas instrucciones en Brainfck se procede.Cualquier caracter que no sea entre los mencionados es tomado como comentario

ejecutarCiclo
Es un predicado auxiliar que nos permite movernos en los ciclos, saber en que nivel se está de anidamiento, el estado actual, el estado posterior y un Històrico que nos permite saber que instrucciones se han ejecutado, esto es fundamental para saber en que iteraciòn del ciclo nos encontramos.

ejecutar/2

leer
Nos permite obtener la lista de instrucciones de codigo brainfck

brainfk
Es un predicado inicial, ya que el se encarga de abrir el archivo.txt con el codigo Brainfck y pasarlo a ListaInstrucciones para comenzar la ejecucion del programa con ejecutar/2 que a su vez llama ejecutar/4.


 
