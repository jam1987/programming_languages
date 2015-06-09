sol = do
		putStrLn "       -   "
		putStrLn "      / \\  "
		putStrLn "______|_|__"
		putStrLn "      | |  "
		putStrLn "______|/___"
		putStrLn "      |    "
		putStrLn "_____/|____"
		putStrLn "    / |___  "
		putStrLn "___/_/|___\\_"
		putStrLn "   | \\|   |"
		putStrLn "____\\_|__/_"
		putStrLn "      |    "
		putStrLn "    \\_/    "
		
hola = do
		 putStrLn "hola mundo"
		 
printString :: String -> IO()		 
printString x = do
				  putStrLn x
				  
printL :: [String] -> [IO()]				  
printL x = do 
		     map printStrLn x