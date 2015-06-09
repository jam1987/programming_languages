module Oraculo (Oraculo(..),
                crearPrediccion,
                crearPregunta,
                prediccion,
                pregunta,
                positivo,
                negativo,
                obtenerCadena
) where

data Oraculo = Pregunta String Oraculo Oraculo | Prediccion String deriving (Show, Read)



crearPrediccion :: String -> Oraculo
crearPrediccion a =  Prediccion a

-- crearPregunta :: String -> Oraculo -> Oraculo -> ()
crearPregunta :: String -> Oraculo -> Oraculo-> Oraculo
crearPregunta s o1 o2 = Pregunta s  o1 o2

prediccion :: Oraculo -> String
prediccion (Prediccion s) = s
prediccion (Pregunta s a b) = error "El argumento no es de tipo Prediccion"

pregunta :: Oraculo -> String
pregunta (Pregunta s a b) = s
pregunta (Prediccion _) = error "El argumento no es de tipo Pregunta"

positivo :: Oraculo -> Oraculo
positivo (Pregunta s p _) = p
positivo (Prediccion _) = error "El argumento no es de tipo Pregunta"

negativo :: Oraculo -> Oraculo
negativo (Pregunta s _ n) = n
negativo (Prediccion _) = error "El argumento no es de tipo Pregunta"

    
obtenerCadena :: Oraculo -> String -> Maybe [(String,Bool)]
obtenerCadena o1 s = (obtenerAux o1 s [] [])
  where obtenerAux (Prediccion s) pred (x:xs) (l:ls)
         | s == pred = if (snd x) == True then Just (reverse (x:xs))
                       else obtenerAux l pred (x:xs) ls
         | otherwise = obtenerAux l pred (x:xs) ls
        obtenerAux (Pregunta pr o1 o2) pred [] [] = obtenerAux o1 pred [(pr,True)] [(Pregunta pr o1 o2)]
        obtenerAux (Pregunta pr o1 o2) pred (x:xs) (l:ls) 
         | (fst x) == pr && (snd x) == True  = obtenerAux o2 pred ([(pr,False)]++xs) ([(Pregunta pr o1 o2)]++(ls))
         | (fst x) == pr && (snd x) == False = obtenerAux l pred (x:xs) ls
         | otherwise                         = obtenerAux o1 pred ([(pr,True)]++(x:xs)) ([(Pregunta pr o1 o2)]++(ls))
        obtenerAux (Pregunta pr o1 o2) pred (x:xs) []
         | (fst x) == pr && (snd x) == True  = obtenerAux o2 pred ([(pr,False)]++xs) ([(Pregunta pr o1 o2)]++[])
         | (fst x) == pr && (snd x) == False = Nothing
         | otherwise                         = obtenerAux o1 pred ([(pr,True)]++(x:xs)) ([(Pregunta pr o1 o2)]++[])
                                                            
                                                            
                                                              
 