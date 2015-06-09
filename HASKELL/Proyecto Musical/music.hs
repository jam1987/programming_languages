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
			 moverSostenido,
			 toPent,
			 mover,
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
 
claveSol :: [String]
claveSol = ["       -     ",
	    "      / \\    ",
	    "______|_|____",
	    "      | |    ",
	    "______|/_____",
	    "      |      ",
	    "_____/|______",
	    "    / |___   ",
	    "___/_/|___\\__",
	    "   | \\|   |  ",
	    "____\\_|__/___",
	    "      | /    ",
	    "    \\_/      ",
	    "              "]


cuatro :: [String]		 
cuatro=["       ",
	"       ",
	"_______",
	"  |  | ",
	"_ |__|_",
	"     | ",
	"_____|_",
	"  |  | ",
	"_ |__|_",
	"     | ",
	"_____|_",
	"       ",
	"       ",
	"       "]
	 	 

tres :: [String]
tres = ["         ",
	"         ",
	"_ ___  __",
	"    /    ",
	"_  /__ __",
	"      |  ",
	"_  __/ __",
	"  |  |   ",
	"_ |__|___",
	"     |   ",
	"_____|___",
	"         ",
	"         ",
	"         "]
		 
dos :: [String]
dos =  ["         ",
	"         ",
	"_  __  __",
	"     |   ",
	"__  / ___",
	"   /     ",
	"_ /___ __",
	"  |  |   ",
	"_ |__|___",
	"     |   ",
	"_____|___",
	"         ",
	"         ",
	"         "]

armaduraRe :: [String]		 
armaduraRe =   ["               ",
		"               ",
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
		"               "]
		
armaduraSol :: [String]		
armaduraSol =   ["          ",
		"          ",
		"__-|-|-___",
		"  -|-|-   ",
		"__________",
		"          ",
		"__________",
		"          ",
		"__________",
		"          ",
		"__________",
		"          ",
		"          ",
		"          "]
		
armaduraLa :: [String]		
armaduraLa =   ["               ",
		        "               -|-|-",
		        "__-|-|-________-|-|-",
		        "  -|-|-             ",
		        "____________________",
		        "         -|-|-      ",
		        "_________-|-|-______",
		        "                    ",
		        "____________________",
		        "                    ",
		        "____________________",
		        "                    ",
		        "                    ",
		        "                    "]
		
becuadro :: [String]		
becuadro =   ["       ",
		      "       ",
		      "_______",
		      "       ",
		      "_______",
		      "       ",
		      "_______",
		      "       ",
		      "__ |___",
		      "   |--|",
		      "__ |--|",
		      "      |",
		      "       ",
		      "       "]

sostenido :: [String]		
sostenido=   ["        ",
		      "        ",
		      "________",
		      "        ",
		      "________",
		      "        ",
		      "________",
		      "        ",
		      "________",
		      "   -|-|-",
		      "___-|-|-",
		      "        ",
		      "        ",
		      "        "]


analizarAlteraciones :: Nota -> [String]
analizarAlteraciones (x,y,z)
 | y == Sostenido  = moverSostenido (x,y)
 | y == Becuadro   = moverBecuadro (x,y)
 | y == Ninguna    = []


mover :: Nota -> [String]
mover (x,y,z) 

 | z == Blanca  =  moverBlanca (x,y)
 | z == Negra   = moverNegra (x,y)
 | z == Corchea = moverCorchea (x,y)
 | z == Redonda = moverRedonda (x,y)
 
 
convertirNota :: Nota -> [String]
convertirNota (x,y,z) = (analizarAlteraciones (x,y,z)) ++ (mover (x,y,z))


moverBlanca :: (Int,Alteracion) -> [String]		 
moverBlanca (x,y) 
 | x == 76           = let a = ["           "]
                           b = ["___________"] 
                           c =  "           " 
                           d = ["_____|_____"] in
                           c : ( c: ((take 8 (drop 4 blancaAbajo) ) ++ d ++ a ++ a ++ a))
 | x == 72           =  blancaAbajo
 | x == 69 	     = let a = ["        "]
                           b = ["________"] 
                           c =  "        " 
                           d =  "      | " in
                           c: (( ((d : (take 7 (drop 1 (drop 3 blancaArriba))) ++ a) ++ b) ++ a ) 
                           ++ a ++a)
 | x == 65 = blancaArriba
 | x == 62  	     =  let a = "        "
                            b = "________" 
                            c = ["   \\__| "]
                            d = ["        "] in
                            a : a : ((b:a:(take 8 (b: (drop 3 blancaArriba)))) ++ c ++ d)
 | x == 64           =  blancaArribal
 | x == 67  =  let a =  "        "
                   c = ["        "]
                   b = ["________"]  in
                   (a: (a:(take 8 (drop 4 blancaArribal) ) ++ b ++ c ++ c ++ c))
 | x == 74  =  let a =  "           "
                   c = ["           "]
                   b = ["_____|_____"] 
                   d = ["     |     "] in
                   (a: (a:(take 8 (drop 4 blancaAbajol) ) ++ b ++ d ++ c ++c))
 | x == 77  =  let a =  "           "
                   c = ["           "]
                   b = ["_____|_____"] 
                   d = ["     |     "]
		   e=  ["___________"] in
                   (a:(take 7 (drop 5 blancaAbajol)) ++ b ++ d ++ e ++c ++c ++c)
 | x == 71= blancaAbajol


