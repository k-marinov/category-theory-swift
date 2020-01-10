/// Introduction
///
/// A category is a suprisingly simple concept. A category consists of objects and arrows that go between
/// them. But the essence of a category is composition. Or the essence of composition is a category.
/// Arrows compose, if you have an arrow from object A to object B and another arrow from object B to object C,
/// then there must be an arrow - their composition - that goes from A to C


/// 1.1 Arrows as Functions
///
/// Think of arrows, which are also called morphisms, a functions. For example you have a function 𝑓 that takes
/// an argument of type A and returns a B. You have another function g that takes a B and returns a C.
///
/// In a category, if there is an arrow going from A to B and arrow going from B to C then there must also be
/// a direct arrow from A to C that is their composition. This diagram is not a full category because it's
/// missing identity morphisms. You can compose them by passing the result of 𝑓 and g. You have just defined
/// a new function that takes an A and returns a C.
///
/// In math, such a composition is denoted by a small circle between functions: 𝑔 ∘ 𝑓. Notice the right to left
/// order of the composition. In mathematics and in Haskell functions compose right to left. It helpfs if you
/// read 𝑔 ∘ 𝑓 as "g after f"


///  Function implementation from A -> B can be implemented in the following examples where the object A is
///  provided as the argument for the parameter a

let incrementByOne: (Int) -> Int = { value in return value + 1 }

func f1<A,B>(a: A, transform: @escaping (A) -> B) -> B {
    return transform(a)
}

let result1 = f1(a: 5, transform: incrementByOne) // result = 6


/// Or where the object A is provided by currying the argument (because it is not function param anymore as
/// as the f1 function), notice when the return is a ((A) -> B)
/// closure from A to B, in the method body argument a is available for the transformation.

func f2<A,B>(_ transform: @escaping (A) -> B) -> ((A) -> B) {
    return { a in
        return transform(a)
    }
}

let result2 = f2(incrementByOne)(5) // result = 6
