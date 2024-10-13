w := 100
x := 2.0
nome := "João"
f := 1.5


const g = 7
const h = "medeiros"
const i = 3.4

j := 5 + 5 + 5

if (x + 2) > 5 {
y := 20
fmt.Println(y)
}

fmt.Println(x)

sum := func(a, b) {
	return a + b
}

const soma = func(a, b) {
	return a + b
}


numbers := []any{1, 2, 3, 4}
doubled := make([]any, len(numbers))
for i, n := range numbers {
	doubled[i] = n * 2
}

