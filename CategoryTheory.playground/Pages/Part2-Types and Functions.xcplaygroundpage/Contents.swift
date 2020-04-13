//: [Previous](@previous)

import Foundation

/// # 2.1 Who Needs Types?
///
/// For example in a dynamically typed language, type mismatches would be discovered at runtime, in strongly
/// typed statically checked languages type mismatches are discovered at compile time, eleminating lots of incorrect
/// programms before they have a chance to run.
///
/// # 2.2 Types Are About Composability
///
/// Category theory is about composing arrows. But not any two arrows can be composed. The target object of one
/// arrow must be the same as the source object of the next arrow.
///
/// Example:
/// f: (A) -> B and g: (B) -> C are composable because first function returns a value of type B which can be
/// injected as argument into the (B) -> C and return a value of type C
/// let c = g(f(a))
///
/// Testing is almost always a probabilistic rather than a deterministic process. Testing is a poor substitute for proof.

/// # 2.1 Who Needs Types?
///
/// The simplest intuition for types is that they are sets of values. The type Bool is a two-element set of
/// True and False. Type Char is a set of all Unicode characters like a or b.
///
/// Sets can be finite or infinite. The type of String, which is a synonym for a list of Char, is an example of
/// infinite set.

/// 2.3 What Are Types?
///
/// When we declare x to be an Integer:
/// x :: Integer
/// We are saying that it is an elemen of the set of integers. Integer in Haskell is an infinite set, and
/// it can be used to do arbitrary precision arithmetic. There is also a finite-set Int that corresponds to
/// machine type, just like the C++ int.
///
/// Set is a very special category, because we can actually peek inside its objects and get a lot of intuitions
/// from doing that. For instance, we know that an empty set has no elements. We know that there are special
/// one-element sets. We know that functions map elements of one set to elements of another set.
/// They can map two elements to one, but not one element to two. We know that an identity function maps each
/// element of a set to itself, and so on.

/// In the ideal world we would just say that Haskell types are sets and Haskell functions are mathematical
/// functions between sets. There is just one little problem: A mathematical functions does not execute any
/// code, it just knows the answer. A Haskell function has to calculate the answer. But there are some cal-
/// calculations that involve recursion and those might never terminate.

/// That's why computer scientists came up with a brilliant idea, or a major hack, depending on your point of
/// view, to extend every type by one more special value called the bottom and denoted by Unicode ⊥. This
/// value corresponds to a non-terminating computation.

/// f :: Bool -> Bool
/// f x = undefined

/// Functions that may return bottom are called partial, as oppose to total functions, which return valid
/// results for every possible argument.

