package _06_richstrings

import org.junit.Test

class RichStringExample1 {

	val exampleObjects = newArrayList("foo", 3, true, "bar")

	@Test
	def void richString() {
		println(createRichString)
	}

	def String foo() {
		"null"
	}
	/* 
	 * Template expressions for printing large amounts of structured text.
	 * Great for M2T or simply as a replacement for 'String.format(...)' in Java.
	 * Richstring: Multiline text (including grey space) + template expressions «» (with white space).
	 * Replaces XPand: No easy separation of template code formatting and printout formatting possible.
	 * In Xtend2: All grey sections get printed exactly as they appear in the code starting
	 * from the target documents left border.
	 */
	def createRichString() '''
		First we write a lot of text.
		«IF 3 > 4»
			This will never happen :-P
		«ELSE»
			3<4
		«ENDIF»
		In between we write even more.
		«FOR i : 1 .. 5 BEFORE "Start\n" SEPARATOR "," AFTER "End\n"»
			Let's talk about «i»:
				«i» is «i.divisibleBy(2)»
					«i» is «i.divisibleBy(3)»
				«FOR j : exampleObjects.filter(typeof(String))»
					«j»
				«ENDFOR»
		«ENDFOR»
		And there is a footer.
		And another one.
	'''

	def divisibleBy(int i1, int i2) {
		if (i1 % i2 == 0) '''
						«««this is a rich string comment
				divisible by «i2».
		''' else '''
			not divisible by «i2».
		'''
	}
}
