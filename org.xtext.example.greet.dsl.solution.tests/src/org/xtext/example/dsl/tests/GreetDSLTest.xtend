package org.xtext.example.dsl.tests

import com.google.inject.Inject
import org.eclipse.xtext.junit4.InjectWith
import org.eclipse.xtext.junit4.XtextRunner
import org.eclipse.xtext.junit4.util.ParseHelper
import org.eclipse.xtext.junit4.validation.ValidationTestHelper
import org.junit.Test
import org.junit.runner.RunWith
import org.xtext.example.dsl.GreetDSLInjectorProvider
import org.xtext.example.dsl.greetDSL.GreetDSLPackage
import org.xtext.example.dsl.greetDSL.Model
import org.xtext.example.dsl.validation.GreetDSLValidator

import static org.junit.Assert.*

@InjectWith(GreetDSLInjectorProvider)
@RunWith(XtextRunner)
class GreetDSLTest {

	@Inject
	extension ParseHelper<Model> parser
	@Inject
	extension ValidationTestHelper valiationTestHelper

	@Test
	def testParser() {
		val model = '''
			Persons: Martin, Sören, Gerd.
			Hello Martin, Sören, Gerd!
		'''.parse()
		assertTrue(model.allPersons.size == 3)
		assertTrue(model.greetings.size == 1)
	}

	@Test
	def testValidateAllNamesUpperCase() {
		'''
			Persons: martin, Sören, Gerd.
		'''.parse().assertWarning(GreetDSLPackage::Literals::PERSON, GreetDSLValidator::INVALID_NAME,
			'Name should start with a capital')
	}

}
