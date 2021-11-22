structure TypeInf = struct


(* monotypes *)
datatype typ = TV of Atom.atom
	     | A of typ * typ

(* unification algorithm for mono types *)


type equation = typ * typ  (* τ₁ ≡ τ₂ *)

(*  α₁ := κ₁ ; ...... αᵢ := κᵢ, ...... αₙ := κₙ

Not all substitutions are okey.

1. FV(κᵢ) ∩ { α₁, .... αₙ } = ∅

We cannot enforce this condition in the types but we have to be
careful when updating the substitution.

2. Telescope condition ::  FV(κᵢ)

   FV(κᵢ) ∩  {α₁,....,αᵢ} = ∅
   FV(κ₁) ∩ { α₁ } = ∅
   FV(κ₂) ∩ {α₁, α₂ } = ∅
   FV(κ₃) ∩ {α₁, α₂, α₃ } = ∅
   ....
   ...


   Notice that FV(κₙ) ∩ {α₁,...,αₙ} = ∅

   α₁ := κ₁[αₙ := κₙ], α₂ := κ₂[αₙ := κₙ] ...... , αₙ := κₙ


  τ[T] = (τ[ α₁ := κ₁])[α₂ := κ₂])....


  Trivially the empty map satisfies the Telescopic property.

 *)

type subst = typ AtomMap.map
type tel  = typ AtomMap.map

fun substitute (s : subst) (TV x)
    = case AtomMap.find (s, x) of
	  SOME kappa => kappa
	| _          => TV x

fun substitute (s : subst) (A (t1, t2)) = A (substitute s t1, substitute s t2)


fun


exception NotImplemented
exception UnificationFailure

(*
   (τ₁ ≡ τ₁') , empty substitution -> T₁
   τ₂ ≡ τ₂' , T₁ -> T₂
   ....
   ....


foldr ⊗ [a₁, a₂, .... aₙ ] b₀ =   (a₁ ⊗ (a₂ ⊗ ..... (aₙ ⊗ b₀))
foldl ⊗ [a₁, a₂, .... aₙ ] b₀ =   ((b₀ ⊗ a₁) ⊗ a₂) ⊗ ..... ⊗ aₙ)

a's are your equation

b's are your subsitution

  is unifyGen a b


*)



(*

Solve τ₁ ≡ τ₂    under T is by definition solve
      τ₁[T] ≡ τ₂[T]


α = α -> β

*)
fun unify (TV x , t)                 = AtomMap.singleton (x, t) (* Some check needs to be done *)
  | unify (t    , TV y)              = AtomMap.singleton (y, t)
  | unify (A (t1,t2) , A (t1', t2')) = unifyList [ (t1,t1') , (t2,t2') ]
  | unify (_, _)                     = raise UnificationFailure
and unifyList eqns = unifyGenList AtomMap.empty eqns
and unifyGen inS (t1, t2) : subst =
    let fun subE s (t1, t2) = (substitute s t1, substitute s t2)
    in
	unify (subE inS eqn)
    end
and unifyGenList inp : equation list -> subst =
    let fun fld (e,s) = let val out = unifyGen s e in
			in combine s out
    in
	foldr fld inp
    end

(* Checking for recursion is complicated

First find the variables in t if x is present there is recursion.
otherwise {y₁, ..., yₙ } then find the k₁,k₂... kₙ as the image of these variables
under the telescope check whether x occurs in k₁, ... kₙ


*)
fun unifyGenT tel (TV x, t) =
    case AtomMap.find (tel, x) of
	SOME kappa => unifyGenT tel (kappa, t)
     |  NONE    => AtomMap.insert (tel, x, t) (* Check there is no recursion in variables *)

(*

T :=
α₁ := α -> β
β  := γ -> α

expand T (α₁ -> α₁)  = (α -> (γ-> α)) -> (α -> (γ -> α))


*)
fun expand tc (TV x) = case AtomMap.find (tc, x) of
				    SOME κ  => expand tc κ
				 |  NONE    =>  TV x

fun expand tc (A (t1 , t2)) = A (expand tc t1, expand tc t2)

(*

Solve τ₁ ≡ τ₁' .... τₙ ≡ τₙ'  under T

 τ₁ ≡ τ₁' under T to get T₁
 τ₂ ≡ τ₂' under T₁ to get T₂


α -> β ≡ int -> β        { α := int }

int -> char ≡ α -> β


int -> char ≡ int -> β    { β := char }


*)


(*
fun unifyGenList (inp : subst) (eqns : equation list) : subst =
    let fun fld (e,s) = unifyGen s e
    in
	foldr fld inp eqns
    end

*)

end
