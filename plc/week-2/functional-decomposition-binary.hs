-- Showcase how functional decomposiution handles binary operations
-- (where arguments can be of different data)


data Expr = Value Int
          | Text String
          | Add Expr Expr -- The binary operation with two arguments that can be off diferent data
          deriving (Show, Eq)

-- We define what should happen for each case, quite easy! Nothing complicated.
addValues :: Expr -> Expr -> Expr
addValues (Value x) (Text s) = Text $ show x ++ s
addValues (Text s) (Value x) = Text $ s ++ show x
addValues (Text x) (Text y) = Text $ x ++ y
addValues (Value x) (Value y) = Value (x + y)

evaluate :: Expr -> Expr
evaluate v@(Value _) = v
evaluate s@(Text _) = s
evaluate (Add e1 e2) = addValues (evaluate e1) (evaluate e2) -- HERE IS OUR BINARY OPERATION
