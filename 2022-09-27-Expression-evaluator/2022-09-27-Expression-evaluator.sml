(* QUESTION 1 *)
datatype Expr = Const of real
	          | Var of string
	          | Plus of Expr * Expr
	          | Mul of Expr * Expr

datatype Stmt = Assignment of string * Expr
              | Print of Expr

type Program = Stmt list

(* QUESTION 2 *)
type Env = real AtomMap.map

(* eval : Env -> Expr -> real option *)
fun eval _   (Const x)     = SOME x
    | eval env (Var x)       = AtomMap.find (env, Atom.atom x)
    | eval env (Plus (x, y)) =
		let
			val res = case (eval env x) of
						NONE => NONE
					| (SOME xres) => case (eval env y) of
					  					NONE => NONE
					| (SOME yres) => SOME (xres + yres)
		in
			res
		end
    | eval env (Mul (x, y)) =
		let
			val res = case (eval env x) of
						NONE => NONE
					| (SOME xres) => case (eval env y) of
					  					NONE => NONE
					| (SOME yres) => SOME (xres * yres)
		in
			res
		end

(* execute : Env -> Stmt -> Env *)
fun execute env (Assignment (x, y)) =
		let
		  val res = case (eval env y) of
						NONE        => env
					  | (SOME yres) => AtomMap.insert (env, Atom.atom x, yres)
		in
		  res
		end
    | execute env (Print x) = 
		let
		  val res = case (eval env x) of
						NONE		=> env
					  | (SOME xres) => ((print (Real.toString xres ^ "\n")); env)
		in
		  res
		end


fun foldl f a []        = a
    | foldl f a (x::xs) = foldl f (f a x) xs

(* interpret : Program -> unit *)
fun interpret slist = let val res = foldl execute AtomMap.empty slist
                    in
                        ()
                    end