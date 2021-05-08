(* Coursera Programming Languages, Homework 3, Provided Code *)

exception NoAnswer

datatype pattern = Wildcard
		 | Variable of string | UnitP | ConstP of int | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

fun g f1 f2 p =
    let 
	val r = g f1 f2 
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end

(**** for the challenge problem only ****)

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

(**** you can put all your code here ****)

(* TASK 1 *)

val only_capitals = List.filter (fn word => Char.isUpper (String.sub (word, 0)))

(* TASK 2, 3 *)

fun is_longer lhs rhs = String.size lhs > String.size rhs
fun is_longer_or_equal lhs rhs = String.size lhs >= String.size rhs

fun find_string binary_op words =
    case words of
        [] => ""
      | words =>
          foldl (fn (word, acc) => if binary_op word acc then word else acc) "" words


fun longest_string1 words = find_string is_longer words
fun longest_string2 words = find_string is_longer_or_equal words

(* Okay it seems that task 4 wants me to do what I did in task 3 already but
 * with binary operator that uses tuple argument instead of currying. I could
 * use find_string function again but for the sake of the task lets define
 * longest_string_helper again.*)

(* TASK 4 *)

fun longest_string_helper binary_op words =
    case words of
        [] => ""
      | words =>
          foldl (fn (word, acc) => if binary_op (word, acc) then word else acc) "" words

fun uncurry f = (fn (lhs, rhs) => f lhs rhs)

val longest_string3 = longest_string_helper (uncurry is_longer)
val longest_string4 = longest_string_helper (uncurry is_longer_or_equal)

(* TASK 5 *)

fun is_capitalized word = Char.isUpper (String.sub (word, 0))

val longest_capitalized = longest_string1 o (List.filter is_capitalized)

(* TASK 6 *)

val rev_string = implode o List.rev o explode

(* TASK 7 *)

fun first_answer f elements =
    case elements of
         [] => raise NoAnswer
       | x::xs => if isSome (f x) then x else first_answer f xs

(* TASK 8 *)

fun are_all_some elements =
    case elements of
         [] => true
       | (SOME x)::xs => true andalso are_all_some xs
       | NONE::_ => false

fun all_answers_helper f acc elements =
    case elements of
        [] => acc
      | x::xs => 
          let
            val x = f x
          in
            if isSome x then all_answers_helper f (acc @ (valOf x)) xs else all_answers_helper f acc xs
          end

fun all_answers f elements=
  if are_all_some (List.map f elements)
  then SOME (all_answers_helper f [] elements)
  else NONE

(* TASK 9a *)

fun count_wildcards pat = g (fn _ => 1) (fn _ => 0) pat

(* TASK 9b *)

fun count_wild_and_variable_lengths pat = g (fn _ => 1) (fn name => String.size name) pat

(* TASK 9c *)

fun count_some_var (str, pat) = g (fn _ => 0) (fn name => if name = str then 1 else 0) pat

(* TASK 10 *)

fun extract_names_from_pattern pattern : string list = 
	case pattern of
	    Wildcard          => []
	  | Variable x        => [x]
	  | TupleP ps         => List.foldl (fn (p,i) =>
              (extract_names_from_pattern p) @ i) [] ps
	  | ConstructorP(_,p) => extract_names_from_pattern p
	  | _                 => []

fun check_pat pat =
  let
    val extracted_names = extract_names_from_pattern pat
    val first_name = hd extracted_names
  in
    List.foldl (fn (name, acc) => if name = first_name andalso acc then true
                                  else false) true (tl extracted_names)
  end


(* TASK 11 *)

fun match (v, pat) =
  case (v, pat) of
       (_, Wildcard) => SOME []
     | (v, Variable s) => SOME [(s, v)]
     | (Unit, UnitP) => SOME []
     | (Const x, ConstP y ) => if x = y then SOME [] else NONE
     | (Tuple vs, TupleP ps) => 
         if List.length vs = List.length ps
         then (all_answers match (ListPair.zip(vs, ps)))
         else NONE
     | (Constructor (str1, v1), ConstructorP (str2, p1)) => 
         if str1 = str2
         then match (v1, p1)
         else NONE
     | _ => NONE

(* TASK 12 *)
fun first_match v pats =
    match (v, (first_answer (fn pat => match (v, pat)) pats)) handle NoAnswer => NONE

