# Lista 1

## Capítulos p/ ler até 04/08
- 4 Syntax in Functions
- 5 Recursion

## Exercícios

### 1)

Implementar uma função que recebe um número `n` e retorna `n +
10`. Exemplo em Python:

```
def f(n):
    return n + 10
```

### 2)

Implementar uma função `myMax` que retorna o máximo de 2 números.
Exemplo em Python:

```
def myMax(a, b):
    return a if a > b else b
```

### 3)

Implementar uma função `myMax3` que retorna o máximo de 3
números, usando a função `myMax`. Exemplo em Python:

```
def myMax3(a, b, c):
  return myMax(a, myMax(b, c))
```

### 4)

Implementar uma função que calcula o fatorial. Exemplo em
Python:

```
def myFactorial(n):
    return n * myFactorial(n - 1) if n > 0 else 1
```
