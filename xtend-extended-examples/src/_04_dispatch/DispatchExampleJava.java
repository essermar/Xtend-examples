package _04_dispatch;

import static org.junit.Assert.*;

import java.math.BigInteger;

import org.junit.Test;

/** 
 * Method dispatching: Calling a specific method implementation at runtime.
 * If possible, Java tries to bind calls early, at compile-time. Cheap!
 * Binding algorithm (simplified):
 * Find all method definitions that match the call's name and whose parameters
 * are compatible with the static types of the call's arguments.
 * If multiple applicable method definitions are found, choose the most specific one.
 * That is the one whose parameter types most closely match the call's argument types.
 */
public class DispatchExampleJava {
	public String doSomething(Object o) {
		return "o";
	}

	public String doSomething(Number n) {
		return "n";
	}

	public String doSomething(BigInteger bi) {
		return "bi";
	}

	@Test
	public void dispatchExampleOneParameter() {
		// 'doSomething' bound at compile-time
		assertEquals("o", doSomething("str"));
		assertEquals("n", doSomething(3));
		assertEquals("bi", doSomething(BigInteger.valueOf(3)));

		/* Common situation in generators:
		 * Generator interface receives model elements of a common base-type;e.g.: Object.
		 * Needs to decide what to generate from them based on their runtime-type.
		 * Model is usually sealed. So real polymorphism is not an option.
		 * In Java often solved with if-else cascades that determine runtime-type with
		 * 'instanceof' and then down-cast to bind to a more specific generator method.
		 */
		// 'doSomething' bound at compile-time
		Object i = 1;
		assertNotEquals("n", doSomething(i));
		// To do something based on runtime-type (Integer), an explicit down-cast is necessary
		assertEquals("n", doSomething((Integer) i));
	}
	

	
	public String doSomething(Object o, Integer b) {
		return "a";
	}

	public String doSomething(Number o, Object b) {
		return "b";
	}

	public String doSomething(Integer o, Number b) {
		return "c";
	}

	@Test
	public void dispatchExampleTwoParameters() {
		assertEquals("a", doSomething("x", 3));

		/* When multiple definitions match the same call, the Java compiler sometimes
		 * cannot decide which method is the most specific. 
		 * Because for one method to be more specific than another,
		 * all its parameter types have to be more specific than the other's.
		 * 
		 * The following calls are not possible in Java without casts.
		 * Xtend works around this with polymorphic dispatching. 
		 */
		//assertEquals("b", doSomething(BigInteger.valueOf(3), 3));
		assertEquals("b", doSomething(BigInteger.valueOf(3), (Object)3));
		// assertEquals("a", doSomething(3, 3);
		assertEquals("a", doSomething((Object)3, (Integer)3));
	}
}
