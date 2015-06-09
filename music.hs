-- | module Main
module Main (
			 -- * Tipos de Datos
			 Figura,
			 Nota,
			 Compas,
			 Armadura,
			 Tiempo,
			 Musica,
			 -- * Funciones
			 toFigure,
			 toArmadura,
			 numNotas,
			 leerMusica,
			 convertirCifrado,
			 convertirAux,
			 main) where

import System.Environment
import System.IO
import Data.Char

-- | Este modulo define el tipo de datos @Figura@
data Figura = Redonda | Blanca | Negra | Corchea deriving (Eq,Show) 
												        
-- | Este modulo define el tipo de datos @Alteracion@
data Alteracion = Sostenido | Becuadro | Ninguna deriving (Eq,Show)

-- | Este modulo define el tipo de datos @Nota@
type Nota = (Int,Alteracion, Figura)

-- | Este modulo define el tipo de datos @Compas@
type Compas = [Nota]

-- | Este modulo define el tipo de datos @Armadura@
data Armadura = C | G | A | D deriving (Eq,Show)

-- | Este modulo define el tipo de datos @Tiempo@
type Tiempo = (Int, Int)  

-- | Este modulo define el tipo de datos @Musica@
type Musica = (Armadura, Tiempo, [Compas]) 


-- | 'toFigure' Transforma un entero en una @Figura@
toFigure :: Int -> Figura
toFigure n
	| n == 1 = Redonda
	| n == 2 = Blanca
	| n == 4 = Negra
	| n == 8 = Corchea
	


-- | 'toArmadura' Transforma un Caracter en una Armadura	
toArmadura :: String          --  ^ El parametro de tipo 'Char' que recibe 
							--  ^ como entrada
            -> Armadura     --  ^ Devuelve algo de tipo 'Armadura'
toArmadura c
	| head c == 'A' = A
	| head c == 'G' = G
	| head c == 'C' = C
	| head c == 'D' = D
	
	
obtenerTiempo :: [Char] -> Tiempo
obtenerTiempo x = (digitToInt(head x), digitToInt(head (tail (tail x))))

printTiempo :: Tiempo -> String
printTiempo x = showLitChar (intToDigit (fst x)) "" ++ "\n" ++
                showLitChar (intToDigit (snd x)) "" 
                
convertirCifrado :: String -> Int
convertirCifrado x
 | head x == 'A' || head x == 'a' = 69
 | head x == 'B' || head x == 'b' = 71
 | head x == 'C' || head x == 'c' = 60
 | head x == 'D' || head x == 'd' = 62
 | head x == 'E' || head x == 'e' = 64
 | head x == 'F' || head x == 'f' = 65
 | head x == 'G' || head x == 'g' = 67
  

convertirAux :: String -> Int -> Nota
convertirAux x y
 | (head (tail x)) =='\'' && head (tail (tail x)) == '#' =
                                                           (12 + y,
                                                           Sostenido,
                                                           toFigure $ digitToInt  $ head $ tail
                                                           $ tail $ tail x)
                                                           

 | (head (tail x)) =='\'' && head (tail (tail x)) == '%' =
 						  (12 + y,Becuadro,toFigure $ digitToInt  $ head $ tail  $ tail $ tail x)
 						  
 | (head (tail x)) =='\'' =
 						  (12 + y,Ninguna,toFigure $ digitToInt  $ head $ tail $ tail x)
 						  
 | head  (tail x) == '%' =
 						   (y ,Becuadro,toFigure $ digitToInt  $ head $ tail  $ tail x)
 						   
 | head (tail x) == '#' =
 							(y,Sostenido,toFigure $ digitToInt  $ head $ tail $ tail x)
 							
 | otherwise            =
 							(y,Ninguna,toFigure $ digitToInt  $ head $ tail x)
                    
obtenerNota :: String -> Nota
obtenerNota x  = convertirAux x (convertirCifrado x)

obtenerNotas :: [String] -> [Nota]
obtenerNotas xs = map obtenerNota (xs)

obtenerTiempoFigura :: Fractional a => Figura -> a
obtenerTiempoFigura x
 | x == Redonda          = 4.0
 | x == Blanca           = 2.0
 | x == Negra            = 1.0
 | x == Corchea          = 0.5
 
 
fst3 :: (a,b,c) -> a
fst3 (x,y,z) = x

snd3 :: (a,b,c) -> b
snd3 (x,y,z) = y

thd3 :: (a,b,c) -> c
thd3 (x,y,z) = z


numNotas (a,s) []  _ = s
numNotas (a,s) (x:xs) l = if a<l then numNotas (a + (obtenerTiempoFigura (thd3 x)),s+1) xs l
                 else s
                 
obtenerCompas ::  [Nota] -> Int ->  [Compas]
obtenerCompas [] _ = []
obtenerCompas x 4 = let sum = numNotas (0,0) x 4 in 
                    [take sum x] ++ (obtenerCompas ( drop sum x) 4)
obtenerCompas x 3 = let sum = numNotas (0,0) x 3 in 
                    [take sum x] ++ (obtenerCompas ( drop sum x) 3)  
