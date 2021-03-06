/// # Introduction
///
/// A category is a suprisingly simple concept. A category consists of objects and arrows that go between
/// them. But the essence of a category is composition. Or the essence of composition is a category.
/// Arrows compose, if you have an arrow from object A to object B and another arrow from object B to object C,
/// then there must be an arrow - their composition - that goes from A to C


/// # 1.1 Arrows as Functions
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
/// order of the composition. In mathematics and in Haskell functions compose right to left. It helps you can
/// read 𝑔 ∘ 𝑓 as "g after f"


///  # Function implementation from A -> B
///
///  It can be implemented in the following examples where the object A is
///  provided as the argument for the parameter a

func f1<A,B>(a: A, transform: @escaping (A) -> B) -> B {
    return transform(a)
}

/// Or where the object A is provided by currying the argument (because it is not function param anymore as
/// as the f1 function), notice when the return is a ((A) -> B)
/// closure from A to B, in the method body argument a is available for the transformation.

func f2<A,B>(_ transform: @escaping (A) -> B) -> ((A) -> B) {
    return { a in
        return transform(a)
    }
}

/// Usage of the both functions
let incrementByOne: (Int) -> Int = { (value: Int) in return value + 1 }

let result1 = f1(a: 5, transform: incrementByOne) // result = 6
let result2 = f2(incrementByOne)(5) // result = 6


/// # Function implementation from B -> C
///
/// Follows the same as above.

func g1<B,C>(b: B, transform: @escaping (B) -> C) -> C {
    return transform(b)
}

func g2<B,C>(_ transform: @escaping (B) -> C) -> ((B) -> C) {
    return { b in
        return transform(b)
    }
}

/// Usage of the both functions

let result3 = g1(b: 5, transform: incrementByOne) // result = 6
let result4 = g2(incrementByOne)(5) // result = 6


/// # Composition of A -> B and B -> C as A -> C
/// Few variations of the composition functions
/// In the v1 version input a is a parameter
func g_after_f_v1<A,B,C>(a: A, f: @escaping (A) -> B, g: @escaping (B) -> C) -> C {
    let b = f(a)
    let c = g(b)
    return c
}

/// In the v2 version input a is provided by currying
func g_after_f_v2<A,B,C>(f: @escaping (A) -> B, g: @escaping (B) -> C) -> (A) -> C {
    return { a in
        let b = f(a)
        let c = g(b)
        return c
    }
}

/// Usage of composition functions
let result5 = g_after_f_v1(a: 10, f: incrementByOne, g: incrementByOne) // result 12
let result6 = g_after_f_v2(f: incrementByOne, g: incrementByOne)(10) // result 12

/// In haskell
///
/// f :: A -> B
/// g :: B -> C
///
/// Composition is g . f or g ◦ f
///
/// So here's the frst Haskell lesson: Double colon means "has the type of..." A function type is created by
/// inserting an arrow between two types. You compose two functions by inserting a period between them or a
/// Unicode circle.
///

/// # 1.2 Properties of Composition
///
/// There are two extremely important properties that the composition in any category must satisfy
///
/// 1. Composition is associative. If you have three morphisms f,g, and h, that can be composed, you
/// you don't need parentheses to compose them. In math notation this is expressed as:
/// ℎ ∘ (𝑔 ∘ 𝑓 ) = (ℎ ∘ 𝑔) ∘ 𝑓 = ℎ ∘ 𝑔 ∘ 𝑓
///
/// In (pseudo) Haskell:
///
/// f :: A -> B
/// g :: B -> C
/// h :: C -> D
/// h. (g . f) == (h . g) == h . g . f

/// 2. For every object A there is an arrow which is a unit of composition. This arrow loops from the object
/// to itself. Being a unit of composition means that, when composed with any arrow that either starts at A or
/// ends at A, respectively, it gives back the same arrow. The unit arrow for object A is called id𝐴
/// (identity on A). In math notation if 𝑓 goes from A to B then
///
/// 𝑓 ∘ id𝐴 = 𝑓
///
/// and
///
/// id𝐵 ∘ 𝑓 = 𝑓
///
/// Every object has an identity arrow that serves as a unit under composition.

/// When dealing with functions, the identity arrow is implemented as the identity
/// function that just returns back its argument. The implementation is same for every type. Which means this
/// function is universally polymorphic.

/// Given a set S, the identity function on S is the function idS:S→S that maps any element x of S to itself:
func id<S>(x: S) -> S {
    return x
}

/// # 1.3 Composition is the Essence of Programming
///
/// Functional programmers have a peculiar way of approaching problems.
/// We decompose bigger problems into smaller problems.
/// If the smaller problems are still too big, we decompose them further,
/// and so on. Finally, we write code that solves all the small problems.
/// And then comes the essence of programming: we compose those pieces
/// of code to create solutions to larger problems.
///
///
/// https://elbauldelprogramador.com/en/scala-category-theory-composition/
/// https://en.wikibooks.org/wiki/Haskell/Category_theory
/// https://blog.karumi.com/monad/
/// http://homepages.inf.ed.ac.uk/jcheney/presentations/ct4d1.pdf
/// http://danshiebler.com/2018-11-10-category-solutions/
/// https://en.wikiversity.org/wiki/Introduction_to_Category_Theory/Sets_and_Functions
/// https://ncatlab.org/nlab/show/identity+function

func compose<A,B,C>(left f: @escaping (A) -> B, right g: @escaping (B) -> C) -> (A) -> C {
    return { g(f($0)) }
}

let transformer = { (value: Int) in return value + 1 }

compose(left: id,  right: transformer)(10) == compose(left: transformer, right: id)(10) // true
