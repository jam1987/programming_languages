-- Nombre del archivo: pokesim.hs

module Main (
main ) where




--import Pokemon
import System.IO
import System.Environment
import Data.List.Split

imprimirLista [] = putStrLn ""
imprimirLista (x:xs) = do
                          putStrLn x
                          imprimirLista xs

main :: IO()        
main = do 
  argumentos <- getArgs
  if (length argumentos/=4) then putStrLn "Error: Falta la direccion de uno de los archivos. Alto" 
                            else do
                                   especies <- readFile (argumentos!!0)     
                                   putStrLn "Fin"
                                  -- return ((map (splitOn ",") (lines especies)))     -- Tomarlo en cuenta para crearEspecie. Ya esta la lista de especies.               
       {-                            ataques <- readFile (argumentos!!1)                 
                                   return ( (map (splitOn ",") (lines ataques)))     -- Tomarlo en cuenta para crearAtaque. Ya esta la lista de ataque.       
                                   entrenador1 <- readFile (argumentos!!2)     
                                   return ( (map (splitOn ",") (lines especies)))     -- Tomarlo en cuenta para crearEspecie. Ya esta la lista de especies.               
                                   entrenador2 <- readFile (argumentos!!3)
                                   return ( (map (splitOn ",")(lines especies)))     -- Tomarlo en cuenta para crearEspecie. Ya esta la lista de especies.      
-}