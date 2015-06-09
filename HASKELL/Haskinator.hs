-- Nombre del archivo: pokesim.hs

module Main (
main ) where

import Pokemon
import System.IO

	            

--menu :: fIRMA POR DEFINIR 
--menu  = do
  {-putStrLn "Hola. Bienvenido al simulador de Batallas de Pokemon. Que Desea Hacer?"
  putStrLn "1) Para "
  putStrLn "2) Para Predecir"
  putStrLn "3) Para Persistir"
  putStrLn "4) Para Cargar un Archivo"
  putStrLn "5) Para Consultar una Pregunta Crucial"
  putStrLn "6) Para Consultar Estadisticas"
  putStrLn "7) Para Salir de Haskinator"
  x <- getLine
  case x of
    "1" -> do
      --crearOraculo
      menu Nothing Nothing
    "2" -> do
      predecir or1 orActual
      menu or1 orActual
    "3" -> do
             escribir orActual
	     menu or1 orActual 
    "4" -> do
             putStrLn "Introduzca el nombre del archivo a abrir:"
             nombreArchivo <- getLine
             archivo <- openFile nombreArchivo ReadMode
             oraculo <- hGetContents archivo
             menu  (Just (read oraculo)) Nothing

    "5" -> do
      putStrLn "Introduzca la primera cadena"
      cadena1 <- getLine
      putStrLn "Introduzca la segunda cadena"
      cadena2 <- getLine
      preguntaCrucial <- preguntaCrucial (obtenerCadenaAux orActual cadena1) (obtenerCadenaAux orActual cadena2)
      case preguntaCrucial of
        "" -> putStrLn "Error. No hay pregunta crucial coincidente"
        _ ->  do
                putStrLn "La pregunta crucial es la siguiente: "
                putStrLn preguntaCrucial

      menu or1 orActual
    "6" -> do
             estadisticas <- obtenerEstadisticas orActual
             if (first(estadisticas)==0) then putStrLn "Error. El oraculo esta vacio"
             else do
                    putStrLn "Las estadisticas arrojadas son las siguientes:"
                    putStrLn "El numero minimo de Preguntas para llegar a una Prediccion es:"
                    putStrLn (show $ first estadisticas)
                    putStrLn "El numero promedio de Preguntas para llegar a una Prediccion es:"
                    putStrLn (show $ second estadisticas)
                    putStrLn "El numero maximo de Preguntas para llegar a una Prediccion es:"
                    putStrLn (show $ third estadisticas)
             menu or1 orActual

      
    _ -> do
      putStrLn "Gracias por usar Haskinator"
      putStrLn "Hasta Luego!"
      return (Prediccion "")
-}

main :: IO()        
main = do 
  argumentos <- getArgs
  if (length argumentos!=4) then putStrLn "Error: Falta la direccion de uno de los archivos. Alto" 
                            else do
                                   putStrLn "Archivos leidos"                    
                              
