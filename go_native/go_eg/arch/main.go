package main

import "fmt"

var archs = []string{"arm64", "arm", "amd64", "386", "riscv64"}

func main() {
	for _, arch := range archs {
		fmt.Println(arch)
	}
}
