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
