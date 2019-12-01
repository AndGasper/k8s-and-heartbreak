package main

import (
	"fmt"
)

type someType struct {
	propertyOne string
	propertyTwo int
}

func main() {
	// Example declaration but no value assignment
	var example someType
	fmt.Println(example) // Output: { 0}

	var integerExample int
	integerExample = 2
	fmt.Println(integerExample) // Output: 2

	// Struct Example
	var exampleTwo someType
	exampleTwo = someType{"abc", 123} // Output: {abc 123}
	fmt.Println(exampleTwo)
	// Fancy Print Example (that's not what the f stands for, I know)
	// %+v - add field names for printing the value
	fmt.Printf("exampleTwo: %+v\n", exampleTwo) // Output: exampleTwo: {propertyOne:abc propertyTwo:123}
	// Short-hand examples
	shorthandInteger := 2
	// %b - base 2
	fmt.Printf("shorthandInteger: %b\n", shorthandInteger) // Output: shorthandInteger: 10; hehe

	// Shorthand struct
	// the type definition is somewhere between implicit and explicit depending on how you think about it
	shorthandStructExample := someType{"I'm property one", 123}
	fmt.Printf("shorthandStructExample: %+v\n", shorthandStructExample) // Output: shorthandStructExample: {propertyOne:I'm property one propertyTwo:123}
}
