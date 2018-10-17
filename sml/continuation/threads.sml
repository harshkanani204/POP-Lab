(*

There are two models of threading, pre-emptive or co-operative. In a
pre-emptive scheduling each thread is given a share of the cpu-time in
slices. Process cannot keep the CPU-tied to it for ever and control
will be taken back when its allotted time slice is over. In a
pre-emptive multi-tasking system therefore work gets done even when
threads are selfish and adversarial.

In a co-operative multi-threading system, threads should "yield
control" explicitly so that the other threads get their turn to do
useful work. Many applications, like for example a typical server
applications only needs co-operative threading to handle the clients.

This is a implementation of co-operative threading using SML's
continuation. The interface provided is captured by the following
signature.

*)

signature THREAD = sig

    (*
     Spawns a new thread to perform a given action. The spawned
     thread does not gets control immediately rather it is just
     scheduled to be run and the parent thread continues running

    *)
    val spawn : (unit -> unit)  (* The child action *)
		-> unit

    (* Same as spawn but the child thread is run immediately. It is
       the parent that is rescheduled as opposed to the child.
     *)
    val spawnNow : (unit -> unit)  (* The child action *)
		   -> unit

    (* Exit from the current thread. The control now passes to the
       next thread in the pool. No more action in the current thread
       is executed.
     *)
    val exit : unit -> unit

    (*

     Relinquish control to the next thread. In an co-operative
     multi-threaded environment, it is important for threads to yield
     whenever they do not have productive things to do otherwise the
     other threads will starve for cpu.

    *)
    val yield : unit -> unit

    (*

    Wait for all threads to get over. Typically needed in the top
    level thread which spawns all the treads

    *)

    val wait : unit -> unit end

(* Now comes the implementation. *)
functor Thread () : THREAD = struct

(*

We make use of SML's support of continuation to build cheap
threads. For us a thread is just a continuation expecting a unit

*)

open SMLofNJ.Cont
type thread = unit cont

(*

The run-able threads are kept in a queue and are dispatched one after
the other.

*)

structure Q = Queue

val pool : thread Q.queue = Q.mkQueue ()



(* This functions schedulees the next thread in the queue if it exists *)
fun schedule ()  = if   Q.isEmpty pool
		   then print "no threads exists"
		   else throw (Q.dequeue pool) ()

fun exit () = schedule() (* Exiting is just scheduling the next
			    thread. The rest of our computation will
			    never enter the pool and hence they will
			    not be executed
			  *)


(*

The yield action is also pretty much schedule except for a small
difference --- our continuation needs to be stored in the thread pool
so that we can do the rest of our computation.

*)
fun yield ()
    = callcc (fn me => (* callcc fills the variable me with my continuation *)
		 ( Q.enqueue (pool, me); (* save myself for latter scheduling *)
		   schedule ()           (* relinquish control to the next thread *)
		 )
	     )


(* The function spawns a new thread that does the action corresponding
   to the child thread. It looks like all one needs is to create a
   thread is to isolate the current action and enqueue it. The child
   action should explicitly call a schedule so that the next thread in
   the pool gets scheduled. Otherwise, due to the way isolate works,
   when a child is done every other thread gets stuck.

*)
fun spawn childF = let val childT = isolate (fn _ => (childF (); schedule()))
		   in Q.enqueue(pool, childT)
		   end

(* The spawn command gives preference to the parent in the sense that
   the spawned thread is not started immediately. The next function
   gives preference to the child.

 *)

fun spawnNow childF =
    callcc (fn me =>     (* callcc fills the variable 'me' with rest of my computation *)

	       ( Q.enqueue(pool, me); (* queue up my computation for later scheduling *)
		 childF ();           (* but run child action right now   *)
		 schedule ()          (* schedule any thread if it exists *)
	       )

	   )

fun wait ()  = while not (Q.isEmpty pool) do yield ()

end


structure T = Thread ()

fun mesg n s () = if n <= 0
		  then ()
		  else ( print (Int.toString n ^ " " ^ s ^ ">\n");
			 T.yield ();
			 OS.Process.sleep (Time.fromSeconds 1);
			 mesg (n - 1) s ()
	               )
fun main () = (
    T.spawn (mesg 10 "hello");
    T.spawn (mesg 4 "world");
    T.spawn (fn _ => print "I will eventually be run\n");
    T.spawnNow (fn _ => print "I will be run just now\n");
    print "waiting\n";
    T.wait ()
)
