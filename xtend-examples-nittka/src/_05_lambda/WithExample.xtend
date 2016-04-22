package _05_lambda

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.junit.Test

import static org.junit.Assert.*

class Person {
	@Accessors
	String firstName
	@Accessors
	String lastName
	@Accessors
	Person spouse
	@Accessors
	List<Person> children
}

/* 
 * With operator offers a convenient way to create object trees.
 * Often used in M2M transformations.
 */
class WithExample {

	@Test
	def void withExample() {
		val Person person = new Person => [
			val me = it
			lastName = "Smith"
			firstName = "Peter"
			spouse = new Person => [
				lastName = "Brown"
				firstName = "Mary"
				spouse = me
			]
			children = newArrayList(
				new Person => [
					lastName = "Smith"
					firstName = "John"
				],
				new Person => [
					lastName = "Smith"
					firstName = "Clair"
				]
			)
			spouse.children = children
		]

		assertEquals("Smith", person.lastName)
		assertEquals("Peter", person.firstName)
		assertEquals("Mary", person.spouse.firstName)
		assertSame(person, person.spouse.spouse)
		assertEquals(2, person.spouse.children.size)
		assertEquals("Clair", person.children.filter[firstName.contains("a")].head.firstName)
	}
}
