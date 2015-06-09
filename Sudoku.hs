-- Nombre del archivo: Sudoku.hs
-- Descripcion del archivo: Este archivo contiene todas las
-- funciones necesarias para jugar a sudoku.
-- Version: 1.1

import Data.List

data Sudoku = Grid {rows :: [[Maybe Int]]} deriving (Eq,Show)
type Position = (Int, Int)
type Block = [Maybe Int]


(!!=) :: [a] -> (Int, a) -> [a]
(!!=) [] (z,y) = []
(!!=) (x:xs) (z,y) = take (z) (x:xs) ++ [y] ++ drop (z+1) (x:xs)

changeMatrix  :: [[a]] -> (Int,Int,a) -> [[a]]
changeMatrix [[]] _ = [[]]
changeMatrix (x:xss) (y,z,w) = take (y) (x:xss) ++ ((!!=) ((x:xss)!!y) (z,w)) : drop (y+1) (x:xss)



llenarLista =  replicate 9 Nothing
			

llenarPrin =  replicate 9 llenarLista


-- Esta funcion inicializa un Sudoku
emptySudoku :: Sudoku
emptySudoku = Grid $ llenarPrin

-- Esta funcion auxiliar nos devuelve una lista de Nothing obtenida en el Sudoku, en caso de haberlo
parseNothing :: Sudoku -> [Maybe Int]
parseNothing (Grid(x:xs)) = filter ( ==Nothing) (concat (x:xs))

-- Esta funcion devuelve True si el Sudoku esta lleno y False en caso contrario
isFull :: Sudoku -> Bool
isFull (Grid (x:xs)) = null(parseNothing(Grid(x:xs)))


tamano (x:xss) = if (xss == []) then length(x):[]
				else [length(x)] ++ tamano(xss)
tam :: [[a]] -> Bool				
tam (x:xss) = length (x:xss) == 9


tamValid (x:xss) = all ( ==9) (tamano (x:xss))

valid (Grid(x:xs)) = tamValid (x:xs) && tam (x:xs)

validValues (Grid(x:xs)) = all ( <=Just 9) (concat(x:xs))

majorZero (Grid(x:xs)) = all ( > Just 0) (concat(x:xs))


isValid (Grid(x:xs)) = majorZero (Grid(x:xs)) && validValues (Grid(x:xs)) && valid (Grid(x:xs))

existingValuesRows :: Sudoku -> Int -> [Int]
existingValuesRows (Grid (xs)) (z) = map (\(Just n) -> n) $ filter (/=Nothing) ((xs!!z))

existingValuesColumn :: Sudoku -> Int -> Int -> [Maybe Int] 
existingValuesColumn (Grid([[]])) 0 _ = []
existingValuesColumn (Grid (xs)) 0 z = [(xs!!0!!z)]
existingValuesColumn (Grid (xs)) n z = (xs!!n!!z): existingValuesColumn (Grid (xs)) (n-1) z
  
depurate :: Sudoku -> Int -> [Int]
depurate (Grid (x:xs)) z = map (\(Just n) -> n) $ filter (/=Nothing)(existingValuesColumn (Grid (x:xs)) 0 z)

existingValues :: Sudoku -> Position -> [Int]
existingValues (Grid(x:xs)) (y,z) = sort $ nub $ existingValuesRows (Grid(x:xs)) y ++ depurate (Grid(x:xs)) z


posibleValues (Grid(x:xs)) (y,z) =  [1,2,3,4,5,6,7,8,9] \\ existingValues (Grid(x:xs)) (y,z)


update (Grid(x:xs)) (y,z) a = (Grid(changeMatrix (x:xs) (y,z,a)))


blankAux (Grid(x:xs)) i = if i < length(x:xs) then (i,elemIndices (Nothing) (rows (Grid(x:xs))!!i)):blankAux (Grid(x:xs)) (i+1) 
				   else [(-1,[])]
				   
toListPosition :: (Int,[Int]) -> [Position]
toListPosition (x,[]) = []
toListPosition (x,(y:ys)) = (x,y) : toListPosition(x,ys)

blankAux2 :: Sudoku -> Int -> [[Position]]
blankAux2 (Grid(x:xs)) i= if i<length(blankAux (Grid(x:xs)) 0) then toListPosition((blankAux (Grid(x:xs)) 0)!!i) :blankAux2 (Grid(x:xs)) (i+1)
							       else [[]]
							    
							    
blanks :: Sudoku -> [Position]
blanks (Grid(x:xs)) = concat (blankAux2 (Grid(x:xs)) 0)

blockisOk :: Block -> Bool
blockisOk (x:xs) = duplicates $ sort (x:xs)

duplicates :: (Eq a) => [a] -> Bool
duplicates [] = False
duplicates (x:y:ys)
	| x == y = True
	| null(ys) = False
	| otherwise = duplicates (y:ys)
	
block :: [[Maybe Int]] -> Int -> Int -> Block
block (x:xs) i lim = if i<lim then take 3 ((x:xs)!!i) ++ block (x:xs) (i+1) lim
                         else []
                         
blocksRetCol :: [[Maybe Int]] -> Int -> [Block]
blocksRetCol (x:xs) n= if n<7 then [block (x:xs) n (n+3)] ++ blocksRetCol (x:xs) (n+3)
                           else [[]]

blocksRet :: [[Maybe Int]] -> Int -> [Block]
blocksRet (x:xs) d = if d<7 then filter (/=[]) (blocksRetCol (x:xs) 0 ++ blocksRet (dropFuck (x:xs) 0 3) (d+3))
                     else [[]]
                     
dropFuck :: [[Maybe Int]] -> Int -> Int -> [[Maybe Int]]
dropFuck (x:xs) i d = if i<9 then drop d ((x:xs)!!i) : dropFuck (x:xs) (i+1) d 
                    else [[]]
                    
--columns :: Sudoku -> Int -> Int -> [Maybe Int]
--columns (Grid(x:xs)) f c = if f<9 then ((x:xs)!!f!!c): columns((Grid(x:xs)) (f+1) c)
--                          else if f == 9 then columns((Grid(x:xs)) 0 (c+1))
--                           else [[]]
