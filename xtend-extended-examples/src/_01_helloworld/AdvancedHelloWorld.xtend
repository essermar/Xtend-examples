package _01_helloworld

// Imports work as in Java
import org.junit.Test

import static org.junit.Assert.*

/*  Multiple type definitions per file possible.
 *  Default access modifier for types and methods is 'public'.
 *  Default access modifier for fields is 'private' (later).
 */
interface Greeter {
	def String sayHello()

	/* Default methods possible when transpiling to Java8.
	 * Will cause syntax error for versions < 1.8.
	 */
	def String sayHelloWorld() {
		println("Hello, world!");
	}

}

/* For type definitions, same rules apply as in Java.
 * Could also inherit from java class/ implement java interface; e.g: java.io.Serializable.
 */
class AdvancedHelloWorld extends HelloWorld implements Greeter {

	/* Private mutable field. Short form is: */
//	 private var String name; 
	/* Use 'val' to make it final:  */
//	 val String name
	String name

	/*  Public no-args constructor.
	 *  Java-like syntax would yield regular method: */
	// def AdvancedHelloWorld() { }
	new() {
	}

	new(String name) {
		this.name = name
	}

	/* Inferred return type is String because println returns its argument.
	 * 'override' is mandatory. Unlike '@Override' annotation in Java.
	 */
	override sayHello() {
		println('Hello, ' + name + '!')
	}

	/* Inferred return type is String */
	def getName() {
		/* No return statement necessary. Everything is an expression ;-)
		 * Evaluation result of the method's last expression becomes return value.
		 * Return type is inferred from this value.
		 */
		name
	}

	/* Sometimes, it is necessary to specify an explicit return type.
	 * Here, the inferred return type would be String
	 * Method params are implicitly 'final'.
	 */
	def void setName(String newName) {
		name = newName
	}
}

class AdvancedHelloWorldTest {

	@Test
	def testGreeting() {
		/*  Immutable, use var for mutable version
		 *  What is the inferred type here?
		 */
		val greeter = new AdvancedHelloWorld()
		// Property-like use of setter (assignment instead of setter call)
		greeter.name = 'Martin'
		// Property-like use of getter (method-call without prefix 'get') 
		assertEquals('Martin', greeter.name)
		// Empty parentheses are optional!
		assertEquals('Hello, Martin!', greeter.sayHello)
		// Check inherited interface default method (Java8 feature)
		assertEquals("Hello, world!", greeter.sayHelloWorld())
	}
}