moverNegra :: (Int,Alteracion) -> [String]                  
moverNegra (x,y) 
 | x == 76           = let a = ["        "]
                           b = ["________"] 
                           c =  "        " 
                           d = ["_|______"] in
                           c : ( c: ((take 8 (drop 4 negraAbajo) ) ++ d ++ a ++ a++ a))
 | x == 72           =  negraAbajo
 | x == 69           = let a = ["        "]
                           b = ["________"] 
                           c =  "        " 
                           d =  "     |  " in
                           c: (( ((d : (take 7 (drop 1 (drop 3 negraArriba))) ++ a) ++ b) ++ a ) 
                           ++ a ++ a)
 | x == 65 = negraArriba
 | x == 62  =  let a = "        "
                   b = "________" 
                   c =["  \\\\\\|  "] 
                   d =["        "] in
                   a : a : ((b:a:(take 8 (b: (drop 3 negraArriba)))) ++ c ++ d)
 | x == 64           =  negraArribal
 | x == 67  =  let a =  "        "
                   c = ["        "]
                   b = ["________"]  in
                   (a: (a:(take 8 (drop 4 negraArribal) ) ++ b ++ c ++ c ++c))
 | x == 74  =  let a =  "           "
                   c = ["           "]
                   b = ["_____|_____"] 
                   d = ["     |     "] in
                   (a: (a:(take 8 (drop 4 negraAbajol) ) ++ b ++ d ++ c ++c))
 | x == 77  =  let a =  "           "
                   c = ["           "]
                   b = ["_____|_____"] 
                   d = ["     |     "]
		   e=  ["___________"] in
                   (a:(take 7 (drop 5 negraAbajol)) ++ b ++ d ++ e ++c ++c ++ c)
 
 | x == 71 = negraAbajol

moverCorchea :: (Int,Alteracion) -> [String]
moverCorchea (x,y) 
 | x == 76           = let a = ["      "]
                           b = ["______"] 
                           c =  "      " 
                           d = ["_|/_____"] in
                           c : ( c: ((take 8 (drop 4 corcheaAbajo) ) ++ d ++ a ++ a ++ a))
 | x == 72           =  corcheaAbajo
 | x == 69 	     =  let a = ["         "]
                            b = ["_________"] 
                            c =  "          " 
                            d =  "     |\\  " in
                            c: (( ((d : (take 7 (drop 1 (drop 3 corcheaArriba))) ++ a) ++ b) ++ a ) 
                            ++ a ++ a)
 | x == 65 = corcheaArriba
 | x == 62 =  let a = ["         "]
                  b = ["_________"] 
                  c = ["  ///|   "]
	          d=["  \\\\\\|   "] in
	a++(a++(b++(a++(b++(drop 3( take 10  corcheaArriba)++d++a)))))
 | x == 64           =  corcheaArribal
 | x == 67  =  let a =  "          "
                   c = ["          "]
                   b = ["__________"]  in
                   (a: (a:(take 8 (drop 4 corcheaArribal) ) ++ b ++ c ++ c ++ c))
 | x == 71= corcheaAbajol
 | x == 74  =  let a =  "           "
                   c = ["           "]
                   b = ["_____|_/___"] 
                   d = ["     |/    "] in
                   (a: (a:(take 8 (drop 4 corcheaAbajol) ) ++ b ++ d ++ c ++c ))
 | x == 77  =  let a =  "           "
                   c = ["           "]
                   b = ["_____|_/___"] 
                   d = ["     |/    "]
		   e=  ["___________"] in
                   (a:(take 7 (drop 5 corcheaAbajol)) ++ b ++ d ++ e ++c ++c ++ c)

