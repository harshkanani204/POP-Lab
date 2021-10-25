# Expression evaluator

Deadline: 26th October 2021, 23:59


1. Design an algebraic data type to capture expressions over real constants. You can
   have operators + and *.

2. Design a small programming language which consists of two things

    - An assignement of variables x := e
    - Printing an expresions value print e

    ```sml

    datatype Expr = Const of real
                   ....

    (* Expressions can either be

         1. Constant
         2. Variable
         3. Plus applied on two expressions
         4. Mul applied on two expressions

    *)
    datatype Stmt = ...

    (*
       1. Assignment
       2. Print statement
    *)

    ```

    You capture the abstract syntax of the language as an algebraic data type in SML.

    - Evaluator : evaluates the given expression with respect to the current binding of variables.
    - Executor  : Executes the current statement (thereby modifying the bindings) to give a new
        binding environment.

3. Use a the Map data structure as the environment for variable bindings and design
   your expression evaluator and statement executor

   ```
   type Env = real AtomMap.map
   val eval : Expr -> Env -> real option
   val execute : Stmt -> Env -> Env

   ```

4. Alternatively use HashTable data structure to maintain the variable bindings and execute
   statements.


    ```
    type Env = real AtomTable.hash_table
    val eval : Expr -> Env -> real option
    val executor : Stmt -> Env -> ()

    ```

For a detailed documentation of the Map and the HashTable data
structure see the documentation at.


<https://www.classes.cs.uchicago.edu/archive/2015/spring/22620-1/smlnj-lib.html>
