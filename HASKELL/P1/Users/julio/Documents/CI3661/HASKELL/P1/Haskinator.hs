-- Nombre del archivo: Haskinator.hs

module Main (
main ) where

import Oraculo
import System.IO

crearOraculo :: Maybe Oraculo
crearOraculo = Nothing

predecir :: Maybe Oraculo -> Maybe Oraculo ->  IO Oraculo
predecir Nothing Nothing = do
  putStrLn "En que estas pensando?"
  prediccion <- getLine
  putStrLn "Ok!."
  menu (Just (crearPrediccion prediccion)) Nothing
                  
predecir (Just (Prediccion s)) Nothing = do
  putStrLn "Estas pensando en lo siguiente:"
  putStrLn (prediccion (Prediccion s))
  response <- getLine
  if (response=="SI") then do
    putStrLn "Bien adivine!"
    menu (Just (Prediccion s)) (Just (Prediccion s))
  else do
    putStrLn "Dime en que estabas pensando"
    response1 <- getLine
    putStrLn "Dime una pregunta relacionada "
    pregunta <- getLine
    menu (Just (crearPregunta pregunta (crearPrediccion response1) (crearPrediccion s))) (Just (crearPregunta pregunta (crearPrediccion response1) (crearPrediccion s)))

predecir (Just (Prediccion s)) (Just (Pregunta pr1 oi od)) = do
  putStrLn "Estas pensando en lo siguiente:"
  putStrLn (prediccion (Prediccion s))
  response <- getLine
  if (response=="SI") then do
    putStrLn "Bien adivine!"
    menu (Just (Pregunta pr1 oi od)) (Just (Pregunta pr1 oi od))
  else do
    putStrLn "Dime en que estabas pensando"
    response1 <- getLine
    putStrLn "Dime una pregunta relacionada "
    pregunta <- getLine
    menu (Just (crearPregunta pregunta (crearPrediccion response1) (Pregunta pr1 oi od))) (Just (crearPregunta pregunta (crearPrediccion response1) (Pregunta pr1 oi od)))



predecir (Just (Pregunta pr o1 o2)) a = do 
  putStrLn (pregunta (Pregunta pr o1 o2))
  response <- getLine
  predecir (Just ((if response == "SI" then positivo else negativo) (Pregunta pr o1 o2) )) a
  
igualdad :: (String,Bool) -> (String,Bool) -> String
igualdad (pregunta1,_) (pregunta2,_) = if pregunta1 == pregunta2 then pregunta1
                                       else ""


first :: (a,a,a) -> a
first (x,_,_) = x

second :: (a,a,a) -> a
second (_,x,_) = x

third :: (a,a,a) -> a
third (_,_,x) = x

obtenerMin :: Oraculo  ->  Int
obtenerMin (Prediccion s) =  0
obtenerMin (Pregunta _ o1 o2) =  (1 + (min (obtenerMin o1) (obtenerMin o2)))

obtenerMax :: Oraculo ->  Int
obtenerMax (Prediccion s) =  0
obtenerMax (Pregunta _ o1 o2) =  (1 + (max (obtenerMin o1) (obtenerMin o2)))

obtenerEstadisticas :: Maybe Oraculo -> IO (Int,Int,Int)
obtenerEstadisticas Nothing = return (0,0,0)
obtenerEstadisticas  (Just oraculo) =  return (obtenerMin oraculo, (div (obtenerMin oraculo+ obtenerMax oraculo) 2),obtenerMax oraculo)                                       
                                       
mapTwice _ [] [] = []
mapTwice f [] l = []
mapTwice f l [] = []
mapTwice f (x:xs) (y:ys) = f x y : mapTwice f xs ys
  
preguntaCrucial :: Maybe [(String,Bool)] -> Maybe [(String,Bool)] -> IO String
preguntaCrucial Nothing _ = return ""
preguntaCrucial _ Nothing = return ""
preguntaCrucial (Just a) (Just b) = return (head $ reverse $ takeWhile (/="") (mapTwice igualdad a b))

obtenerCadenaAux :: Maybe Oraculo -> String -> Maybe [(String,Bool)]
obtenerCadenaAux Nothing _ = Nothing
obtenerCadenaAux (Just oraculo) cadena = obtenerCadena oraculo cadena

escribir :: Maybe Oraculo -> IO()
escribir Nothing = putStrLn "No hay Oraculo que escribir"
escribir (Just oraculo) = do
                            putStrLn "Introduzca el nombre del archivo a abrir:"
                            nombreArchivo <- getLine
                            archivo <- openFile nombreArchivo WriteMode
	                    hPrint archivo oraculo
                            hClose archivo

		            

menu :: Maybe Oraculo -> Maybe Oraculo -> IO Oraculo
menu or1 orActual = do
  putStrLn "Hola. Bienvenido a Haskinator. Que Desea Hacer?"
  putStrLn "1) Para Crear un Oraculo Nuevo"
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

main :: IO()        
main = do 
  menu Nothing Nothing
  putStrLn ""                         
                              
