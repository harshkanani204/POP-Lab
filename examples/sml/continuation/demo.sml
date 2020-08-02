open SMLofNJ.Cont

functor Save (type t) = struct


val donothing = isolate (fn (_:t) => (print "do nothing"))
fun seal k    = isolate (fn x => throw k x)
val contRef   = ref donothing
fun save (a : t) = callcc (fn me => (contRef := seal me; a))
fun run  (a : t) = let val sealed = seal (!contRef)
		   in throw sealed a; contRef := donothing end
end

structure SU = Save (type t = unit)


fun action p = let fun prompt x = print (p ^ ": " ^ x ^ "\n")
	       in (SU.save (prompt "saving"); prompt "continuing")
	       end

fun alice () = action "alice"
fun bob () = action "bob"

structure SI = Save (type t = int)

val printInt = print o Int.toString
val u = (printInt (SI.save 10 + 3); print "\n")
val _ = (SI.run 100)
