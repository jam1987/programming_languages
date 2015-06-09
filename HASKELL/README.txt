Nombre de los Integrantes:
De Abreu Molina, Julio 05-38072
Mariño, William 06-39856

En primer lugar, se decidio por el read y el show que vienen por defecto en la cláusula 
Deriving de Haskell, ya que la forma en que se muestra en el archivo consideramos que 
fue la más adecuada.

En Oraculo.hs:

En las primeras lineas tenemos las funciones de acceso y las de construccion. Dichas funciones
sirvieron de apoyo para la funcion Predecir, ubicada en el archivoÑ Haskinator.hs.

La siguiente funcion implementada fue obtenerCadena. Esta función toma una cadena de caracteres
y un oráculo y devuelve una lista con las preguntas necesarias para llegar a una prediccion, en caso
que la prediccion dada como parametro este dentro del oraculo. En caso contrario, regresara Nothing. 
Para ello nos valimos de una funcion auxiliar obtenerAux. Esta funcion recibe como parametros:
Un oraculo (Primer parametro), el oraculo donde se va a buscar la cadena.
El segundo parametro es la cadena de caracteres a buscar. 
El tercer parametro es una lista, la cual representa el camino guardado desde la raiz hasta la 
posicion actual.
El cuarto parametro es otra lista, esta vez es una lista de Oraculos. Esta lista la incluimos para tener 
un historico de los oraculos que fueron manipulados. Esto es, para lograr el backtracking en caso de
que algun camino fallara.
Esta funcion fue implementada con una recursion de cola.


En Haskinator.hs:

Aqui fueron creadas las siguientes funciones:

- Predecir: Esta funcion recibe dos parametros de tipo Maybe Oraculo y devuelve un parámetro de tipo
IO Oraculo. Los dos parametros fueron por lo siguiente: El primer parametro es el oraculo que se
va a manipular para poder llegar a la respuesta. El segundo parametro es el oraculo anterior. Esto es
para en caso de crear una nueva prediccion con su respectiva pregunta, poder hacer el enlace entre el oraculo
original y estos nuevos elementos. Esta funcion fue realizada con recursion de cola.

- Igualdad: Esta funcion fue creada como ayuda para la opcion de Pregunta Crucial. Esto es porque obtenerCadena 
nos devuelve algo de tipo [(String,Bool)], la cual es la lista de preguntas. Por consiguiente, al tener dos listas
necesitabamos ir elemento por elemento chequeando que el primer elemento de cada tupla coincida. Esta funcion chequea una sola
tupla.

- first, second y third: Estas funciones fueron implementadas para obtener el primero, el segundo y el tercer elemento res-
pectivamente de una 3-tupla. Esto es para poder extraer los numeros que devuelve obtenerEstadisticas.

- obtenerMin, obtenerMax: Con estas dos funciones se obtienen el minimo y el maximo de preguntas que se necesita
para llegar a una prediccion dada.

- obtenerEstadisticas: combina obtenerMin y obtenerMax para obtener las estadisticas para un oraculo dado.

- mapTwice: Funcion de orden Superior creada para poder aplicar en un futuro la funcion igualdad a las dos listas para
obtener la pregunta crucial. Recibe como entrada la funcion a aplicar y las dos listas.

- obtenerCadenaAux: Esta funcion aplica obtenerCadena a un Maybe Oraculo, esto es dado que lo que se tiene es un Maybe Oraculo.

- escribir: Esta funcion es la que se encarga de escribir el oraculo actual en un archivo de texto. El formato de impresion del
archivo es el que trae por defecto el Show derivado. 

- menu: Esta funcion es el menu del programa y ejecuta cada una de las opciones señaladas en el enunciado del proyecto. NOTA:
La opcion 7, de salir del programa no esta funcionando del todo bien, ya que no se sale del programa. Para salir del programa
se debe presionar varias veces la tecla ENTER. 

- main: Es la funcion principal del programa. Esta funcion se encarga de llamar a menu.

Finalmente, para ejecutar el programa, primero el Makefile, a traves de la instruccion make, y luego: ./haskinator.