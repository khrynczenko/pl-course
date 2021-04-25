fun is_older (lhs: (int * int * int), rhs: (int * int * int)) = 
    let
      val y1 = #1 lhs
      val m1 = #2 lhs
      val d1 = #3 lhs
      val y2 = #1 rhs
      val m2 = #2 rhs
      val d2 = #3 rhs
    in
      if lhs = rhs
      then false
      else if y1 = y2
      then (if m1 = m2 then d1 < d2 else m1 < m2)
      else y1 < y2
    end

fun number_in_month (dates: (int * int * int) list, month: int) = 
    if null dates
    then 0
    else if (#2 (hd dates)) = month
    then 1 + number_in_month(tl dates, month)
    else number_in_month(tl dates, month)

fun is_in_month(date: (int *int * int), months: int list) =
    if null months
    then false
    else if (hd months) = (#2 date)
    then true
    else is_in_month(date, tl months)

fun number_in_months (dates: (int * int * int) list, months: int list) =
    if null dates
    then 0
    else if is_in_month((hd dates), months)
    then 1 + number_in_months((tl dates), months)
    else number_in_months((tl dates), months)

fun dates_in_month (dates: (int * int * int) list, month: int) =
    if null dates
    then []
    else if (#2 (hd dates)) = month
    then (hd dates) :: dates_in_month(tl dates, month)
    else dates_in_month(tl dates, month)

fun dates_in_months (dates: (int * int * int) list, months: int list) =
    if null dates
    then []
    else if is_in_month((hd dates), months)
    then (hd dates) :: dates_in_months((tl dates), months)
    else dates_in_months((tl dates), months)

fun get_nth(texts: string list, n: int) =
    if n = 1
    then hd texts
    else get_nth(tl texts, n - 1)

val months = ["January", "February", "March", "April", "May", "June", "July",
              "August", "September", "October", "November", "December"]

fun date_to_string(date: (int * int * int)) =
    get_nth(months, (#2 date)) ^ " " ^ Int.toString((#3 date)) ^ ", " ^
    Int.toString((#1 date))
    
fun number_before_reaching_sum(sum: int, numbers: int list) =
      let
          val next = hd numbers
          val will_be_bigger = (sum - next) <= 0
      in
          if will_be_bigger
          then 0
          else 1 + number_before_reaching_sum(sum - next, tl numbers)
      end

val month_ranges = [31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334, 365]

fun falls_in(day: int, months: int list) =
    if day <= hd months
    then 1
    else 1 + falls_in(day, tl months)

fun what_month(day: int) =
    falls_in(day, month_ranges)

fun count_up_months(from: int, to: int) =
    if from <= to
    then what_month(from) :: count_up_months(from + 1, to)
    else []


fun month_range(day1: int, day2: int) =
    if day1 > day2
    then []
    else count_up_months(day1, day2)

fun get_oldest(old: (int * int * int), dates: (int * int * int) list) =
    if null dates
    then old
    else if is_older(hd dates, old)
    then get_oldest(hd dates, tl dates)
    else get_oldest(old, tl dates)

fun oldest(dates: (int * int * int) list) =
    if null dates
    then NONE
    else SOME (get_oldest(hd dates, tl dates))
