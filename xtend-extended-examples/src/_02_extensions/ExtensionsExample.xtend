package _02_extensions

import java.math.BigDecimal
import org.junit.Test

import static org.junit.Assert.*

import static extension util.ContainerClassWithStaticMembers.isTheEmptyString

/*
 * Extension methods allow adding new methods to existing types without modifying them.
 * May increase readability. Useful for integrating static utility functions.
 * Extension mechanism is based on a very simple syntactic trick:
 * Remove the first argument of an extension method invocation from the argument list and use it 
 * as the receiver of the method call instead.
 * Thus it appears as if the method was one of the argument type's member functions.
 */
class ExtensionsExample {

	/** 
	 * LOCAL
	 * Methods owned by the current class or a superclass are automatically available as
	 * extension methods. That includes static methods. Must be accessible, of course.
	 */
	@Test
	def void localExtensionExample() {

		// Standard method call
		// Notice the BigDecimal literals available in Xtend
		assertEquals(1bd, addOne(0bd))
		/*  Extension method syntax:
		 *  Highlighting indicates that 'addOne' is an extension method call.
		 *  Parentheses are, of course, optional.
		 */
		assertEquals(1bd, 0bd.addOne())
	}

	def private addOne(BigDecimal number) {
		// number.add(1bd)
		number.add(new BigDecimal("1"));
	}

	/** 
	 * XBASE LIBRARY 
	 * The Xbase library includes a lot of classes with static util methods that operate on common
	 * Java SDK types. Examples: StringExtensions (for String), BooleanExtensions (for booleans),
	 * CollectionExtensions (for Collection)
	 * These methods are available inside Xtend classes as extension methods without further ado.
	 * (Implicit import. See Java output.)
	 */
	@Test
	def void xtendLibraryExtensionExample() {
		
		// Extension method syntax
		assertEquals('Hello', 'hello'.toFirstUpper())
		// Equivalent standard syntax on implicitly imported library class 'StringExtensions'
		assertEquals('Hello', StringExtensions.toFirstUpper('hello'))

		/* Inline operators for big decimals (also extension methods, not part of the Java runtime lib!)
		 * See classes OperatorMapping and BigDecimalExtensions */
		assertEquals(0bd, (2bd / 2bd - 1bd))
	} 

	/**
	 * STATIC EXTENSION IMPORT
	 * Use 'import static extension' to make static methods of an imported class locally available
	 * as extension methods.
	 */
	@Test
	def void extensionImportExample() {
		val String nullString = null;

		// Extension method syntax
		assertFalse(nullString.isTheEmptyString())
		// Traditional call (static import!)
		assertFalse(isTheEmptyString(nullString))

		val theEmptyString = "";
		assertTrue(theEmptyString.isTheEmptyString())
	}

	/**
	 * EXTENSION PROVIDER
	 * By adding the extension keyword to a field, a local variable or a parameter declaration, 
	 * their instance methods become extension methods.
	 */
	@Test
	def void extensionProviderExample() {
		val extension encryptor = new Encryptor
		val mySecret = new Object
		assertEquals("totally secure", mySecret.encrypt() /*encryptor.encrypt(mySecret) */)
	}

	static class Encryptor {
		def encrypt(Object object) {
			'totally secure'
		}
	}
}
