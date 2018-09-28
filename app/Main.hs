module Main where


data Node = And Node Node
          | Or Node Node
          | Literal String
          | Variable String
          | Gt Node Node
          | Gte Node Node
          | Lt Node Node
          | Lte Node Node
          | Group Node


instance Show Node where
  show (And a b) = (show a) ++ " && " ++ (show b)
  show (Or a b) = (show a) ++ " || " ++ (show b)
  show (Literal x) = x
  show (Variable x) = x
  show (Gt a b) = (show a) ++ " > " ++ (show b)
  show (Gte a b) = (show a) ++ " >= " ++ (show b)
  show (Lt a b) = (show a) ++ " < " ++ (show b)
  show (Lte a b) = (show a) ++ " <= " ++ (show b)
  show (Group x) = "(" ++ (show x) ++ ")"


class Invert a where
  invert :: a -> a


instance Invert Node where
  invert (And a b) = Or (invert a) (invert b)
  invert (Or a b) = And (invert a) (invert b)
  invert (Literal x) = Literal $ "!(" ++ x ++ ")"
  invert (Variable x) = Variable $ "!" ++ x
  invert (Gt a b) = Lte a b
  invert (Gte a b) = (Lt a b)
  invert (Lt a b) = Gte a b
  invert (Lte a b) = (Gt a b)
  invert (Group x) = Group $ invert x


-- example = And (Variable "a") (Variable "b")
group = Group (Or (Gte (Literal "0") (Variable "mppp"))
                  (Gt (Variable "mppp") (Literal "1000")))
time = Gte (Literal "1e-6f") (Variable "time")
noise = Gt (Literal "0.005f") (Variable "noise")
example = And (And time group) noise

main :: IO ()
main = do
  putStrLn $ show example
  putStrLn $ show $ invert example
