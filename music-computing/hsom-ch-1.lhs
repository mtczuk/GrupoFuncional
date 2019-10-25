Aqui importamos o módulo da Euterpea, necessário para manipular música de maneira algébrica, para
mais informações acesse http://euterpea.com/

>import Euterpea

Os tipos utilizados nesse código são respectivamente:
PitchClass, Octave, hn, wn, qn, en(eight note), sn(sixteenth note) 

E as funções utilizadas são:
(:+:) | (:=:) | rest
trans | note
note :: Dur -> Pitch -> Music Pitch
rest :: Dur -> Music Pitch
:+: :: Music Pitch -> Music Pitch -> Music Pitch
:=: :: Music Pitch -> Music Pitch -> Music Pitch
trans :: Int -> Pitch -> Pitch

A seguir definimos os valores utilizados, respectivamente uma tupla do tom analizado seguido de
sua altura com relação a região da oitava. Eb, F, G na oitava 4(meio do piano) respectivamente.

>p1 = (Ef, 4)
>p2 = (F, 4)
>p3 = (G, 4)

Aqui definimos que uma melodia é a junção de uma sequência de notas, que é uma função que recebe
tempo e um tom. A função, o operador binário :=:, faz com que a nota seja tocada de maneira
concorrente, enquanto :+: faz com que a nota seja tocada de maneira sequencial. A função trans 
recebe um inteiro no valor de semitons e um tom e executa a operação de transposição que é o 
resultado de uma modificação de uma nota, que é dada pelo segundo argumento.

>mel = (note qn p1 :=: note qn (trans (-3) p1)) :+:
>      (note qn p2 :=: note qn (trans (-3) p2)) :+:
>      (note qn p3 :=: note qn (trans (-3) p3))

A seguir temos a harmonização da nota, uma função com parâmetros de duração e tom, resulta num
contraponto de duas notas, uma nota raiz e uma três semitons abaixo!

>hNote :: Dur -> Pitch -> Music Pitch
>hNote d p = note d p :=: note d(trans (-3) p)

Aqui a melodia reescrita com a função harmonizadora anteriormente descrita e a versão com 
definições locais reescritas.

>mel1 :: Music Pitch
>mel1 = hNote qn p1 :+: hNote qn p2 :+: hNote qn p3

>mel2 :: Music Pitch
>mel2 = let hNote' d p = note d p :=: note d(trans (-3) p)
>       in hNote' qn p1 :+: hNote' qn p2 :+: hNote' qn p3


Podemos usar também uma lógica de listas! O que torna o código ainda mais reutilizado, compare
esta versão com a hard-coded de mel. Se tivéssemos que escrever as outras melodias usando a mesma
lógica, iríamos fazer sempre 3 linhas a mais, agora basta-nos fazer uma linha! Obviamente que
para apenas uma melodia, isso não surte efeito. Eis a escolha da versão hard-coded ou a versão 
reutilizável dependente da própria arquitetura do projeto.
O gerador de lista recebe uma duração, uma lista de tons e retorna um tipo música.

>hList :: Dur -> [Pitch] -> Music Pitch
>hList d [] = rest 0
>hList d (p:ps) = hNote d p :+: hList d ps

A mesma melodia novamente programada

>mel3 = hList qn [p1, p2, p3]

Para tocar todos os exemplos deste código, basta digitar 'play' seguido da melodia do tipo música
previamente selecionado. Ex:
play melody
Toca a função melody!

=================================================================================================

Exercícios do livro:
Alterar a função de nota, de geradora de listas para recever uma lista de tons e transposição.
Com um teste sobre bourré de bach.

>thNote :: Dur -> Pitch -> Int -> Music Pitch
>thNote d p t = note d p :=: note d (trans t p)

>thList :: Dur -> [Pitch] -> [Int] -> Music Pitch
>thList d [] [] = rest 0
>thList d (p:ps) (t:ts) = thNote d p t :+: thList d ps ts


>pBach = [(G, 3), (Fs, 3), (B, 3)]
>tBach = [9, 12, 8]
>mel4 = thList qn pBach tBach
