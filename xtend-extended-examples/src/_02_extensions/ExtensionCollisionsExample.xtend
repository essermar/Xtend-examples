package _02_extensions

import java.math.BigDecimal

//import static extension _02_extensions.StaticExtension2.*
//import static extension _02_extensions.StaticExtension1.*
import org.junit.Test
import static org.junit.Assert.*

class ExtensionCollisionsExample {

	//	val extension MemberExtension1 ext1 = new MemberExtension1
	//	val extension MemberExtension2 ext2 = new MemberExtension2
	// class internal "extension" methods have highest priority
	def BigDecimal addSomething(BigDecimal d) {
		d.add(1bd)
	}

	@Test
	def void extensionExample() {

		/* extension functions are cool
		* they are dangerous as well - if you don't know where they come from
		* play around commenting in/out the static extension imports,
		* extension fields and "local" methods */
		assertEquals(1bd, 0bd.addSomething())
	}
}

class MemberExtension1 {
	def BigDecimal addSomething(BigDecimal d) {
		d.add(2bd)
	}
}

class MemberExtension2 {
	def BigDecimal addSomething(BigDecimal d) {
		d.add(3bd)
	}
}

class StaticExtension1 {
	def static BigDecimal addSomething(BigDecimal d) {
		d.add(4bd)
	}
}

class StaticExtension2 {
	def static BigDecimal addSomething(BigDecimal d) {
		d.add(5bd)
	}
}