moverRedonda :: (Int,Alteracion) -> [String]
moverRedonda (x,y)
 | x == 60  =  let a =  ["       "]
                   b =  ["_______"] in
                   ((take 9 redondal) ++ a++b++["  __   ","_/__\\_  ","\\__/  "])
 | x == 62  =  let a =  "       "
                   b =  "_______" 
                   c = [" \\__/  "] 
                   d = ["       "]  in
                   a : a : ((b:a:(take 8 (b: (drop 3 redonda)))) ++ c ++ d)

 | x == 64           =  redondal

 | x == 65           =  redonda

 | x == 67  =  let a =  "       "
                   c = ["       "]
                   b = ["_______"]  in
                   (a: (a:(take 8 (drop 4 redondal) ) ++ b ++ c ++ c ++ c ++c ))

 | x == 69           = let a = ["       "]
                           b = ["_______"] 
                           c =  "       " 
                           d = ["_______"] in
                           c : ( c: ((take 8 (drop 4 redonda) ) ++ d ++ a ++ a++a))

 | x == 71  =  let a =  "       "
                   c = ["       "]
                   b = ["_______"]  in
                   (a: (a:(take 6 (drop 6 redondal) ) ++ b ++ c ++ b ++ c ++ c ++c ))

 | x == 72  =  let a =  "       "
                   c = ["       "]
                   b = ["_______"]  in
                   (a: (a:(take 6 (drop 6 redonda) ) ++ b ++ c ++ b ++ c ++ c ++c ))

 | x == 74  =  let a =  "       "
                   c = ["       "]
                   b = ["_______"]  in
                   (a: (a:(take 4 (drop 8 redondal) ) ++ b ++ c ++ b ++ c ++ b ++c ++c ++c))

 | x == 76  =  let a =  "       "
                   c = ["       "]
                   b = ["_______"]  in
                   (a: ((take 5 (drop 7 redonda) ) ++ b ++ c ++ b ++ c ++ b ++ c ++ c ++c))
 | x == 77  =  let a =  "       "
                   c = ["       "]
                   b = ["_______"]  in
                   (a: ((take 3 (drop 9 redondal) ) ++ b ++ c ++ b ++ c ++ b ++c ++b ++c ++c ++c))



negraAbajo :: [String]
negraAbajo =   ["        ",
		"        ",
		"________",
		"        ",
		"________",
		" |\\\\\\   ",
		"_|///___",
		" |      ",
		"_|______",
		" |      ",
		"_|______",
		" |      ",
		" |      ",
		"        "]
			  
blancaAbajo :: [String]			  
blancaAbajo =  ["           ",
		"           ",
		"___________",
		"           ",
		"___________",
		"     |  \\  ",
		"_____|__/__",
		"     |     ",
		"_____|_____",
		"     |     ",
		"_____|_____",
		"     |     ",
		"     |     ",
		"           "]
			  
redonda :: [String]			  
redonda=       ["       ",
		"       ",
		"_______",
		"       ",
		"_______",
		"       ",
		"_______",
		"       ",
		"_______",
		" /  \\  ",
		"_\\__/__",
		"       ",
		"       ",
		"       "]

corcheaAbajo :: [String]			  
corcheaAbajo = ["        ",
		"        ",
		"________",
		"        ",
		"________",
		" |\\\\\\   ",
		"_|///___",
		" |      ",
		"_|_\\____",
		" |  \\   ",
		"_|__|___",
		" | /    ",
		" |/     ",
		"        "]
			  
negraArriba :: [String]			  
negraArriba =  ["        ",
		"        ",
		"________",
		"     |  ",
		"_____|__",
		"     |  ",
		"_____|__",
		"     |  ",
		"_____|__",
		"  ///|  ",
		"__\\\\\\|__",
		"        ",
		"        ",
		"        "]
			  
blancaArriba :: [String]			  
blancaArriba = ["        ",
		"        ",
		"________",
		"      | ",
		"______|_",
		"      | ",
		"______|_",
		"      | ",
		"______|_",
		"   /  | ",
		"___\\__|_",
		"        ",
		"        ",
		"        "]
			    
corcheaArriba :: [String]			    
corcheaArriba =["         ",
		"         ",
		"_____ __ ",
		"     |\\  ",
		"_____|_\\ ",
		"     |  |",
		"_____|_/_",
		"     |/  ",
		"_____|___",
		"  ///|   ",
		"__\\\\\\|___",
		"         ",
		"         ",
		"         "]

			  
