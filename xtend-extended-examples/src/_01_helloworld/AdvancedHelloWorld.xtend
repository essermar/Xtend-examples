package _01_helloworld

// imports work as in Java
import org.junit.Test
import static org.junit.Assert.*

// access modifiers implicitly 'public'. 
// default methods possible when transpiling to Java8
interface Greeter {
	def String sayHello()
}

// could also inherit from java class/ implement java interface
class AdvancedHelloWorld extends HelloWorld implements Greeter {

	// private field (use val to make it final)
	// Short form for: 
	// private var String name
	String name

	// public no-args constructor
	new() {
	}

	// public constructor
	new(String name) {
		this.name = name
	}

	// inferred return type is String, because println returns arg
	override sayHello() {
		println('Hello, ' + name + '!')
	}

	// inferred return type is String
	def getName() {

		// no return statement necessary
		// evaluation result of the methods last expression becomes return value
		name
	}

	// inferred return type would be String
	def void setName(String newName) {
		name = newName
	}
	
}

class AdvancedHelloWorldTest {

	@Test
	def testGreeting() {

		// immutable, use var for mutable version
		// inferred Type is AdvancedHelloWorld, not Greeter
		val greeter = new AdvancedHelloWorld()

		// property-like use of setter (method-call without prefix 'set')
		greeter.name = 'Martin'
		// property-like use of getter (method-call without prefix 'get') 
		assertEquals('Martin', greeter.name)
		// empty parentheses are optional
		assertEquals('Hello, Martin!', greeter.sayHello)
	}
}
