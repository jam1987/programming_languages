main = putStrLn $ unlines pentagrama
-- Esta función es un ’stub’ de lo que debe hacer su programa.
-- Usted debe modificarla o sustituirla en su proyecto.
pentagrama :: [String]
pentagrama = map (replicate 150) cs
    where
        cs = "    _ _ _ _ _    "