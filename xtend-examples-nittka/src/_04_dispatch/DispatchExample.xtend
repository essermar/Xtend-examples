package _04_dispatch

import java.math.BigInteger
import org.junit.Test

import static org.junit.Assert.*

/* In Java, method resolution and binding happen at compile-time.
 * In Xtend, this can be done dynamically based on the runtime-types of the method
 * arguments. See generated code.*/
class DispatchExample {

	// need Void paramater to catch null
	def dispatch doSomething(Void nullArg) { "null" }

	// dispatch method with most specific parameter type is considered first
	def dispatch doSomething(Object o) { "x" }

	def dispatch doSomething(Number b) { "y" }

	def dispatch doSomething(BigInteger i) { "z" }

	@Test
	def void dispatchExampleOneParameter() {
		assertEquals("x", "x".doSomething)
		assertEquals("y", 3.doSomething)
		assertEquals("z", 3bi.doSomething)
		assertEquals("y", (3 as Object).doSomething)
		assertEquals("null", null.doSomething)
	}

	// dispatch methods with multiple parameters are ordered by
	// evaluating the parameter types from left to right
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
