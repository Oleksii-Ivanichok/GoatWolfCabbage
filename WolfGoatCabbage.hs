type State = (Bool, Bool, Bool, Bool) -- (фермер, вовк, коза, капуста)

-- Перевірка, чи стан є безпечним
isSafe :: State -> Bool
isSafe (f, w, g, c) = not (g == w && f /= g) && not (g == c && f /= g)

-- Переміщення фермера з одним з об'єктів або без нього
move :: State -> [State]
move (f, w, g, c) = filter isSafe [
    (not f, w, g, c),    -- фермер переправляється сам
    (not f, not w, g, c), -- фермер переправляє вовка
    (not f, w, not g, c), -- фермер переправляє козу
    (not f, w, g, not c)  -- фермер переправляє капусту
    ]

-- Пошук розв'язку
solve :: State -> [State] -> [[State]]
solve finalState path@(current:_) 
    | current == finalState = [path]
    | otherwise = concatMap (\s -> solve finalState (s:path)) $ filter (`notElem` path) (move current)
solve _ [] = []

-- Головна функція, що запускає розв'язок
main :: IO ()
main = mapM_ print (solve (True, True, True, True) [(False, False, False, False)])
