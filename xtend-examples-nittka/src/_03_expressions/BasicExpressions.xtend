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

		// string literals work with single or double quotes
		assertEquals('Hello', "Hello")

		// number literals (big decimals (bd), float (f) and double (d) in this case)
		assertEquals(42, 20 + 20 + 1 * 2)
		assertEquals(42.00bd, 0.00bd + 42bd)
		assertEquals(42.0f, 42.0d + 0, 0)

		// boolean literals
		assertEquals(true, !false)

		// class literals (in Java: BasicExpressions.class)
		assertEquals(this.getClass(), BasicExpressions)

		// alternatively use 'typeof' (mandatory for array types!) 
		assertEquals(this.getClass(), typeof(BasicExpressions))
	}

	@Test def void collections() {

		// There are literals for lists, sets and maps
		// and numerous extension methods which make working with them
		// convenient (shown in later examples)
		val list = #['Hello', 'World']
		assertEquals('World', list.get(1))

		val set = #{1, 3, 5}
		assertEquals(3, set.size)

		val map = #{'one' -> 1, 'two' -> 2, 'three' -> 3}
		assertEquals(2, map.get('two'))

		// Will produce a rutime exception
		// map.put('four', 4)
		/*
		* Collection literals produce immutable collections. 
		* There are also factory methods to produce mutable ones
		* Note that their type (seen when hovering over the name)
		* is inferred from the control flow
		* 
		* Change the type of elements added and watch the inferred type
		* change as well. */
		val mutableList = newArrayList
		// mutableList.add(new Object)
		mutableList.add("Foo")

		val mutableSet = newHashSet
		mutableSet.add("Bar")
		val mutableMap = newHashMap
		mutableMap.put("Fizz", "Buzz")
	}

	// (almost) everything is an expression (exception for example: assignments)
	@Test def void controlStructures() {

		// 'if' looks like in Java
		// but it's an expression so it can be used in more flexible ways:
		if ('text'.length == 4) {
			assertEquals(42, if('foo' != 'BAR'.toLowerCase) 42 else -24)
		} else {
			fail('Never happens!')
		}

		// in a switch the first match wins
		// values in main switch expression can be computed
		switch (String t : 'text') {
			// use predicates
			case t.length > 8:
				fail('Never happens!')
			// use equals
			case 'text':
				assertTrue(true)
			default:
				fail('never happens!')
		}

		// switch also supports type guards, which provide a safe 
		// and convenient alternative to Java's 'instanceof'-cascades.
		val Object someValue = 'a string typed to Object'
		assertEquals('string',
			switch someValue {
				Number case 4: 'number'
				String: 'string'
			})

		//there also is an explicit fallthrough syntax
		val num = 3
		assertEquals('not a divisor of 4',
			switch num {
				case 1,
				case 2,
				case 4: 'divisor of 4'
				default: 'not a divisor of 4'
			})
	}

	@Test def void loops() {

		// for loop
		var counter = 1
		for (i : 1 .. 10) {
			assertEquals(counter, i)
			counter = counter + 1
		}

		//traditional for loop
		for (var i = 11; i > 0; i--) {
			assertEquals(counter, i)
			counter -= 1 //compound assignment
		}

		// while loop
		val iterator = #[1, 2, 3, 4, 5].iterator
		counter = 1
		while (iterator.hasNext) {
			val i = iterator.next
			assertEquals(counter, i)
			counter = counter + 1
		}

		// do-while 
		counter = 1
		do {
			counter++
		} while (counter < 4)
		assertEquals(4, counter)
	}
}
