package _04_dispatch;

import static org.junit.Assert.*;

import java.math.BigInteger;

import org.junit.Test;

public class DispatchExampleJava {
	public String doSomething(Object o) {
		return "x";
	}

	public String doSomething(Number b) {
		return "y";
	}

	public String doSomething(BigInteger i) {
		return "z";
	}

	@Test
	public void dispatchExampleOneParameter() {
		assertEquals("x", doSomething("x"));
		assertEquals("y", doSomething(3));
		assertEquals("z", doSomething(BigInteger.valueOf(3)));

		Object i = 1;
		assertNotEquals("y", doSomething(i));
		assertEquals("y", doSomething((Integer) i));
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
		// Not possible in Java without casts. Ambiguous calls.
		assertEquals("b", doSomething((Number)BigInteger.valueOf(3), (Object)3));
		assertEquals("a", doSomething((Object)3, 3));
	}
}