redondal :: [String]			  
redondal=["       ",
	  "       ",
	  "_______",
	  "       ",
	  "_______",
	  "       ",
	  "_______",
	  "       ",
	  "_______",
	  "  __   ",
	  "_/__\\__",
	  " \\__/  ",
	  "       ",
	  "       ",
	  "       "]

blancaArribal :: [String]
blancaArribal = ["        ",
		 "        ",
		 "________",
		 "        ",
		 "______|_",
		 "      | ",
		 "______|_",
		 "      | ",
		 "______|_",
		 "    __| ",
		 "___/__|_",
		 "   \\__| ",
		 "        ",
		 "        "]

blancaAbajol :: [String]
blancaAbajol = ["           ",
		"           ",
		"___________",
		"           ",
		"___________",
		"      __   ",
		"_____|__\\__",
		"     |__/  ",
		"_____|_____",
		"     |     ",
		"_____|_____",
		"     |     ",
		"     |     ",
		"           "]

negraArribal :: [String]
negraArribal = [ "        ",
		 "        ",
		 "________",
		 "        ",
		 "______|_",
		 "      | ",
		 "______|_",
		 "      | ",
		 "______|_",
		 "      | ", 
		 "___///|_",
		 "   \\\\\\| ",
		 "        ",
		 "        "]
		 
negraAbajol :: [String]
negraAbajol =  ["           ",
		"           ",
		"___________",
		"           ",
		"___________",
		"           ",
		"____ |\\\\\\__",
		"     |///  ",
		"_____|_____",
		"     |     ",
		"_____|_____",
		"     |     ",
		"     |     ",
		"           "]
		     
corcheaArribal :: [String]		     
corcheaArribal = ["          ",
		  "          ",
		  "__________",
		  "          ",
		  "______|\\__",
		  "      | \\ ",
		  "______|__|",
		  "      | / ",
		  "______|/__",
		  "      |   ", 
		  "___///|___",
		  "   \\\\\\|   ",
		  "          ",
		  "          "]


corcheaAbajol :: [String]
corcheaAbajol =["           ",
		"           ",
		"___________",
		"           ",
		"___________",
		"           ",
		"____ |\\\\\\__",
		"     |///  ",
		"_____|_____",
		"     |\\    ",
		"_____|_\\__ ",
		"     |  |  ",
		"     | /   ",
		"     |/    "]	


moverSostenido :: (Int,Alteracion) -> [String]
moverSostenido (x,y) 
 | x == 69           = let a = ["        "]
                           b = ["________"] 
                           c =  "        " 
                           d = ["________"] in
                           c : ( c: ((take 8 (drop 4 sostenido) ) ++ d ++ a ++ a++a))
 | x == 64           =   let a =  ["        "]
                             b =  ["___-|-|-"] 
                             c =  ["   -|-|-"] in
                             (take 9 sostenido) ++ a ++ b ++ c ++ a++a
 | x == 67           =  let a =  ["        "]
                            b =  ["___-|-|-"] 
                            c =  ["   -|-|-"] 
                            d =  ["________"] in
                            (take 8 sostenido) ++ b ++ c ++ d ++ a ++ a++a
 | x == 74           =  let a =  ["        "]
                            b =  ["___-|-|-"] 
                            c =  ["   -|-|-"] 
                            d =  ["________"] in
                            (take 4 sostenido) ++ b ++ c ++ d ++ a ++ d ++ a ++ d ++a++a++a
 | x == 77            =  let a =  ["        "]
                             b =  ["___-|-|-"] 
                             c =  ["   -|-|-"] 
                             d =  ["________"] in
                             (take 2 sostenido) ++ b ++ c ++ d ++ a ++ d ++ a ++ d ++a ++ d ++
                             a ++ a++a
 | x == 60            =  let a =  ["        "]
                             b =  [" __-|-|-"] 
                             c =  ["  -|-|- "] 
                             d =  ["________"] in
                             (take 9 sostenido) ++ a ++ d ++ a ++ b ++ c++a
                            
 | x == 65           =  sostenido
 | x == 62  =  let a =  "        "
                   b =  "________" 
                   c = [" |-|  "] in
                   a : a : ((b:a:(take 8 (b: (drop 3 sostenido)))) ++ c)
 | x == 76  =  let a =  "        "
                   c = ["        "]
                   b = ["________"]  in
                   (a: ((take 5 (drop 7 sostenido) ) ++ b ++ c ++ b ++ c ++ b ++ c ++ c ++c ))
 | x == 72  =  let a =  "        "
                   c = ["        "]
                   b = ["________"]  in
                   (a: (a:(take 6 (drop 6 sostenido) ) ++ b ++ c ++ b ++ c ++ c ++c ))

