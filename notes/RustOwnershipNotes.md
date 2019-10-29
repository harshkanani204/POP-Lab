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

Rust decides to use move semantics only for types that _do not_ have
the [`Copy` trait][trait-Copy]. In other words, types that implement
the [`Copy` trait][trait-Copy] are cheap to copy (typically things for
which shallow copy is enough) and rust does not bother to bring in its
move semantics.

# Objects with resource

If the type in question also has additional resource, it might be
prudent to free these resource. For such types rust provides the
[`Drop` trait][trait-Drop] where you need to define a single function
`drop`

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
		/* using x here is */

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
