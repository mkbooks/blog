package main

import (
	"C"
	"fmt"
)

//export GoFunction
func GoFunction() {
	fmt.Printf("GoFunction")
}

func main() {}
