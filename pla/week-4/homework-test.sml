(* Homework3 Simple Test*)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)

use "homework.sml";

val test11 = only_capitals ["A","B","C"] = ["A","B","C"]
val test12 = only_capitals ["A","b","C"] = ["A","C"]
val test13 = only_capitals [] = []

val test21 = longest_string1 ["A","bc","C"] = "bc"
val test22 = longest_string1 ["A","bc","xc"] = "bc"
val test23 = longest_string1 ["A","bc","xdc"] = "xdc"
val test24 = longest_string1 [] = ""

val test31 = longest_string2 ["A","bc","C"] = "bc"
val test32 = longest_string2 ["A","bc","xc"] = "xc"
val test33 = longest_string2 ["A","bc","xdc"] = "xdc"
val test34 = longest_string2 [] = ""

val test41 = longest_string3 ["A","bc","C"] = "bc"
val test42 = longest_string3 ["A","bc","xc"] = "bc"
val test43 = longest_string3 ["A","bc","xdc"] = "xdc"
val test44 = longest_string3 [] = ""

val test51 = longest_string4 ["A","bc","C"] = "bc"
val test52 = longest_string4 ["A","bc","xc"] = "xc"
val test53 = longest_string4 ["A","bc","xdc"] = "xdc"
val test54 = longest_string4 [] = ""

(*val test5 = longest_capitalized ["A","bc","C"] = "A"*)
val test55 = longest_capitalized ["A","bc","C"] = "A"
val test56 = longest_capitalized ["a","bc","Xc"] = "Xc"
val test57 = longest_capitalized ["A","bc","Xdc"] = "Xdc"
val test58 = longest_capitalized [] = ""

val test61 = rev_string "abc" = "cba"
val test62 = rev_string "" = ""
val test63 = rev_string "aaa" = "aaa"

val test71 = first_answer (fn x => if x > 3 then SOME x else NONE) [1,2,3,4,5] = 4
(*val test72 = first_answer (fn x => if x > 5 then SOME x else NONE) [1,2,3,4,5] = 4*)

val test81 = all_answers (fn x => if x = 1 then SOME [x] else NONE) [2,3,4,5,6,7] = NONE
val test82 = all_answers (fn x => if x = 1 then SOME [x] else NONE) [1,1,1] =
  SOME [1, 1, 1]

val test9a1 = count_wildcards Wildcard = 1
val test9a2 = count_wildcards (TupleP [Wildcard, Wildcard]) = 2
val test9a3 = count_wildcards (ConstP 2) = 0

val test9b1 = count_wild_and_variable_lengths (Variable("a")) = 1
val test9b2 = count_wild_and_variable_lengths (Variable("abc")) = 3
val test9b3 = count_wild_and_variable_lengths (TupleP [Variable("abc"), Wildcard]) = 4

val test9c1 = count_some_var ("x", Variable("x")) = 1
val test9c2 = count_some_var ("x", Variable("y")) = 0
val test9c3 = count_some_var ("x", (TupleP [Variable("x"), Wildcard])) = 1
val test9c4 = count_some_var ("x", (TupleP [Variable("x"), Variable("x")])) = 2

val test101 = check_pat (Variable("x")) = true
val test102 = check_pat (TupleP [Variable("x"), Variable("x")]) = true
val test103 = check_pat (TupleP [Variable("x"), Variable("y")]) = false

val test111 = match (Const(1), UnitP) = NONE
val test112 = match (Const(1), ConstP(1)) = SOME []
val test113 = match (Const(1), Variable("x")) = SOME [("x", Const(1))]
val test114 = match (Tuple [Const 1, Unit], TupleP [ConstP 1, Variable("x")]) =
  SOME [("x", Unit)]
val test115 = match (Constructor("x", Const(1)), ConstructorP("x", Variable("x"))) =
  SOME [("x", Const(1))]
val test116 = match (Constructor("x", Const(1)), ConstructorP("x", UnitP)) =
  NONE

val test12 = first_match Unit [UnitP] = SOME []


