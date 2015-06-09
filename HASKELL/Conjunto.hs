-- Nombre del Archivo : Conjunto.hs

type Conjunto a = a -> Bool 

vacio :: Conjunto a 
vacio = (\x -> False)

miembro :: Conjunto a -> a -> Bool
miembro c a = c a

union :: Conjunto a -> Conjunto a -> Conjunto a
union c1 c2 = (\x-> (c1(x)) || (c2(x))) 

interseccion :: Conjunto a -> Conjunto a -> Conjunto a
interseccion c1 c2 = (\x-> (c1(x)) && (c2(x)))

singleton :: (Eq a) => a -> Conjunto a
singleton y = (\x -> x==y)

-- desdeLista :: (Eq a) => [a] -> Conjunto a
-- desdeLista [z] = (\x-> foldr (singleton x) True [z])

 
complemento :: Conjunto a -> Conjunto a
complemento c1 = (\x -> not(miembro c1 x))

diferencia :: Conjunto a -> Conjunto a -> Conjunto a
diferencia c1 c2 = (\z -> (miembro c1 z) && not(miembro c1 z))

