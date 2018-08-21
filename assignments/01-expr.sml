(*

Assignment 1. Due on 30th Aug Thursday by 12:00 noon.

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
