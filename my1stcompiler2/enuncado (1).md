### Trabalho de Compiladores: Tradução de JavaScript para Go

**2. Escopo de Variáveis e Hoisting**  
Converter as variáveis `var`, `let` e `const` de JavaScript para as correspondentes no Go, levando em conta o escopo de blocos e a ausência de hoisting em Go.

Exemplo:
JavaScript:
```javascript
let x = 10;
if (x > 5) {
    let y = 20;
    console.log(y);
}
console.log(x);
```
Go:
```go
x := 10
if x > 5 {
    y := 20
    fmt.Println(y)
}
fmt.Println(x)
```
**Escopo**:
- Substituir `let` e `const` por declarações locais no Go (`:=`).
- Considerar o escopo de variáveis em blocos e como ele se comporta no Go.
- Explicar a diferença entre o comportamento de hoisting em JavaScript e a definição estrita de variáveis no Go.

---

**3. Funções Anônimas e Arrow Functions**  
Adaptar funções anônimas e arrow functions (`=>`) para funções anônimas e closures em Go.

Exemplo:
JavaScript:
```javascript
let sum = (a, b) => a + b;
```
Go:
```go
sum := func(a, b int) int {
    return a + b
}
```
**Escopo**:
- Converter expressões de arrow functions em JavaScript para funções anônimas em Go.
- Lidar com o contexto de escopo e captura de variáveis em closures.

---

**4. Manipulação de Arrays e Métodos Funcionais**  
Traduzir operações funcionais em arrays, como `map`, `filter` e `reduce`, de JavaScript para a sintaxe equivalente no Go.

Exemplo:
JavaScript:
```javascript
let numbers = [1, 2, 3, 4];
let doubled = numbers.map(n => n * 2);
```
Go:
```go
numbers := []int{1, 2, 3, 4}
doubled := make([]int, len(numbers))
for i, n := range numbers {
    doubled[i] = n * 2
}
```
**Escopo**:
- Substituir métodos funcionais (`map`, `filter`) por laços explícitos em Go.
- Demonstrar como a iteração é feita de forma mais direta no Go.

---
**5. Funções Assíncronas e Promises**  
Converter funções assíncronas javaScript para a sintaxe de goroutines no Go, utilizando funções assíncronas do Go para lidar com operações concorrentes. 

Exemplo:
JavaScript:
```javascript
async function fetchData() {
    let response = await fetch(url);
    let data = await response.json();
    return data;
}
```
Go:
```go
func fetchData(url string) (data map[string]interface{}, err error) {
    resp, err := http.Get(url)
    if err != nil {
        return nil, err
    }
    defer resp.Body.Close()
    err = json.NewDecoder(resp.Body).Decode(&data)
    return data, err
}
```
**Escopo**:
- Transcrever funções que utilizam `async/await` em JavaScript para goroutines no Go.
- Adaptar o tratamento de erros com o padrão `error` de Go.
- Utilizar pacotes padrão de Go, como `net/http` e `encoding/json`, para trabalhar com requisições e respostas.
---

**6. Estruturas de Objetos e JSON**  
Converter objetos JavaScript e sua manipulação em estruturas (`structs`) e marshalling/demarshalling de JSON em Go.

Exemplo:
JavaScript:
```javascript
let person = {
    name: "Alice",
    age: 30
};
let json = JSON.stringify(person);
```
Go:
```go
type Person struct {
    Name string `json:"name"`
    Age  int    `json:"age"`
}
person := Person{Name: "Alice", Age: 30}
json, _ := json.Marshal(person)
```
**Escopo**:
- Converter objetos para structs.
- Trabalhar com codificação e decodificação JSON usando os pacotes nativos de Go.
