(* QUESTION 1 *)
datatype expr = Var of Atom.atom
              | Apply of expr*expr
              | Lambda of Atom.atom*expr

datatype lamdaLet = lVar of Atom.atom
                  | lApply of lamdaLet*lamdaLet
                  | lLambda of Atom.atom*lamdaLet
                  | lLet of Atom.atom*lamdaLet*lamdaLet

datatype lamdaLetrec = lrVar of Atom.atom
                     | lrApply of lamdaLetrec*lamdaLetrec
                     | lrLambda of Atom.atom*lamdaLetrec
                     | lrLet of Atom.atom*lamdaLetrec*lamdaLetrec

(* QUESTION 2 *)
