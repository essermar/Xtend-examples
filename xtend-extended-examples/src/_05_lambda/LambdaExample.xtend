package _05_lambda

import org.junit.Test

import static org.junit.Assert.*

import static extension java.lang.Integer.*

/* Lambda: "anonymous" method.
 * technically: instance of an anonymous type implementing a one-method interface (Function/Procedure)
 * or extending an abstract class with one anonymous method.
 * Closure: "lambda that closes over its environment"; i.e.: needs values from its environment.
 * Very useful when working with iterables :-) */
class LambdaExample {

	// lambda
	val (String,String) => String myStringLambda = [String str, String str2 | str+str2]
	
	// silly closure
	var i = 99
	val (String,String) => String myStringClosure = [String str, String str2 | str+str2+i]

	val exampleObjects = newArrayList("4", 3, true, "9")

	def void doSomething(Object object) {}

	def void illustrateEquivalentNotations() {

		// classic java-like version of a for each loop
		// dirt simple, but not flexible
		for (Object object : exampleObjects) {
			doSomething(object)
		}

		// OOP: one-method interface separates iteration logic from item processing strategy
		// more flexibility, but very verbose
		IterableExtensions::forEach(exampleObjects,
			new Procedures.Procedure1<Object>() {

				override apply(Object parameter) {
					doSomething(parameter)
				}

			})

		// shortened version using a lambda expression (i.e.: instance of a one-method interface)
		IterableExtensions::forEach(exampleObjects, [Object object|doSomething(object)])

		// use forEach as extension method
		exampleObjects.forEach([Object object|doSomething(object)])

		// pull out the last lambda expression
		exampleObjects.forEach()[Object object|doSomething(object)]

		// omit empty parentheses
		exampleObjects.forEach[Object object|object.doSomething]

		// use implicit variable it
		exampleObjects.forEach[Object it|it.doSomething]

		// and omit it
		exampleObjects.forEach[Object it|doSomething]

		// omit Variable declaration (as it can be inferred)
		exampleObjects.forEach[doSomething]

		// not every possible "simplification" improves readability
		// (besides: choose expressive names!)
		mySpecialApply("x", "y", [a, b|a + b + a + b])
		"x".mySpecialApply("y")[a, b|a + b + a + b]
	}

	/* 
	 * A custom method that expects an interface instance
	 * with one method that accepts two Strings and returns one String.
	 * Last parameter is a shorthand for 'Function2' interface.
	 */
//	def mySpecialApply(String s1, String s2, Functions.Function2<String,String, String> function1) {
	def mySpecialApply(String s1, String s2, (String, String)=>String function1) {
		function1.apply(s1, s2)
	}

	@Test
	def void lambdaExample2() {
		assertArrayEquals(#[5, 8, 11], (1 .. 3).map[it * 3 + 2])
		assertEquals(3, exampleObjects.filter(Number).get(0))
		assertFalse((1 .. 10).exists[it > 10])
		assertTrue((1 .. 10).forall[it < 11])
		assertEquals(6, (1 .. 10).findFirst[it > 5].intValue)
		assertEquals(4, (1 .. 10).findLast[it < 5].intValue)
		assertEquals(30, (1 .. 10).filter[it % 2 == 0].reduce[i1, i2|i1 + i2].intValue)

		// just for the sake of completeness (no lambdas here)
		assertEquals(1, (1 .. 10).head.intValue)
		assertEquals(10, (1 .. 10).last.intValue)
		assertEquals("2, 3, 4, 5", (1 .. 5).tail.join(', '))
		assertEquals("1, 2, 3, 4, 5", (1 .. 10).take(5).join(', '))
		assertEquals("6, 7, 8, 9, 10", (1 .. 10).drop(5).join(', '))

		// note that a 'Procedure' used in a lambda may be non-trivial
		// mapped to a one-method interface with possibly complex method body
		exampleObjects.forEach [
			var x = 13
			for (y : 1 .. x) {
				if (it.toString.length % y == 0) {
					doSomething
				}
			}
		//...
		]
	}

	@Test
	def void lambdaExample3() {

		//you can overdo it
		//TODO rewrite using properly named extension methods
		val result = (10 .. 1).map[toString].sortBy[it].fold(0)[i1, String s2|i1 + println(s2).parseInt]
		assertEquals(55, result)
		
//		val integerStrings = (10..1).map[toString]
//		val integerStringsInAscendingOrder = integerStrings.sortBy[it]
//		val sum = integerStringsInAscendingOrder.fold(0)[int aggregator, String str | println(str); aggregator + str.parseInt()]
//		assertEquals(55, sum)
	}
}
