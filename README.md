# assembly-montador

## Assembler

O montador(Assembler) é o programa do sistema responsável por traduzir código assembly em linguagem de máquina traduzindo cada instrução do programa para sequencia de bits que codifica a instrução de máquina. Como cada processador tem sua própria linguaegm, montadores são especificos para processadores de cada familia. Nesse montador em especifico vamos nos concenntrar na familia de processador 6800. 

Um montador trabalha de forma que um objeo módulo seja gerado a partir de um código fonte assembly. Para exemplificar o processo podemos fazer o seguinte:

entrada(arquivo texto + código-fonte em assembly) -> saida = arquivo binario contendo código de máquina. 

No exemplo abaixo vamos introduzir um código que é preparado para ser lido por um montador


### Exemplo de código preparado para um assembler com instruções apontando para registradores do processador da familia 6800
```asm

POS DS.W 1

; Busca 0 na sequencia de inteiros

SRCH0 MOVEA.L #DATUM, A0 ;DATUM definido
      MOVE.L  #DATUM , D0
      CLR.W   D1
LOOP CMP.W    (A0) + , D1
     BNE      LOOP
     SUB.L    A0,D0
     MOVE.W   A0, D0
     RTS
     END

```

Cada Linha desse programa pode conter instruções em seus comentários(Representado por ;). As linhas de instrução contém quatro campos. A primeira coluna pode representar o rótulo opcional sendo a função básica do rótulo criar uma identificação para poder referenciar a linha rotulada. 

A segunda coluna contém o campo de operação que representa a instrução que será montada: as instruções podem ser tanto instruções de máquinas como MOVE e RTS ou pseudo-instruções como DS Os sufixos pos instrução representa os tipos de dados e, respectivamente, o tamanho dos operandos. .B(Byte), .W(Word), .L(Long Word). 1,2,4 Bytes, respectvamente. 

O terceiro campo é o campo dos operandos que podem fazer referências a registradores dos processadores A0 a A7

## GAS - GNU Assembler

GNU Assembler, também conhecido como GAS, é um montador de código assembly desenvolvido como parte do projeto GNU, um esforço colaborativo para criar um sistema operacional totalmente livre e de código aberto, conhecido como GNU. O GNU Assembler é uma parte essencial das ferramentas de desenvolvimento de software disponibilizadas pelo projeto GNU.

O GAS é projetado para funcionar em sistemas operacionais compatíveis com UNIX e é capaz de montar código assembly para uma variedade de arquiteturas de processador, incluindo, mas não se limitando a, x86, ARM, MIPS e PowerPC. Ele suporta várias convenções de sintaxe, incluindo a sintaxe AT&T (usada principalmente no UNIX) e a sintaxe Intel (usada principalmente no DOS e Windows).

Abaixo um exemplo de código escrito na sintaxe  AT&T

```asm
.globl _start
.text
_start:
    mov $60, %RAX
    xor %rdi, %rdi
    syscall
```

Ao repassar esse código para o GAS ele transforma o arquivo .s(extensão usada por convenção) em um objeto do tipo .O

## Natureza do Montador

A posição do código assembly para o montador é de poucoa importancia. Na verdade o montador deve ser capaz manipular as representações simbolicas antes mesmo que sejam definidas. Considere o seguinte exemplo de codigo:

```asm
START ADD.L D0,D1
      JMP   NEXT
LOOP ADD.L  #1,D1
NEXT CLR.L  D5
     JMP   LOOP
```

Na linha 2, por exemplo, há uma referencia a um simbolo NEXT, cujo valor ainda não havia sido determinado. A definição só vai acontecer na linha 4. Há duas possibilidade de lidar com referencias futuras. A primeira possibilidade é deixar uma lacuna para onde deveria ser a definição e apenas no fim do programa identificar se essa lacuna vai ser preenchida ou não. Com essa estrategia é possivel fazer uma única leitura no arquivo no fim das contas. 

O outro processo consiste em, basicamente, fazer o processo de montagem em dois passos:

(1)
ler o arquivo objeto -> criar uma tabela de símbolos definada com todas as constantes que foram declaradas no código.

(2)
uma nova leitura sobre o arquivo é feita para gerar o código de máquina -> a tabela é usada para identificar se não foi feita nenhuma alteração. 

## Pseudo-Instruções e definições associadas ao código

As pseudo-instruções estabelecem conexões entre referencias simbolicas e valores a serem efetivamente referenciados. cada montador oferece um conjunto de pseudo-instruções diferenciados que faciltiam essas conexões. A seguir um trecho de pseudo instrução:

```asm
SIZE EQU 100
```
esse trecho associa o valor decimal 100 ao símbolo SIZE que pode ser posteriomente referenciado em outras instruções como em:

```asm
MOVE #SIZE, D0
```

## Constantes e Váriaveis Inicializadas
