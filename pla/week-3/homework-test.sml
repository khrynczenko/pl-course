(* Homework2 Simple Test *)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)

use "homework.sml";

val test11 = all_except_option ("string", ["string"]) = SOME []
val test12 = all_except_option ("q", ["x", "y", "z"]) = NONE
val test13 = all_except_option ("y", ["x", "y", "z"]) = SOME ["x", "z"]

val test21 = get_substitutions1 ([["foo"],["there"]], "foo") = []
val test22 = get_substitutions1 ([["foo", "xd"],["there"]], "foo") = ["xd"]
val test23 = get_substitutions1 ([["foo", "xd"],["there", "foo", "xd"]], "foo")
= ["xd", "there", "xd"]

val test31 = get_substitutions2 ([["foo"],["there"]], "foo") = []
val test32 = get_substitutions2 ([["foo", "xd"],["there"]], "foo") = ["xd"]
val test33 = get_substitutions2 ([["foo", "xd"],["there", "foo", "xd"]], "foo")
= ["xd", "there", "xd"]

val test4 = similar_names ([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], {first="Fred", middle="W", last="Smith"}) =
            [{first="Fred", last="Smith", middle="W"}, {first="Fredrick", last="Smith", middle="W"},
             {first="Freddie", last="Smith", middle="W"}, {first="F", last="Smith", middle="W"}]

val test51 = card_color (Clubs, Num 2) = Black

val test61 = card_value (Clubs, Num 2) = 2
val test62 = card_value (Clubs, Ace) = 11
val test63 = card_value (Clubs, King) = 10
val test64 = card_value (Clubs, Queen) = 10
val test65 = card_value (Clubs, Jack) = 10

val test71 = remove_card ([(Hearts, Ace)], (Hearts, Ace), IllegalMove) = []
val test72 = remove_card ([(Hearts, Ace), (Clubs, King)], (Hearts, Ace),
 IllegalMove) = [(Clubs, King)]
val test73 = (remove_card ([(Hearts, King)], (Hearts, Ace), IllegalMove) handle
IllegalMove => []) = []

val test81 = all_same_color [(Hearts, Ace), (Hearts, Ace)] = true
val test82 = all_same_color [(Hearts, Ace), (Clubs, Ace)] = false
val test83 = all_same_color [(Hearts, Ace), (Diamonds, Ace)] = true

val test91 = sum_cards [(Clubs, Num 2),(Clubs, Num 2)] = 4
val test92 = sum_cards [] = 0

val test10 = score ([(Hearts, Num 2),(Clubs, Num 4)],10) = 4

val test111 = officiate ([(Hearts, Num 2),(Clubs, Num 4)],[Draw], 15) = 6

val test112 = officiate ([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)],
                        [Draw,Draw,Draw,Draw,Draw],
                        42)
             = 3

val test113 = ((officiate([(Clubs,Jack),(Spades,Num(8))],
                         [Draw,Discard(Hearts,Jack)],
                         42);
               false) 
              handle IllegalMove => true)
             
