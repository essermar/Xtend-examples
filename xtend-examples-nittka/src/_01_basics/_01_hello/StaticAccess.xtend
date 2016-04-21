package _01_basics._01_hello

import org.junit.Test
import _01_basics.util.ContainerClassWithStaticMembers
import static org.junit.Assert.*

class StaticAccess {
	@Test
	def void staticAccess() {

		// field
		assertEquals("This is a constant.", ContainerClassWithStaticMembers.CONSTANT)
		assertEquals("This is a constant.", ContainerClassWithStaticMembers::CONSTANT)

		assertEquals("result", ContainerClassWithStaticMembers.INSTANCE.result)
		assertEquals("result", ContainerClassWithStaticMembers::INSTANCE.result)

		// method
		assertTrue(ContainerClassWithStaticMembers.isStaticMethod)
		assertTrue(ContainerClassWithStaticMembers::isStaticMethod)

		// nested class
		assertEquals("innerResult", new ContainerClassWithStaticMembers.TheInnerClass().result)
		assertEquals("innerResult", new ContainerClassWithStaticMembers.TheInnerClass().result)
	}
}
