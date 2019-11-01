# Notes on Rust's ownership and related concepts.

Rust uses move semantics and an ownership model to manage and keep
track of resources. In this brief set of notes we give a quick
reference for the rules of the game.

# When is it applicable?

Intuitively, rusts move semantics and ownership rules are _not
applicable_ unless the object holds some non-trivial resource be it
memory or something else. Examples for these types are types like the
many unsigned and signed integral types like `u8`,...,`u64`,
`i8`,...,`i64`.

Whether to use move semantics for a given variable `x` is in essence a
property associated with the type of `x`. [`Traits`][traits] are what
`rust` uses to classify types and in this case rust decides to use
move semantics only for types that _do not_ have the [`Copy`
trait][trait-Copy]. Analogy with real world is good at this
point. There are certain things that can be replicated without much
cost, for example this particular notes that you are currently
viewing, has many copies, one for each viewer. On the other hand if
there was a printed version of this notes in your library, it is not
very easy to replicate it. If you need to read it, you will have to
borrow it from the owner (library) in this case. Types that implement
the [`Copy` trait][trait-Copy] are cheap to copy (typically things for
which shallow copy is enough) and rust does not bother to bring in its
move semantics. For every thing else it is like the [strict
headmaster][strict-headmaster] who takes to task any violators of the
borrowing rules.

# Freeing resources.

As already discussed, the only criteria for using the move semantics
for a variable is the lack of the [`Copy` trait][trait-Copy] for its
type. There is really no other criteria. Rust has another trick that
allows it to free resources in a timely fashion. A resource for us
could be a heap allocated memory block or a file pointer or any such
object. For any type `T` that is meant to keep track of a resource, we
can guarantee timely cleanup of resources by providing the
implementation of the [`Drop` trait][trait-Drop] for `T`. Rust
guarantees to call the associated `drop` function when the last owner
of the value is no more live. For example, in the following snippet of
code

```rust

let x = T::new()

{
let y : T = x;   // x lost ownership to y

// stuff using y


} // y, the last owner, dies here and rust ensures y.drop() is called


```

# Rules for copying

Consider any type `T` for which the move semantics is applicable,
i.e. T does not implement the `Copy` trait.

1. An assignment transfers the ownership

        let x : T = ...;
		let y : T = x    // y is the owner of the resource now
		/* using x here will result in error */

2. Reference variables "borrow" the resource allocated for x and
   the value is obtained from the reference via the dereferencing
   operation.

	    let x : T = ...
		let y : &T = &x
		/* using x here is okey */

3. During the life time of the borrow, there should not be a move from
   the original owner.

        let x : T = ..;
		{ // Make a new lifetime by opening a brace y lives
	      // only till the end of this.
		   let y = &x;
		  ...
		}
		let u = x // this is okey as long as there is the braces around y's
                  // definition stays. Try removing the brace and see the compiler
				  // complain.

4. At most a single mutable reference (and thereby a mutable borrow)
   can exist for a give object, that to if the object in question is
   mutable. In particular, you _cannot_ create a mutable reference
   pointing to `x` if any of the following is true

     - The variable `x` is immutable
     - There are other reference (mutable or otherwise) to x that is
	   alive at the same time.

5. When a function is called, every parameter should be seen as an assignment
   and hence the same rules as that of assignment is valid.

[trait-Copy]: <https://doc.rust-lang.org/std/marker/trait.Copy.html>
[trait-Drop]: <https://doc.rust-lang.org/std/ops/trait.Drop.html>
[strict-headmaster]: <https://www.youtube.com/watch?v=ppVpdsClN80> "Rowan Atkinson: School"
[traits]:<https://doc.rust-lang.org/1.8.0/book/traits.html> "Traits in Rust"