moverBecuadro :: (Int,Alteracion) -> [String]
moverBecuadro (x,y)
 | x == 65 = becuadro
 | x == 62 = let a = ["       "]
                 b = ["______"] 
                 c = ["   |--|"] 
                 d = ["     |"] in
                 a ++ a ++ b ++ a  ++ (take 8 (drop 2 becuadro)) ++ c ++ d
 | x == 76 = let a = ["      "]
                 b = ["______"] 
                 c = ["   |--|"] 
                 d = ["     |"] in
                 a++a++((take 4 (drop 8 becuadro)) ++ b ++ a ++ b ++ a ++ b ++ a ++ a ++ a)
 | x == 69 = let a = ["       "]
                 b = ["_______"] 
                 c = ["   |--|"] 
                 d = ["     |"] in
                a ++ (take 9 (drop 3 becuadro)) ++ b ++ a ++ a ++ a
                
  | x == 72 = let a = ["       "]
                  b = ["_______"] 
                  c = ["   |--|"] 
                  d = ["     |"] in
                  a ++ (take 7 (drop 5 becuadro)) ++ b ++ a ++ b ++ a ++ a ++ a
                 





finCompas :: [String]
finCompas = ["   ",
             "   ",
             "___",
             " | ",
             "_|_",
             " | ",
             "_|_",
             " | ",
             "_|_",
             " | ",
             "_|_",
             "   ",
             "   ",
             "   "]
             
finMusica :: [String]             
finMusica = ["    \n",
             "    \n",
             "___ \n",
             " | |\n",
             "_|_|\n",
             " | |\n",
             "_|_|\n",
             " | |\n",
             "_|_|\n",
             " | |\n",
             "_|_|\n",
             "    \n",
             "    \n",
             "    \n"]
             


generarCompas :: Compas -> [String]
generarCompas z = fromNotasToString z ++ finCompas

generarCompases :: [Compas] -> [[String]]
generarCompases z = map generarCompas z

fromCompasesToString :: [Compas] -> [String]
fromCompasesToString z = concat (generarCompases z)

pentagrama :: Musica -> [String]
pentagrama (x,y,z) 
 | fst y == 4  && x == D =  claveSol ++ cuatro ++ armaduraRe ++ fromCompasesToString z ++ 
                            finMusica
 | fst y == 4  && x == A =  claveSol ++ cuatro ++ armaduraLa ++ fromCompasesToString z ++ 
                            finMusica
 | fst y == 4  && x == G =  claveSol ++ cuatro ++ armaduraSol ++ fromCompasesToString z ++ 
                            finMusica
 | fst y == 4  && x == C =  claveSol ++ cuatro ++ fromCompasesToString z ++ finMusica                       
 | fst y == 2  && x == D =  claveSol ++ dos ++ armaduraRe ++ fromCompasesToString z ++ 
                            finMusica
 | fst y == 2  && x == A =  claveSol ++ dos ++ armaduraLa ++ fromCompasesToString z ++ 
                            finMusica
 | fst y == 2  && x == G =  claveSol ++ dos ++ armaduraSol ++ fromCompasesToString z ++ 
                            finMusica
 | fst y == 2  && x == C =  claveSol ++ dos ++ fromCompasesToString z ++ finMusica 
  | fst y == 3  && x == D =  claveSol ++ tres ++ armaduraRe ++ fromCompasesToString z ++ 
                            finMusica
 | fst y == 3  && x == A =  claveSol ++ tres ++ armaduraLa ++ fromCompasesToString z ++ 
                            finMusica
 | fst y == 3  && x == G =  claveSol ++ tres ++ armaduraSol ++ fromCompasesToString z ++ 
                            finMusica
 | fst y == 3  && x == C =  claveSol ++ tres ++ fromCompasesToString z ++ finMusica 


convertirNotas :: [Nota] -> [[String]]
convertirNotas x = (map convertirNota x) 

fromNotasToString :: [Nota] -> [String]
fromNotasToString z = concat (convertirNotas z)
 
toPentAux :: [String] -> Int -> String 
toPentAux x i
 | i<length(x)   =   (!!i) x ++ toPentAux x (i+14)
 | otherwise = []
 
toPent :: [String] -> Int -> String 
toPent x i
  | i<14     = toPentAux x i ++ toPent x (i+1)
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
           			    let p = pentagrama q
           			    let s = toPent p 0
           			    putStr s
          			    else error "Error: Falta el nombre del archivo"
    

           
