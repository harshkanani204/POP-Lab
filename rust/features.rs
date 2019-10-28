fn main()
{

    /* This is a short program demonstrating some of the features of
     ** rust type system. There are some commented, syntactically valid
     ** lines that you can uncomment. These will lead to errors but those
     ** errors illustrate what has gone wrong.
     **
     **/


    /************** Mutability  ****************************************/

    let x = 10;       /* x is not mutable and hence you cannot change
                         its value.
                       */
    let mut y  = 100;  /* y is mutable can hence can change its value */
    println!("x = {0} and y = {1}",x,y);
    y = 42;

    // x = 42; // Uncomment and get an error

    println!("x = {0} and y = {1}",x,y);

    /************** End demo on Mutability ******************************/

    /*************** Ownership ******************************************/

    let xbox  = Box::new(10);
    println!("xbox = {0}", xbox);

    let ybox  = xbox; /* Ownership has transfered from xbox to ybox */

    // println!("xbox = {0}", xbox); // Uncomment and get an error

    println!("ybox = {0}", ybox);

    let zbox = &ybox; /* zbox borrows the resource form y */

    println!("ybox = {0} and zbox = {1}", ybox, zbox);


}
