
(* Type for a module *)
signature MathLib =
sig
  val times_four: int -> int
end

structure MyMath :> MathLib =
struct
  fun double x = x * 2 (* private, cannot be accessed from the outside *)
  fun times_four x = (double o double) x (* public, can be accesed from the outside *)
end


fun times_eight x = 2 * MyMath.times_four x


signature PeopleLib =
sig
  type People (* People is an Abstract Data Type *)
  val make_people: int list -> People
end


structure People :> PeopleLib =
struct
  datatype People = People of int list;
  fun make_people ids = People ids
end
