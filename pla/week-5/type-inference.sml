
fun count_elements lst =
  case lst of
      [] => 0
    | x::xs => 1 + count_elements xs

(*
 * Type inference steps:
 * count_elements: T1 -> T2
 *
 * Because pattern match uses list constructor we know that
 * `x` is of some type and `xs` is list of values with that type:
 * x: T3
 * xs: T3 list
 * T1: T3 list
 *
 * from the first pattern match
 * T2: int
 *
 * from the secon pattern match because + works with ints
 * T2: int
 *
 * thus
 * count_elements: T3 list -> int
 * which changes to
 * count_elements: 'a list -> int
 * )
