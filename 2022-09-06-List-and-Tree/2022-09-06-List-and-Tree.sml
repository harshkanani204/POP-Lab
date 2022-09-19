(* QUESTION 1 *)
(* `map : ('a -> 'b) -> 'a list -> 'b list` *)
fun map f [] = []
    | map f (x :: xs) = f x :: map f xs


(* QUESTION 2 *)
datatype 'a tree = Null 
    | Node of 'a tree * 'a * 'a tree


(* QUESTION 3 *)
(* treemap : ('a -> 'b) -> 'a tree -> 'b tree *)
fun treemap f Null = Null
    | treemap f (Node(left,root,right)) = Node(treemap f left, f root, treemap f right)


(* QUESTION 4 *)
(* 'inorder : 'a tree -> 'a list *)
fun inorder Null = []
    | inorder (Node(left, parent, right)) = (inorder (left)) @ (parent :: inorder right)

(* 'preorder : 'a tree -> 'a list *)
fun preorder  Null = []
    | preorder (Node(left, parent, right)) = [parent] @ preorder (left) @ preorder (right)

(* 'postorder : 'a tree -> 'a list *)
fun postorder Null = []
    | postorder (Node(left, parent, right)) = postorder (left) @ postorder (right) @ [parent]


(* QUESTION 5 *)
(* rotateClockwise : 'a tree -> 'a tree *)
fun rotateClockwise (Node(Node(t1,b,t2),root, right)) = Node(t1, b, Node(t2, root, right))
    | rotateClockwise someTreeWithLeftNull = someTreeWithLeftNull