obtenerCompas x 2 = let sum = numNotas (0,0) x 2 in 
                    [take sum x] ++ (obtenerCompas ( drop sum x) 2)
                    
obtenerMusica :: String -> Musica
obtenerMusica x = 
				 let z = words x 
				     y = (head (tail z)) 
				     s = obtenerNotas (tail (tail z)) 
				     w = obtenerTiempo y in
				     (toArmadura (head z), w, obtenerCompas s (fst w))
 

claveSol = ["       -       ",
		    "      / \\     ",
		    "______|_|______",
		    "      | |      ",
		    "______|/_______",
		    "      |        ",
		    "_____/|________",
		    "    / |___     ",
		    "___/_/|___\\___",
		    "   | \\|   |  ",
		    "____\\_|__/____",
		    "     \\|/    ",
		    "    \\_|        "]
		 
cuatro = ["       ",
		  "       ",
		  "_______",
		  "  |  | ",
		  "_ |__|_",
		  "     | ",
		  "_____|_",
		  "  |  | ",
		  "_ |__|_",
		  "     | ",
		  "____|_",
		  "       ",
		  "       "]
		 	 

tres = ["           ",
		"        ",
		 "_ ___  __",
		 "    /  ",
		 "_  /__ __",
		 "      |      ",
		 "_  __/ __",
		 "  |  |   ",
		 "_ |__|___",
		 "     | ",
		 "_____|___",
		 "          ",
		 "        "]
		 
dos = ["           ",
		"        ",
		 "_  __  __",
		 "     |  ",
		 "__  / ___",
		 "   /          ",
		 "_ /___ __",
		 "  |  |   ",
		 "_ |__|___",
		 "     | ",
		 "_____|___",
		 "          ",
		 "        "]
		 
armaduraRe = ["              ",
		      "              ",
		     "__-|-|-________",
		     "  -|-|-        ",
		     "_______________",
		     "         -|-|- ",
		     "_________-|-|-_",
		     "               ",
		     "_______________",
		     "               ",
		     "_______________",
		     "               ",
		     "               ",
		     "               ",
		     "               "]
		 
		 
mover (x,y,z)  
 | x > 65  =  let a = ["        \n"]
                  b = ["________\n"] 
                  c = "       \n" in
                c: (( (((take 8 (drop 3 blancaArriba)) ++ a) ++ b) ++ a ) ++ a)
 | x == 65 = blancaArriba
 | x < 65  =  let a = "       \n"
                  b = "________\n" 
                  c = [" \\__| \n"] in
                   a : a : ((b:a:(take 8 (b: (drop 3 blancaArriba)))) ++ c)


negraAbajo = ["______",
              "     ",
			  "______",
			  "  __  ",
			  "_|\\\\\\_",
			  " |/// ",
			  "_|____",
			  " |    ",
			  "_|____",
			  " |    "]
			  
blancaAbajo = ["______",
              "     ",
			  "______",
			  "  __  ",
			  "_|__\\_",
			  " |__/ ",
			  "_|____",
			  " |    ",
			  "_|____",
			  " |    "]
			  
redonda    = ["______",
              "      ",
			  "______",
			  "  __  ",
			  "_/__\\_",
			  " \\__/ ",
			  "______",
			  "      ",
			  "______",
			  "      "]
			  
corcheaAbajo = ["______",
                "      ",
			    "______",
			    "  __  ",
			    "_|\\\\\\",
			    " |/// ",
			    "_|____",
			    " |  | ",
			    "_|_/__",
			    " |/   "]
			  
negraArriba = ["______",
              "     |",
			  "_____|_",
			  "     | ",
			  "_____|_",
			  "     | ",
			  "_____|_",
			  "  ///| ",
			  "__\\\\\\|_"]
			  
blancaArriba = ["        \n",
				"        \n",
				"________\n",
                "      | \n",
			    "______|_\n",
			    "      | \n",
			    "______|_\n",
			    "      | \n",
			    "______|_\n",
			    "   /  | \n",
			    "___\\__|_\n",
			    "        \n",
			    "        \n"]
			    
corcheaArriba = ["_______",
                 "     |\\",
			     "_____|_\\",
			     "     | |",
			     "_____|_/",
			     "     |/ ",
			     "_____|_",
			     "  ///| ",
			     "__\\\\\\|_"]
			     

			     
toP (x,y,z) 
 | fst y == 4  && x == D = [claveSol,cuatro,armaduraRe, (mover(67,0,0))] 
 
toPent x i
 | i<13   =  map (!!i) x ++ toPent x (i+1)
 | otherwise = []

                    
-- | 'leerMusica' Lee un archivo de texto y imprime el resultado de la funcion escribirMusica
leerMusica :: FilePath   -- ^ El archivo de entrada 'FilePath'
		   -> IO String      -- ^ El valor que retorna
leerMusica file   = catch (readFile file)
                     (\_ -> error "Error: No se puede accesar al archivo")
                              
                              
                              
-- / Funcion principal del programa                              
main = do 
           x <- getArgs
           let file = (x!!0)
           if (length(x)==1) then do
           			    s <- leerMusica file
           			    let q = obtenerMusica s
           			    putStrLn "HOLA JOSMA"
           else error "Error: Falta el nombre del archivo"
    

           