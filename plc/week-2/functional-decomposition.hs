-- Showcase of the advantages/disadvantages of functional decomposition


data Expr = Value Int
          | Add Expr Expr
          deriving (Show, Eq)


evaluate :: Expr -> Int
evaluate (Value x) = x
evaluate (Add e1 e2) = evaluate e1 + evaluate e2

-- ADVANTAGE
-- It is super easy to add a new operation on a type. In such a situation we
-- do not affect any existing code and do not need to make any additional
-- changes.

hasZero :: Expr -> Bool
hasZero (Value x) = x == 0
hasZero (Add e1 e2) = hasZero e1 || hasZero e2
--- New function added, existing code stays the same.


-- DISADVANTAGE
-- Adding new data, in this case a new variant/data constructor, requires
-- from us to update all the operations that work with this type.

data Expr2 = Value2 Int
          | Add2 Expr2 Expr2
          | Multiply2 Expr2 Expr2 -- Added new variant/data constructor
          deriving (Show, Eq)

evaluate2 :: Expr2 -> Int
evaluate2 (Value2 x) = x
evaluate2 (Add2 e1 e2) = evaluate2 e1 + evaluate2 e2
evaluate2 (Multiply2 e1 e2) = evaluate2 e1 * evaluate2 e2 -- Needed to update here!

hasZero2 :: Expr2 -> Bool
hasZero2 (Value2 x) = x == 0
hasZero2 (Add2 e1 e2) = hasZero2 e1 || hasZero2 e2
hasZero2 (Multiply2 e1 e2) = hasZero2 e1 || hasZero2 e2 -- Needed to update here as well!
