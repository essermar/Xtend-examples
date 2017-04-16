/*******************************************************************************
 * Copyright (c) 2012 itemis AG (http://www.itemis.eu) and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
/* Taken from the official xtend-examples. Modified and extended. */
package _03_expressions

import org.junit.Test
import static org.junit.Assert.*

class BasicExpressions {

	@Test def void literals() {

		// String literals work with single or double quotes
		assertEquals('Hello', "Hello")

		// Number literals (big decimals (bd), float (f) and double (d) in this case)
		assertEquals(42, 20 + 20 + 1 * 2)
		assertEquals(42.00bd, 0.00bd + 42bd)
		assertEquals(42.0f, 42.0d + 0, 0)

		// Boolean literals
		assertEquals(true, !false)

		// Class literals (in Java: BasicExpressions.class)
		assertEquals(this.getClass(), BasicExpressions)

		// Alternatively use 'typeof' (mandatory for array types!) 
		assertEquals(this.getClass(), typeof(BasicExpressions))
	}

	@Test def void collections() {

		/*  There are literals for lists, sets and maps
		 *  and numerous extension methods which make working with them
		 *  convenient (shown in later examples)
		 *  Collection literals produce immutable collections!
		 */
		val list = #['Hello', 'World']
		assertEquals('World', list.get(1))

		val set = #{1, 3, 5}
		assertEquals(3, set.size)

		val map = #{'one' -> 1, 'two' -> 2, 'three' -> 3}
		assertEquals(2, map.get('two'))

		// Will produce a rutime exception
		// map.put('four', 4)
		//
		/*
		 * Collection literals produce immutable collections. 
		 * For mutable ones, there are a number of factory methods available.
		 * Note that the type produced (seen when hovering over the name)
		 * is inferred from the control flow.
		 * If you change the type of elements added, the inferred type
		 * will change accordingly.
		 */
		val mutableList = newArrayList
		// mutableList.add(new Object)
		mutableList.add("Foo")

		val mutableSet = newHashSet
		mutableSet.add("Bar")
		val mutableMap = newHashMap
		mutableMap.put("Fizz", "Buzz")
	}

	/* Control statements similar to Java (if-else, switch, try-catch, ...)
	 * But: (Almost) everything in Xtend is an expression and returns a value.
	 * Exceptions are, for example, assignments and loops.
	 */
	@Test def void controlStructures() {

		/* 'if' looks like in Java.
		 * But it's an expression so it can be used in more flexible ways:
		 */
		if ('text'.length == 4) {
			assertEquals(42, if('foo' != 'BAR'.toLowerCase) 42 else -24)
		} else {
			fail('Never happens!')
		}

		/* In a switch, the first match wins.
		 * Argument that goes into the switch can be computed and bound to a variable.
		 */
		switch (String t : 'text') {
			// uses a predicate 
			case t.length > 8:
				fail('Never happens!') // break!
				// uses equals
			case 'text':
				assertTrue(true) // break!
			default:
				fail('never happens!')
		}

		/* Switch also supports type guards for case expressions.
		 * Tests argument for given guard type.
		 * If argument is of the given type, type-cast is performed and
		 * the test predicate is evaluated.
		 */
		val Object someValue = 'A string?'
		assertEquals('A string? Yes, it is!', switch someValue {
			Number case 4: 'number'
			String: someValue.concat(' Yes, it is!')
		})

		// switch with fall-through
		val num = 3
		// val num = 1
		assertEquals('not a divisor of 4', switch num {
			case 1,
			case 2,
			case 4: 'divisor of 4'
			default: 'not a divisor of 4'
		})
	}

	@Test def void loops() {

		// for-each loop (with range)
		var counter = 1
		for (i : 1 .. 10) {
			assertEquals(counter, i)
			counter = counter + 1
		}

		// traditional for loop
		for (var i = 11; i > 0; i--) {
			assertEquals(counter, i)
			counter -= 1 // compound assignment
		}
		assertEquals(0, counter)

		// while loop
		val iterator = #[1, 2, 3, 4, 5].iterator
		counter = 1
		while (iterator.hasNext) {
			val i = iterator.next
			assertEquals(counter, i)
			counter = counter + 1
		}

		// do-while loop
		counter = 1
		do {
			counter++ 
		} while (counter < 4)
		assertEquals(4, counter)
		
		// All loops have type 'void'
	}
}
