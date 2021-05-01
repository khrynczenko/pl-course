(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)

(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(* put your solutions for problem 2 here *)

fun all_except_option_helper (str, str_list) =
    case str_list of
         [] => []
       | x::xs => if same_string(str, x) then xs else x :: (all_except_option_helper(str, xs))


fun all_except_option (str, str_list) =
    let
        val extracted_list = all_except_option_helper(str, str_list)
        (* if extracted list is the same as original we didn't find given
         * element *)
    in
        if extracted_list = str_list then NONE else SOME extracted_list
    end

fun get_substitutions1 (substitutions, word) =
  case substitutions of
       [] => []
     | list1::rest =>
         let
           val found_substitutions = all_except_option(word, list1)
         in
           case found_substitutions of
                NONE => get_substitutions1(rest, word)
              | SOME valid => valid @ get_substitutions1(rest, word)
         end

fun get_substitutions2_helper (substitutions, acc, word) =
  case substitutions of
       [] => acc
     | list1::rest =>
         let
           val found_substitutions = all_except_option(word, list1)
         in
           case found_substitutions of
                NONE => get_substitutions2_helper(rest, acc, word)
              | SOME valid => get_substitutions2_helper(rest, acc @ valid, word)
         end

fun get_substitutions2 (substitutions, word) =
  get_substitutions2_helper(substitutions, [], word)


fun make_different_names(first_names, {first=f, middle=m, last=l}) =
    case first_names of
         [] => []
       | name::rest => {first=name, middle=m, last=l} :: make_different_names(rest,
         {first=f, middle=m, last=l})


fun similar_names_helper (substitutions, {first=f, middle=m, last=l}) =
  case substitutions of
       [] => []
    | xs => make_different_names(xs, {first=f, middle=m, last=l})

fun similar_names (substitutions, {first=f, middle=m, last=l}) =
  similar_names_helper(f::get_substitutions2(substitutions, f), {first=f,
  middle=m, last=l})

fun card_color (Clubs, _) = Black
  | card_color (Diamonds, _) = Red
  | card_color (Hearts, _) = Red
  | card_color (Spades, _) = Black

fun card_value (_, Ace) = 11
  | card_value (_, King) = 10
  | card_value (_, Queen) = 10
  | card_value (_, Jack) = 10
  | card_value (_, Num v) = v

fun remove_card (cs, c, e) =
    case cs of
        [] => raise e
      | x::xs => if x = c then xs else x :: remove_card(xs, c, e)


fun just_colors(cards) =
    case cards of
         [] => []
       | c::cs => card_color(c) :: just_colors(cs)

fun all_same_color_helper(colors) =
  case colors of
       [] => true
     | x::[] => true
     | Red::Red::xs => all_same_color_helper(Red::xs)
     | Black::Black::xs => all_same_color_helper(Black::xs)
     | _::_::xs => false

fun all_same_color(cards) =
  all_same_color_helper(just_colors(cards))

fun sum_cards(cards) =
  let
    fun go(cards, acc) =
      case cards of
          [] => acc
        | c::cs => go(cs, acc + card_value(c))
  in
    go(cards, 0)
  end

fun score(cards, goal) =
  let
    val sum = sum_cards(cards)
    val preeliminary_score = if sum > goal then 3 * (sum - goal) else goal - sum
  in
    if all_same_color(cards) then preeliminary_score div 2 else preeliminary_score
  end

fun officiate(cards, moves, goal) =
  let
    fun go(held_cards, cards, moves) =
      case moves of
          [] => held_cards
        | Draw::rest => (case cards of
                             [] => held_cards
                           | x::xs => if sum_cards(x::held_cards) > goal
                                      then x::held_cards
                                      else go(x::held_cards, xs, rest))
        | (Discard card)::rest => go(remove_card(held_cards, card, IllegalMove), cards, rest)
  in
    score(go([], cards, moves), goal)
  end
