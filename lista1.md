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

## Desafios

Os seguintes problemas exercitam listas, recursão(linear) e expressão de código.

### 1) Carta, cartinha, cartão.
Um engenheiro de software excêntrico resolveu criar uma aplicação ecommerce em Haskell, para isso ele precisa validar um número de cartão de crédito. Como ele te contratou, pois você fez parte do grupo de estudos em programação funcional da uffs, ele mandou as seguintes instruções:

* A primeira função deverá converter uma entrada string em uma lista de digito de inteiros, caso o string seja negativo ou zero, retorne lista vazia;
* A mesma função, porém com os digitos em posição reversa;
* A soma de todos os digitos;
* Uma função que dobre os valores de todos os segundo digitos começando da direita;
* Criar uma função de validação que some todos os digitos e divida por 8. Caso o resto seja 0, o número é válido.

Ao final da execução para o número 4012888888881888 deverá retornar verdadeiro e para 4012888888881881 falso.

### 2) É o jeito engenheiro!
Certa vez o engenheiro Isaque Nilton dos Santos Montanhoso precisou encontrar uma raiz quadrada .Para encontrá-la, checou no algoritmo em que raizQuadrada(x) = y, tal que y * y seja x! Bonito, pena que o argumento depende da sua própria conclusão, e não é nem algoritmo. Isaque então matutou até chegar na seguinte resposta:

* Uma função que calcule a raiz a partir de um chute(ex: 1.0);
* Uma função que teste caso o número seja bom o bastante, retorná-lo como resposta, caso contrário melhore o chute anterior e execute o mesmo código de novo com o novo chute;
* A função de teste eleva o chute ao quadrado, subtrai com o valor presente dentro da raiz e caso o valor absoluto seja menor que uma tolerância, retorne como verdadeiro;
* A função que melhora o chute é dada pela fórmula chuteNovo = media(chuteAnterior + chuteanterior/radicando).

Só tem um porém, Isaque não queria programar e pediu para o esquadrão computacional dele fazer. Considere tolerância como 0,001. Correm boatos que Isaque também quer uma função que faça a raiz cúbica, mas isso apenas se o funcionário conseguiu fazer a função quadrada.

Spoiler: É uma média do chute e de ((radicando/chuteAnterior^2) + (2 * chute))/3!
