package _04_dispatch

import java.math.BigInteger
import org.junit.Test

import static org.junit.Assert.*

/*
 * Dispatch methods, a.k.a: multimethod or polymorphic dispatch.
 * Simulate dynamic method binding; i.e.: binding based on the runtime-types
 * of a call's arguments.
 * Remember: In Java, binding to overloaded method happens at compile-time.
 * Achieved via if-instanceof-cast-call cascades in the generated code.
 */
class DispatchMethodExample {

	// Need Void paramater to catch null
	def dispatch doSomething(Void nullArg) { "null" }

	// Dispatch method with most specific parameter type is considered first
	def dispatch doSomething(Object o) { "o" }

	def dispatch doSomething(Number n) { "n" }

	def dispatch doSomething(BigInteger bi) { "bi" }

	@Test
	def void dispatchExampleOneParameter() {
		assertEquals("o", "o".doSomething)
		assertEquals("n", 3.doSomething)
		assertEquals("bi", 3bi.doSomething)

		// Not possible in Java. Very useful in generator code!
		val Object three = 3
		assertEquals("n", three.doSomething)

		assertEquals("null", null.doSomething)
	}

	/* Dispatch methods with multiple parameters are bound by
	 * evaluating the parameter types from left to right
	 */
	def dispatch doSomething(Object o, Integer b) { "a" }

	def dispatch doSomething(Number o, Object b) { "b" }

	def dispatch doSomething(Integer o, Number b) { "c" }

	@Test
	def void dispatchExampleTwoParameters() {
		assertEquals("a", doSomething("x", 3))
		assertEquals("a", "x".doSomething(3))

		assertEquals("b", doSomething(3bi, 3))
		assertEquals("c", doSomething(3, 3))
	}
}
