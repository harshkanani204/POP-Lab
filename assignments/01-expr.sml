(* Assignment 1

Name:
Rollno:

*)
datatype binop = PLUS  | MINUS | MUL | DIV
datatype uniop = UPLUS | UMINUS

datatype expr  = C of real
	       | B of binop * expr * expr
	       | U of uniop * expr

(* Your task is to write the following functions

binopDenote : binop -> real * real -> real
uniopDenote : uniop -> real -> real
exprDenote  : expr  -> real

*)
