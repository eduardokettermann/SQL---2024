--**************************************************************
--------------SEÇÃO 1: INTRODUÇÃO-------------------------------*
--**************************************************************
(4).O QUE É TABELA?
Conjunto de dados dispostos em número infinito de colunas e linhas.
(5)---------------------------------------------------------
RELACIONAMENTO MUITOS PARA MUITOS CRIA TABELA INTERMEDIARIA
   PEDIDO         DETALPEDIDO
ordemid	1		n	ordemid	
qt_pedido 
    
VENDAS (N)         VENDA_MERCADORIAS      MERCADORIAS(N) 
NUM_VENDA(PK)	  	VEND_MERC(PK)			 CODMERCA(PK)
DTA_VENDA			NUM_VENDA(FK)
QTA_VENDA			CODMERCA(FK)
					
(6).-----------------Primary key e foreign key----------------------
*primary key PK: identifica únicamente
*foreing key FK: relaciona duas tabelas OBS PODE:NULL E DUPLICAR

TB:DEPARTAMENTO		TABELA:FUNCIONARIO			-
   ID NOME			ID	NOME	ID_DEPARTAMENTO	-
PK 1  dept1			1	FUNC1		2 FK		-
   2  dept2			2	FUNC2		2			-
   3  dept3			3	FUNC3		-			-
					4 	FUNC4		1			-
(7)--------------TIPOS DE COMAMDOS-------------------------------------*
DML: MANIPULAÇÃO DE DADOS SELECT,INSERT,UPDATE,DELETE (trabalha com os dados)
DDL: CRIAÇÃO DADOS: LCREATE,ATER,DROP, RENAME, TRUNCATE,COMMENT (COMANDOS ESTRUTURA BANCO)
DCL: CONTROLE DADOS: GRANT,REVOKE(SERVE PARA CONTROLE USUÁRIO)
CONTROLE TRASAÇÃO: COMMIT,ROLLBACK,SAVEPOINT

--************************************************************************
-----SEÇÃO 2:RECUPERANDO DADOS UTILIZANDO -------------------------------*
--************************************************************************

(8)-------------------SELECT STATEMENT------------------------------
--    COMENTAR LINHA
/**/  COMENTA MAIS DE UMA LINHA
--Utilizando o * na clausula SELECT irá retornar todas as colunas da tabela
--Na cláusula from é inserida a tabela de busca
select * from funcionario;
--Também é possivel filtrar o resultado pelo nome da coluna
select nome from funcionario;
--O comando de select não é case-sensitive
select Idade FROM Funcionario;
--A clausula Where irá limitar a busca
select * 
  from funcionario 
 where idade > 20;

(9)----------------UTILIZANDO ALIAS(APELIDAR TABELA)--------------------
-O comando as é opcional, os dois selects abaixo retornam o mesmo resultado
select nome as nome_funcionario from funcionario;
select nome nome_funcionario from funcionario;
--Alias sem aspas: não é case-sensitive, deve ser uma palavra e não deve exceder 30 caracteres
select nome 2 from funcionario; --gera erro
select nome NOME_Funcionario from funcionario; 
select nome nome funcionario from funcionario; --gera erro
--Alias com aspas duplas: é case-sensitive. Pode usar maiúsculas e minúsculas e pode colocar espaço.
select nome "NOME_Funcionario" from funcionario; 
select nome as "nome funcionario" from funcionario; 
--Alias pode também ser usado como apelido de tabela
select f.nome FROM Funcionario f;
select f.nome FROM Funcionario f, funcionario c;
select f.nome FROM Funcionario f, funcionario f; --gera erro, não é possível colocar o mesmo alias em 2 tabelas da clausula from
select nome FROM Funcionario f, funcionario c; --gera erro, sql não saberá diferenciar de qual das tabelas deve retornar a coluna 'nome'
--alias em tabelas da clausula from podem ser utilizadas na clausula where
select nome
  from funcionario f
 where f.nome = 'Ana';
--alias em colunas da clausula select não podem ser utilizadas na clausula where
select nome nom
  from funcionario 
 where nom = 'Ana'; --gera erro

(10)-----------------CONCATENAÇÃO LITERAIS(DUAS COLUNAS 1 SÓ)----------
--O operador de concatenação || concatena duas colunas em uma só. 
--Observe que não é inserido espaço entre os valores e o nome da coluna ficará como 'nome||validade_meses'
select nome||validade_meses from produto;
--Para melhor apresentação da coluna, aconselhável utilizar um alias
select nome||validade_meses validade from produto;
--É possível inserir espaço em branco para separação dos campos na mesma coluna
select nome||' '||validade_meses validade from produto;
--Também podemos inserir uma cadeia de caracteres na concatenação (essas cadeias são chamadas de literais)
select nome||' vence em: '||validade_meses||' meses' validade from produto;
--Literais também podem ser retornados fixos no select 
select 'teste' literal
  from produto; 


(11)-----------------QUOTE OPERATOR(INSERIR APOSTROFO )------------------------
--quote operator nos permite inserir apostrofo em strings literais sem que ocorram erros internos no oracle
select 'It's important' from produto; --gera erro
--Para melhor apresentação da coluna, aconselhável utilizar um alias
select q'[It's important]' quote_operator from produto; 
select q'aIt's importanta' quote_operator from produto; 
select q'2It's important2' quote_operator from produto; 
select q'%It's important%' quote_operator from produto; 
select q"%It's important%" quote_operator from produto; --gera erro


(12)----------------DISTINCT (ELIMINA VALORES DUPLICADOS)----------------
--Em algumas situações podemos obter resultados duplicados em uma busca
select sobrenome from pessoa; 
--Para remover essa duplicidade inserir o comando distinct
select distinct sobrenome from pessoa;
--Podemos utilizar também para mais de uma coluna
select nome, sobrenome from pessoa;
select distinct nome, sobrenome from pessoa;
--Observação importante: O distinct irá ser aplicado para todas as colunas e só pode ser usado no inicio do select 
select nome, distinct sobrenome from pessoa; --gera erro
--Pratique o comando de SELECT com a tabela abaixo
--OBS:. MAIS DE UMA COLUNA ELIMINA NOME IGUAL DA PRIMEIRA COM SEGUNDO COLUNA
----SEMPRE NO INICIO DO SELECT


(13)--------------------EXPRESSÕES ARITMÉTICAS--------------------------------
--Soma (+)
select salario, salario+100 from pessoa; 
--Subtração (-)
select salario, salario-100 from pessoa;
--Multiplicação (*)
select salario, salario*2 from pessoa;
--Divisão
select salario, salario/2 from pessoa; 
--Junção de expressões (Precendencia * e / antes de + e -)
select salario, 100+salario*2 from pessoa; 
--Junção de expressões para mudar precendencia utilize o parenteses
select salario, (100+salario)*2 from pessoa; 


(14)-------------------------VALORES NULOS(NULL)-------------------------
* Null —vazio, nado atribuido, desconhecido;
* Diferente de zero ou espacgo em branco;
* Expresses aritméticas com valor null resultara em um valor null;
--Soma (+)
select salario, salario+100 from pessoa; 
--Subtração (-)
select salario, salario-100 from pessoa;
--Multiplicação (*)
select salario, salario*2 from pessoa;
--Divisão
select salario, salario/2 from pessoa; 


--*********************************************************************************************************
---------------------------------SEÇÃO 3: RESTRINGINDO E ORDENANDO----------------------------------------*
--*********************************************************************************************************
(15)-----------OPERADORES DE COMPARAÇÃO-------
=  --Igual a
>  --Maior que
>= --Maior que ou igual a
<= --Menor que ou igual a
<> --Diferente
--Operador de igualdade (=)

select *
  from pessoa
 where salario = 100;
 ------------------------
select *
  from pessoa
 where nome = 'Maria';
 ---------------------------
select *
  from pessoa
 where nome = 'maria'; --Não retornará valor, pois os operadores de comparação são case-sensitive
----------------------------
--Operador maior que e maior igual que (>, >=)
select *
  from pessoa
 where salario > 100;
 --------------------------
select *
  from pessoa
 where salario >= 100;
 ----------------------------
--Operador menor que e menor igual que (<, <=)
select *
  from pessoa
 where salario < 100;
------------------
select *
  from pessoa
 where salario <= 100;
--Operador diferente de (<>)
select *
  from pessoa
 where salario <> 100;
 --Expressões de comparação também funcionam para strings (Oracle irá compar o código ASCII de cada letra)
select *
  from pessoa
 where nome <= 'Katia'; 
 --'Katia' < 'Kevin' --K é igual --a < e sim  ALINE < EDUARDO
 

(16)------BETWEEN OPERADOR COMPARAÇÃO(RAND DE VALORES)------------------------
-- SEMPRE PRIMEIRO ELEMENTO INSERIDO TEM QUE SER MENOR 
--Para retornar todos os funcionários com idade entre 10 e 22 anos podemos utilizar os operadores >= e <=
--PODE FAZER COM MAIOR IGUL MENOR IGUAL
select nome, idade 
  from funcionario
 where idade >= 10 and idade <=22;
--RETORNA TODOS FUNCIONARIOS ENTRE 10 E 22 ANOS 
--O comando between fará a mesma comparação, porém com uma sintaxe mais simples. 
select nome, idade 
  from funcionario       E
 where idade between 10 and 22;
--O comando between aceita valores em data, numero ou caracter.
select nome, idade 
  from funcionario
 where nome between 'Ana' and 'Felipe';
--É possível negar o range utilizando o comando NOT antes do between.
select nome, idade 
  from funcionario
 where idade NOT between 10 and 22;
--TODOS FUNCIONARIOS MENOS QUE 10 E MAIS 22 VÃO RETORNAR
--Observação: Insira sempre o menor valor e em seguinda o maior valor no range do between.
select nome, idade 
  from funcionario
 where idade between 22 and 10; --Não retornará nada, pois o range está na ordem errada.<--------

(17)------IN(OPERADOR COMPARAÇÃO)-------------------
--Para retornar todos os funcionários que possuem idade igual a 10, 22 e 55 podemos realizar a busca da seguinte forma
select nome, idade 
  from funcionario
 where idade = 10 or idade = 22 or idade = 55;
 --O comando IN fará a mesma comparação, porém com uma sintaxe mais simples. 
select nome, idade 
  from funcionario
 where idade IN (10, 22, 55);
--O comando IN aceita valores em data, numero ou caracter.
select nome, idade 
  from funcionario
 where nome in ('Ana', 'Felipe');
--É possível negar a comparação utilizando o comando NOT.
select nome, idade 
  from funcionario
 where nome NOT IN ('Ana', 'Felipe');
 --É necessário sempre realizar a comparação com variáveis e literais do mesmo tipo
select nome, idade 
  from funcionario
 where idade NOT IN ('Ana', 'Felipe'); --gera erro, pois a coluna idade é do tipo number e as literais do in são caracter
 --No IN não é necessário respeitar uma ordem de valores da lista.
select nome, idade 
  from funcionario
 where idade IN (55, 22, 10);

(18)-----------LIKE(COMPARA UMA CADEIA DE CARACTER(STRING)---------------------
--Podemos comparar uma string da seguinte forma:
select nome, sobrenome 
  from funcionario
 where nome = 'Julio';
 --Mas também podemos comparar com a instrução LIKE. 
select nome, sobrenome 
  from funcionario
 where nome LIKE ('Julio');
--A diferença é que o LIKE possui a possibilidade do uso de dois caracteres especiais (% e _).
--% simboliza que a string deve conter zero ou mais caracteres.
--No exemplo abaixo o sobrenome deve iniciar com a letra S e ter zero ou mais caracteres depois.
select nome, sobrenome 
  from funcionario
 where sobrenome LIKE ('S%');
 --O % também pode ser inserido no início da literal.
--No exemplo abaixo o sobrenome deve finalizar com a letra a, não importando quantas letras tenha antes
select nome, sobrenome 
  from funcionario
 where sobrenome LIKE ('%a');
--O % também pode ser inserido em qualquer posição da palavra.
--No exemplo abaixo o sobrenome deve contar a letra a em qualquer posição.
--Tras todo resultados com letra a
select nome, sobrenome 
  from funcionario
 where sobrenome LIKE ('%a%');
--No exemplo abaixo o sobrenome deve contar a letra a em qualquer posição e após isso a letra l.
select nome, sobrenome 
  from funcionario
 where sobrenome LIKE ('%a%l%');
 --O segundo caracter especial é o _, nesse caso ele especifica a quantidade de letras que deve existir em determinada posição
--Nesse exemplo o sobrenome deve iniciar com Sil e possuir exatamente dois caracteres após a string.
select nome, sobrenome 
  from funcionario
 where sobrenome LIKE ('Sil__');
 --Nesse exemplo o sobrenome deve terminar com va e possuir exatamente três caracteres antes da string.
select nome, sobrenome 
  from funcionario
 where sobrenome LIKE ('___va');
 --Nesse exemplo o sobrenome deve iniciar com S e ter pelo menos um caracter depois disso.
select nome, sobrenome 
  from funcionario
 where sobrenome LIKE ('S_%');
--A clausula escape nos permite interpretar os caracteres especiais como caracter simples
--Nesse exemplo colocamos como escape a \, inserindo essa \ na string o caracter após ela não terá função especial
select nome, sobrenome 
  from funcionario
 where nome LIKE ('An\_') escape--'\'; --Não retorna nada, pois não existe nenhum sobrenome na base com _)--fgd


(19)-------IS NULL(VALOR NULO) NOT NULL(NÃO>NEGAÇÃO) PODE APARECER VALOR NULLO)-------------------
--maneira correta de realizar a busca por nomes com valor null é com IS NULL
select nome, sobrenome 
  from funcionario
 where nome is null;
--Para buscar casos em que a expressão não possui valor null, insira a expressão NOT
select nome, sobrenome 
  from funcionario
 where nome IS NOT NULL;
--Pratique o comando de SELECT com a tabela abaixo


20----------------OPEADORES LÓGICOS-----------------
NOT — negacao;
AND — ambas as expressdes devem ser atendidas;
OR — Apenas uma das expressdes deve ser atendida;
*Precedéncia: NOT, AND e OR;*
--AND - ambas as expressões devem ser atendidas.
select nome, idade 
  from funcionario
 where nome like 'Ana' AND idade = 25; 
 --OR - apenas uma das expressões devem ser atendidas.
select nome, idade 
  from funcionario
 where nome like 'Ana' OR idade = 25; 
 --Precedencia: NOT, AND, OR
select nome, idade 
  from funcionario
 where nome like 'Ana' OR idade = 46 AND id = 3; 
 --Para alterar a precedencia utilize parenteses
select nome, idade 
  from funcionario
 where nome like 'Ana' OR (idade = 46 AND id = 3);
 --Mesmo resultado da busca anterior
 select nome, idade 
  from funcionario
 where (nome like 'Ana' OR idade = 46) AND id = 3; 



21---ORDER BY(ORDENAÇÃO RESULTADO DA CONSULTA)------
* Ordenar o resultado da consulta;
* Default crescente — ASC; (Comando padrão de resultado da busca oracle menor para maior)
* DESC — decrescente;
* Default NULLS LAST — valores null aparecem ao final da lista;
* NULLS FIRST — valores null aparecem no inicio da lista;
* Alias das colunas do select podem ser utilizadas no order by;
* Posicdo numeral da coluna no select também pode ser utilizada;
* E possivel incluir no order by colunas que nao aparecem no select;

--Order by ordernará o resultado da consulta
select nome from funcionario order by nome;  (resultado ordenando pelo nome crescente padrão)


--O default de ordenação é em ordem crescente (ASC)
select nome from funcionario order by nome ASC;   resultado igual de cima utilizando ASC
--mesmo resultado da consulta anterior
 
 --Podemos alterar a ordenação para decrescente utilizando o comando DESC 
select nome from funcionario order by nome DESC;            (resultado ordenando pelo nome decrescente padrão)
 
 --Valores null aparecem ao final da lista na ordem crescente - Default nulls last.
select nome from funcionario order by nome ASC;
 select nome from funcionario order by nome ASC NULLS LAST; 
--mesmo retorno do comando anterior
 
--Podemos utilizá-lo para manter os valores null ao final, mesmo na ordem decrescente
select nome from funcionario order by nome DESC NULLS LAST;
 
--Podemos utilizar o comando NULLS FIRST para mostrar os valores nulos antes dos outros valores
select nome from funcionario order by nome NULLS FIRST;
 
--Podemos mesclar o tipo de ordenação
select nome, idade from funcionario order by nome ASC, idade DESC; ORDENA NOME E IDADE
 
--É possível inserir no order by colunas que não estão no select (não é muito recomendado)
select nome, idade from funcionario order by id;
 
--Utilizando alias no order by
--É possível utilizar os alias das colunas do select no order by
select nome n, idade i from funcionario order by n, i;
 
--Também é possível utilizar os numerais referentes a posição da coluna no select 
select nome, idade from funcionario order by 2;
--ordenando a coluna idade
 
--Assim como é permitido mesclar todas as opções
select nome n, idade from funcionario order by 2, id, n;


(22)------------------FETCH-------------------------

* Limita a quantidade de registros retornados pela consulta;
* FIRST/NEXT — mesma acao;
* ROW/ROWS - limita pelo numero de linhas;
* PERCENT ROWS — limita pela porcentagem de registros;
* ONLY — apenas os registros informados;
* WITH TIES — se existir registros duplicados, pode retornar mais valores do que 0 especificado (quando utilizamos essa clausula é
recomendado o uso do group by na consulta);
* Offset —inicia o retorno dos resultados a partir de uma determinada linha (caso o offset for negativo, considera-se como 0);

--RESULT PEGAR APENAS DUAS LINHAS 
select nome 
from funcionario 
fetch first 2 rows only;
--Mesmo resultado da Anterior por  ordem inserção
select nome 
from funcionario 
fetch next 2 rows only; 

--row/rows - limita pelo número de linhas
select nome 
from funcionario
fetch first 2 row only;
----Mesmo retorno da consulta anterior
select nome 
from funcionario 
fetch first 2 rows only;

--percent rows only - limita pela porcentagem de registros
select nome
from funcionario 
fetch first 20 percent rows only;  only=apenas
-- retorna 20% do resultado do registro  


--Observação: quando utilizamos essa cláusula é recomendado o uso do group by na consulta
select nome
  from funcionario
 order by nome
 fetch first 20 percent rows with ties;
--with ties - se existir registros duplicados, pode retornar mais valores do que o especificado  
-- Retorna 20 por% se tiver  nome duplicados pode retornar
 
select nome
  from funcionario
 fetch first 20 percent rows with ties; --Não retorna o segundo nome 'Ana', mesmo com a clausula with ties devido a ausencia de group by

--OFFSET: inicia o retorno dos resultados a partir de uma determinada linha
select nome
  from funcionario                  ----quantidade de retorno começa a partir 2 nome pega duas
 order by nome
 offset 2 rows fetch first 2 rows only; 
 
--caso o offset for negativo, considera-se como 0 (Define quantidade de registros que eu vou começa minha consulta)
select nome
  from funcionario
 order by nome
 offset -5 rows fetch first 2 rows only;
----quantidade de retorno começa apartir 2 nome 


23------VARIAVEIS DE SUBSTITUIÇÃO----------------

* Variáveis temporarias;
* Pode ser utilizada em qualquer parte do select;
* & - varidvel sera descartada apos a utilizagao;
* && - manterd o valor durante a seção

select * 
from pessoa 
where id = &supplier;  tipo in usuário inseri filtro toda vez que roda

select * 
from pessoa 
where nome = '&&supplier';  tipo in usuário inseri filtro mantem salvo
--executa valor até fim da sessão aqui caracter


24---------DEFINE/UNDEFINE-----------------------
DEFINE SUPPL_NO = 24889; --adiciona variavel fixa na seção
selct *
from supplier
where suppl_no = &suppl_no  --não vai aparecer janelinha pq valor esta definido

UNDEFINE SUPPL_NO = 24889;--remove variável 
SELECT * FROM supplier WHERE SUPPL_NO = & suppl_n;


25-----------SET VERIFY/ SET DEFINE--------------

Verify: mostrar a instrugdo SQL antes da substituicéo e depois da
substituicao;
SET VERIFY ON; ATIVANDO
SET VERIFY OFF; ATIVANDO
SET DEFINE ON; ATIVADO VAI TRAZER CAMPO
SET DEFINE OFF; NÃO VAI TER CAMPO QUANDO UTILIZA &COMERCIAL
-- SERVE PARA VERIFICAR ANTE DE DEPOIS DE DEFINIR


--*********************************************************************
-----------SEÇÃO 4: FUNÇÕES SINGLE ROW--------------------------------*
--*********************************************************************
(26)			O QUE É UMA FUNÇÃO??
* Sub-programa onde inserimos argumentos (input) e nos retorna um
resultado (output);
* Funcões de single-row e multiple-row;
* Argumentos e resultados podem ser do tipo (number, character, date);

(INPUT)arg1 ->função->(OUTPUT)result
(INPUT)arg2

(SINTAXE)
function_name[(arg1,arg2,....)]

Single-row function:(1 RESULTADO POR LINHA)
* Manipula registros;
* Aceita argumentos e retorna apenas um valor;
* Atua em cada linha retornada;
* Retorna um resultado por linha;
* Pode alterar o tipo do input;
* Pode ser aninhada (nested);
* Aceita argumentos que podem ser uma coluna ou expresso;


(27)--FUNÇÕES DE CARACTER CONVERSÃO (PODE UTILIAR SELECT,WHERE,ORDER BY)
* Funções de caracter são separadas em dois tipos: 
conversão (de maitsculas e minusculas) e manipulacao;

(FUNÇÕES DE CONVERSÃO)
* LOWER: converte todos os caracteres para letras minusculas;
* UPPER: converte todos os caracteres para letras maiusculas;
* INITCAP: Primeira letra de cada palavra como maitscula e as outras
letras em minuscula;

--Função UPPER: converte todos os caracteres para letras maiúsculas
select upper(nome) from funcionario;

--Muito utilizada para comparar duas string COVERTE MAIÚSCULA
select nome from funcionario where upper(nome)='ANA';
--PROCURA TODAS ANAS COM LETRAS MAIÚSCULAS

--Função LOWER: converte todos os caracteres para letras minúsculas
select lower(nome) from funcionario;
 
--Função INITCAP: Primeira letra de cada palavra como maiúscula e as outras letras em minúscula
select initcap(nome) from funcionario;
select initcap('ESSE CURSO É SOBRE ORACLE DATABASE SQL') from funcionario;


28---FUNÇÕES MANIPULAÇÃO DE CARACTER---------------------

*CONCAT: concatena duas strings. Equivalente ao operador | |;
sintaxe CONCAT(CHAR1,CHAR2)

select concat(nome, sobrenome) --APENAS DUAS ENTRADAS 
from funcionario;

 select concat(nome||' ', sobrenome) --APENAS DUAS ENTRADAS 
from funcionario;

--------------------
 
 * LENGTH: retorna o numero de caracteres de uma expressao;
sintaxe  LENGTH(CHAR) --Observe que o tamanho de uma coluna nula, também será nulo 

select length(nome), nome from funcionario;

--Pode-se aninhar as funções
select length(concat(nome, sobrenome)), concat(nome, sobrenome)
  from funcionario;  
-----------------------  

* SUBSTR: obter uma string de uma outra string;
sintaxe SUBSTR(CHAR,NUMBER POSITION)
--SUBSTR: obter uma string de uma outra string
--O primeiro argumento é a string em que vamos buscar
--O segundo é a posição em que iniciaremos a busca
select substr(sobrenome, 1), sobrenome from funcionario;
select substr(sobrenome, 3), sobrenome from funcionario;


--O terceiro argumento é a quantidade de caracteres que vamos buscar (campo opcional).
--Se esse campo não for especificado é selecionada a string até o final
select substr(sobrenome, 2, 2), sobrenome from funcionario;
--O segundo argumento pode ser negativo. Nesse caso, a contagem da posição inicial começará do final da string
select substr(sobrenome, -4, 2), sobrenome from funcionario; 


29-- Funçãoe de caracter (INSTR):					    
--********************************************************
* Funcao de manipulacao de caracteres retorna número;

* INSTR: retorna a posição numérica de uma cadeia de caracteres em
uma string;

INSTR | INSTRB | INSTRC | INSTR2 | INSTR4}
(string , substring [, position [, occurrence]])

--INSTR: retorna a posição numérica de uma cadeia de caracteres em uma string
--Primeiro argumento é a string em que vou realizar a busca 
--Segundo argumento é o caracter ou a cadeia de caracteres que vou procurar
select instr(sobrenome, 'ra'), sobrenome
  from funcionario; --O retorno é a posição do primeiro caracter do 'ra'

--Mesmo que a palavra do primeiro argumento possua mais de uma ocorrencia do caracter que estou buscando, o valor retornado é da primeira ocorrencia.
select instr(sobrenome, 'd'), sobrenome
  from funcionario;  -- O retorno é a posição do primeiro caracter do 'd' retorna posição = 3
  
--O terceiro argumento é a posição em que quero iniciar a busca
select instr(sobrenome, 'd', 4), sobrenome
  from funcionario;   --O retorno é a posição do primeiro caracter do 'd' a partir 4 posição 
  
--O valor da posição pode ser negativo, nesse caso a contagem da posição inicial começará do final da string
select instr(sobrenome, 'd', -3), sobrenome --O retorno é a posição 3
  from funcionario;   
  
--O quarto argumento indica a ocorrencia do caracter que queremos procurar a posição.
select instr(sobrenome, 'd', 1, 2), sobrenome
  from funcionario;   
  
--O INSTR é muito utilizado aninhado com a função SUBSTR
select substr(nome||' '||sobrenome, instr(nome||' '||sobrenome, ' ')+1), nome||' '||sobrenome nome_completo
  from funcionario;

Ana Silva -> instr retorna 4

30---FUNÇÕES MANIPULAÇÃO DE CARACTER---------------------

* Funcao de manipulacao de caracteres;

* LPAD: retorna uma expressao, preenchida com um caracter
especificado à esquerda;

* RPAD: retorna uma expressdo, preenchida com um caracter
especificado a direita;

* REPLACE: substitui buscas em express6es por caracteres;

* TRIM: remove characteres do inicio ou fim (ou ambos) de uma string;

--LPAD: retorna uma expressão, preenchida com um caracter especificado à esquerda
--Primeiro argumento é a string principal
--Segundo argumento é o tamanho máximo da minha string
select lpad(sobrenome, 3), sobrenome
  from funcionario;  --retorna  3 strings a esquerda 
  
select lpad(sobrenome, 10), sobrenome
  from funcionario;   --passa valo maior que string prenche espaço em branco tamanho fixo

--Terceiro argumento é um caracter para preenhcer a string à esquerda (opcional, o default é um ' ')
select lpad(sobrenome, 10, '*'), sobrenome
  from funcionario; --retorna 5 * antes

--RPAD: mesma função do LPAD, porém a string é preenchida à direita.
select rpad(sobrenome, 10, '*'), sobrenome
  from funcionario;   
  
--REPLACE: substitui buscas em expressões por caracteres
--O primeiro argumento é a string em que quero procurar
--O segundo argumento é a expressão que quero procurar dentro do primeiro argumento
select replace(sobrenome, 'a'), sobrenome
  from funcionario;  --retorna toda vez que tiver a troca por vazio
  
--O terceiro argumento é o caracter que quero colocar no lugar do segundo argumento (opcional, default é '');
select replace(sobrenome, 'a', 'b'), sobrenome
  from funcionario;    --retorna toda vez que tiver a troca por b
  
select replace(sobrenome, 'a', 'be'), sobrenome
  from funcionario;    
  
--TRIM: remove characteres do inicio ou fim (ou ambos) de uma string
select trim('    oi        bem vindo      ')
  from funcionario;   --retorna remove espaços do meio e do fim 
  
--Alguns argumentos extras podem ser adicionados a função TRIM
--Podemos inserir no primeiro argumento qual o caracter que queremos remover do início e fim da string seguido da palavra FROM
select trim('f' from 'ffffoifffbem vindofffff')
  from funcionario;   --retorna remove todos f inicio e fim  = oifffbem vindo
  
--Podemos inserir a palavra LEADING especificando que o caracter deve ser removido apenas do início da palavra
select trim(leading from '          oi bem vindo           ')
  from funcionario;        --retorna remove espaços  em branco começo mantem fim

select trim(leading '0' from '0000oi bem vindo0000')
  from funcionario;         --retorna remove 0 do inicio  mantem fim
  
--Podemos inserir a palavra TRAILING especificando que o caracter deve ser removido apenas do fim da palavra
select trim(TRAILING from '          oi bem vindo           ')
  from funcionario; 			--mesma coisa do anterior so que ao contrario

select trim(TRAILING '0' from '0000oi bem vindo0000')
  from funcionario; 
  
--Podemos inserir a palavra BOTH especificando que o caracter deve ser removido de ambos os lados (default)
select trim(both from '          oi bem vindo           ')
  from funcionario; 

select trim(both '0' from '0000oi bem vindo0000')
  from funcionario; 
  
--Uma outra forma de utilizar o comando TRIM é com LTRIM e RTRIM
--O LTRIM irá remover o caracter especificado apenas da esquerda
select ltrim('       oi bem vindo         ')
  from funcionario; --por default remove os espaços em branco

select ltrim('0000oi bem vindo0000', '0')
  from funcionario; 
  
--O RTRIM irá remover o caracter especificado apenas da direita
select RTRIM('       oi bem vindo         ')
  from funcionario; --por default remove os espaços em branco

select RTRIM('0000oi bem vindo0000', '0')
  from funcionario; 

31---FUNÇÕES DE DATAS SYSDATE ---------------------------

* Oracle armazena datas em um formato numérico inteiro;

* Formato de data padrao é dd-MON-rr ou dd-MON-yy;

* RR: 01-jan-08 -> 01 de janeiro de 2008
01-jan-59 -> 01 de janeiro de 1959; VAI ATÉ 99-

--tudo vai ser 2000
* YY: 01-jan-08 -> 01 de janeiro de 2008
01-jan-59 -> 01 de janeiro de 2059;

* Adicionar ou subtrair um numero de uma data, resultando em uma
outra data;
* Diminuir duas datas para encontrar o numero de dias entre elas;
* Adicionar horas em uma data dividindo o numero de horas por 24;
* Data + numero = retorna uma data;
* Data — numero = retorna uma data;
* Data — data — retorna um numero de dias;
* Data + numero/24 — retorna uma data;

--SYSDATE: é uma função que retorna a data e horário atual do servidor da base de dados
select sysdate
  from funcionario; 
  
--somar e subtrair um número de uma data retorna uma data
select sysdate+3
  from funcionario; 
  
select sysdate-3
  from funcionario; 
  
--Diminuir duas datas para encontrar o número de dias entre elas  
select sysdate-data_admissao
  from funcionario; 
  
  --retorna número dias está trabalhando

--Adicionar horas em uma data dividindo o número de horas por 24
select sysdate+5/24
  from funcionario; 
  --retorna uma data +5horas = mesmo dia

--Descobrir quantas semanas os funcionários estão trabalhando
select (sysdate-data_admissao)/7
  from funcionario; 
  
  --retorna uma data rotorna quantidade de semana 



32--Aula da funções de data (MONTHS_BETWEEN, ADD_MONTHS, NEXT_DAY, LAST_DAY)

* MONTHS_BETWEEN: recebe duas datas e retorna a quantidade de
meses entre elas (é errado utilizar a divisdo por 30);

* ADD_MONTHS: adicionar meses a uma data;
* NEXT_DAY: retornar a proxima data do dia da semana especificado;
* LAST_DAY: recuperar a Ultima data do més;
--MONTHS_BETWEEN: recebe duas datas e retorna a quantidade de meses entre elas (é errado utilizar a divisão por 30);
select months_between(sysdate, data_nasc)
  from funcionario;
  
  --retorna quantidade de meses entre sysdate e data nasc


--Se a data maior foi inserida primeiro, o retorno será negativo
select months_between(data_nasc, sysdate)
  from funcionario;
  
--ADD_MONTHS: adicionar meses a uma data
select add_months(data_nasc, 1), data_nasc
  from funcionario; --Observe que a data 31-oct-19 quando é acrescentado um mês vira 30-nov-19
  
--observar que retorna 1 mês exatamente
  
--NEXT_DAY: retornar a próxima data do dia da semana especificado
select next_day(data_nasc, 'friday'), data_nasc
  from funcionario;
  
--1 domingo 7sábado

select next_day(data_nasc, 1), data_nasc
  from funcionario;
  

--LAST_DAY: recuperar a última data do mês
select last_day(data_nasc), data_nasc
  from funcionario; 
 


33---Funções de data (ROUND, TRUNC): --------------------
* ROUND: arredondar data para o ano ou més mais proximo;
* TRUNC: trunca a data para o ano e més mais proximo;

--ROUND: arredondar data para o ano ou mês mais próximo
select round(data_nasc, 'month'), data_nasc
  from funcionario; --dia <= 15 arredonda para o mesmo mês
                    --dia >15 arredonda para o dia seguinte
                    

--aqui po ano year
select round(data_nasc, 'year'), data_nasc
  from funcionario; --mês <= 6 arredonda para o mesmo ano
                    --mês >6 arredonda para o ano seguinte
  
***************************************************
--TRUNC: trunca a data para o ano e mês mais próximo
select trunc(data_nasc, 'month'), data_nasc
  from funcionario; 
                    
select trunc(data_nasc, 'year'), data_nasc
  from funcionario; 
 

(34)---------Tabela DUAL: --------------------

* DUAL: utilizada para fazer extragdes onde nao é necessario fazer
extracao de dados em tabelas;

* Possui apenas uma coluna e uma linha chamada “dummy”;

--DUAL: utilizada para fazer extrações onde não é necessário fazer extração de dados em tabelas
--Possui apenas uma coluna e uma linha chamada “dummy”
select *
  from dual;
  
select sysdate
  from dual;   --saber algo que não precisa SER ESTRAIDO
  
select substr('teste dual', instr('teste dual', ' ')+1)
  from dual;
-A PARTIR ESPAÇO QUERO PEGA 1º POSIÇÃO =  DUAL  
 
select round(months_between(sysdate, trunc(sysdate, 'year'))), trunc(sysdate, 'year')
--------------------------------------------------
TÓPICO TERMINADO 
Using Single-Row Functions to
Customize Output
> Manipulating strings with character functions
in SQL SELECT and WHERE clauses
> Performing arithmetic with date data
> Manipulating numbers with the ROUND,
TRUNC and MOD functions
> Manipulating dates with the date function


--*****************************************************************
--SEÇÃO 5: FUNÇÕES DE CONVERSÃO E EXPRESSÃO CONDICIONAIS----------*
--*****************************************************************
(35)
* Realizar a conversdo de um tipo de dado para outro;
* Existe dois tipos de conversdo: implicita e explicita;
* Implicita: realizada automaticamente pelo Oracle;
* Explicita: utilizar funções para realizar a conversdo;

--IMPLICITAS
--Quando incluimos um valor entre aspas é considerado um caracter, porém o Oracle converte para number, pois a coluna id é um number
select *
  from funcionario
 where id = '4';
 
--Oracle também faz a conversão implicita de caracter para data 
select *
  from funcionario
 where data_nasc = '01-jan-08'
  
--Neste caso o Oracle esta fazendo a conversão da data e numero para caracter
select concat(data_nasc, id)
  from funcionario;

(36)-----------------Função TO_CHAR com DATAS transforma CARACTER:----------------------------
* Converter datas para caracter;
* Format model:
* Deve estar em aspas simples;
* E case sensitive;
* Pode incluir qualquer formato de data valido;
* Elemento fm remove espagos em branco ou zeros a esquerda;
* E separado por virgula da data;

select to_char(sysdate, 'dd/mm/rrrr')
  from dual;   --dd/mm/rrrr
  

select to_char(sysdate, 'dd/mm/rrrr hh:mi:ss AM') 
  from dual; --AM e PM tem a mesma função
 
select to_char(sysdate, 'dd/mm/rrrr hh24:mi:ss') 
  from dual;    --mês escrito
  
select to_char(sysdate, 'dd Month rrrr hh24:mi:ss'), to_char(sysdate, 'fmdd Month rrrr hh24:mi:ss')
  from dual; --fm remove 0 e espaçoes
  
select to_char(sysdate, 'dd "of" month rrrr hh24:mi:ss'), to_char(sysdate, 'fmddsp Month rrrr hh24:mi:ss')
     , to_char(sysdate, 'fmddth Month rrrr hh24:mi:ss') , to_char(sysdate, 'fmddspth Month rrrr hh24:mi:ss')
  from dual; 
  
select *
  from funcionario
 where to_char(data_nasc, 'rrrr') = '2019';
 
select *
  from funcionario
 where to_char(data_nasc, 'mm') = '01';
 
select *
  from funcionario
 where to_char(data_nasc, 'fmmm') = '1';
 
 (37)--Função TO_CHAR com datas transforma TO_NUMBER:----------------------------

--Aula de to_char para números

select to_char(1234)
  from dual;
  
select to_char(1234, '9999')
  from dual;
  
select to_char(1234, '0000')
  from dual;
  
select to_char(1234, '9,999')
  from dual;
  
select to_char(1234, '$9,999')
  from dual;
  
select to_char(1234, '$9G999')
  from dual;
  
select to_char(1234.67, '99999.99')
  from dual;
 
select to_char(1234.67, '00000.00')
  from dual;
  
select to_char(1234.67, '9,999.99')
  from dual;
  
select to_char(1234.67, '9G999.99')
  from dual; --Gera erro, se utilizarmos o G, é necessário usar o D para decimal

select to_char(1234.67, '9G999D99')
  from dual;
  
select to_char(1234.67, '9999.9')
  from dual; --Valor é arredondado
  
 
select to_char(1234.67, '99.9')
  from dual; --Valor é aparece como #####

select to_char(-1234.67, '9999.9mi')
  from dual; 
  
select to_char(-1234.67, '9999.9PR')
  from dual; 
  

select to_char(14566, 'FM999,9999,999')
  from dual; 

select length(to_char(2, '9'))
  from dual; --Tamanho do número sempre considera o sinal
  
select length(to_char(-2, '9'))
  from dual;
  
  
(38)--------------Funções TO_NUMBER e TO_DATE: ------- 
+ TO_NUMBER: converter caracter para ntimero;
* TO_DATE: converter caracter para data;
--Aula de to_number e to_date

select to_date('01/10/2019', 'dd/mm/yyyy')
  from dual;
  
select to_date('01-10-2019', 'dd-mm-yyyy')
  from dual;
  
select to_date('01 november 2019', 'dd month yyyy')
  from dual;
  
select to_date('01/          10/2019', 'dd/mm/yyyy')
  from dual; --Oracle remove espaços em branco
  
select to_date('01/ 10/2019', 'fxdd/ mm/yyyy')
  from dual; --fx determina que seja exatamente o mesmo formato
  
select to_char(to_date('01/10/19', 'dd/mm/yy'), 'dd/mm/yyyy')
  from dual;
  
select to_char(to_date('01/10/89', 'dd/mm/yy'), 'dd/mm/yyyy')
  from dual;
  
select to_char(to_date('01/10/19', 'dd/mm/rr'), 'dd/mm/rrrr')
  from dual;
  
select to_char(to_date('01/10/89', 'dd/mm/rr'), 'dd/mm/rrrr')
  from dual;
  
select to_number('4567')
  from dual;
  
select to_number('$4567', '$9999')
  from dual;
  
select to_number('$2000.00', '$9999.99')
  from dual;
(39)--------Funções gerais (NVL, NVL2, NULLIF, COALESCE):------------------
* NVL: Caso o primeiro argumento tenha valor null, retornar o segundo
valor, sendo retorna o primeiro. Ambos os argumentos devem ser do
mesmo tipo;

* NVL2: Caso o primeiro argumento tenha valor null, retorna o terceiro
valor, sendo retorna o segundo. O segundo e terceiro argumento
devem ser do mesmo tipo;

* NULLIF: Se os dois argumentos forem iguais, a fun¢gdo retorna NULL,
senao retorna 0 primeiro argumento. Nao é possivel passar a literal
NULL no primeiro argumento.

* COALESCE: retorna o primeiro valor nao nulo da lista. E necessario
informar pelo menos dois argumentos; *

--Aula de NVL, NVL2, NULLIF e COALESCE

select nome, nvl(apelido, 'Não possui apelido')
  from funcionario;
  
  --retorna apelido nulo 'não possui apelido' argumento do mesmo tipo
  
select nome, nvl(id, 'Não possui id')
  from funcionario; --Erro, pois os argumentos não são do mesmo tipo
  
select nome, nvl(to_char(id), 'Não possui id')
  from funcionario;  
  
select nome, nvl2(apelido, 'Possui apelido', 'Não possui apelido')
  from funcionario;
  
  --retorna quer vc decisir tem que ser mesmo tipo
  
  
select nome, nvl2(id, id, 'Não possui id')
  from funcionario; --Erro, pois o segundo e terceiro argumento não são do mesmo tipo
  
select nome, nvl2(id, to_char(id), 'Não possui id')
  from funcionario;
  
select nome, nullif(nome, 'Ana')
  from funcionario;
  
 --- verifica se nome for ana retorna null  senão retorna nome
  
select nome, nullif(id, 2)
  from funcionario;
  
select nome, nullif(id, 'teste')
  from funcionario; --Erro, pois os argumentos não são do mesmo tipo
  
select nome, nullif(null, 'teste')
  from funcionario; --Erro, pois não é possivel passar a literal null no primeiro argumento
  
select nome, coalesce(apelido, nome)
  from funcionario;

--vai retorna primeiro apelino não nulo quem não tem retorna nome quem tem apelido retorna apelido

select nome, coalesce(apelido)
  from funcionario; --Erro, pois é necessário passar pelo menos dois argumentos


(40)-----------------------Função Case ---------------------------------------
--espressões igualdade 
select nome, idade,
       case idade when 16 then 'Menor'   --sempre com parametro quer comparar
                  when 10 then 'Menor'
       else 'Maior'                       --senão retorna maior
       end teste						--nulo cai else
  from funcionario;
  
--Caso algum valor atenda a duas das condições, só irá retornar o valor da primeira.
--espressão depois when quando utiliza espressões  que não são igualdade<>=

select nome, idade, 
       case when idade < 16 then 'Criança'   --pode utilizar espressões 
            when idade < 18 then 'Jovem'
       else 'Adulto'
       end teste
  from funcionario; --Valor null cairá no else
  
--testa duas condições primeira é retorno


(41)------------------Função Decode --------------------

--Condiçoes estáticas ou seja igualdade
select nome, idade,
       decode(idade, 16, 'Menor'
                   , 10, 'Menor'
                   , 'Maior') teste  --RETORNO DEFULL
  from funcionario;
  
select nome, idade,
       decode(nome, 'Karol', 'Karol'           --SE É karol retorna karol
                   , 'Ana', 'Ana') teste
  from funcionario; --default não precisa ser utilizado, nesse caso alguns valores serão null





--*****************************************************************
(42)--Seção(6) Funções de grupo (sum, count, max, min, avg):------*
--*****************************************************************
--CARACTER 
--NUMBER
--DATA

*Mais de uma função de grupo no mesmo select
*DISTINCT REMOVE REGISTROS NÃO DUPLICADOSS
*ALL FAZ FUNÇÃO CONSIDERAR TODOS REGISTROS (DEFAULT)
*TIPOS CHAR/NUMBER/DATE

(43) Funções de grupo (sum, count, max, min,avg)

Max: retorna o valor máximo;
Min: retorna o valor mínimo;
Sum: retorna a soma de todos os valores;
Count: retorna a quantidade de registros;
Avg: retorna a média dos valores;

select idade
  from funcionario
 order by idade;
  
select max(idade), min(idade)
  from funcionario; --Valor nulo descartado RETORNA MAIOR E MENOR IDADE
  
select max(idade), min(idade)
  from funcionario
 where idade > 50; --Se não existir registros, retorna null
 
select sum(idade), sum(distinct idade), sum(all idade)
  from funcionario; --All é default

select count(idade), count(distinct idade)
  from funcionario; --Null foi descartado
 
select avg(idade), avg(distinct idade)
  from funcionario; --Null descartado
 
--Para forçar que as funções considerem o valor null, utilize a função nvl
select count(nvl(idade, 0)), sum(nvl(idade, 0)), max(nvl(idade, 0)), min(nvl(idade, 0)), avg(nvl(idade, 0))
  from funcionario;

--Podemos utilizar data e caracter com as funções count, max e min
select count(nome), max(nome), min(nome)
  from funcionario;




44---Cláusulas group by e having:------------------------*

Group by: separar a consulta em grupos;
Having: Complemento do group by  Adicionar condições ao grupo;

select max(idade), min(idade), dept
  from funcionario; --Erro: pois não encontra a função de grupo  --NÃO TEM CLAUSULA PARA AGRUPA POR DEPARTAMENTO ARGUMENTO SIMPLES
  
select max(idade), min(idade), dept
  from funcionario
 group by dept;  --AGRUPANDO TODOS FUNCIONARIOS POR DEPARTAMENTO
 
select max(idade), min(idade), dept
  from funcionario
 group by dept
 order by min(idade); --Pode-se incluir funções de grupo no order by  --AGRUPO POR DEPARTAMENTO ORDENO MINIMA
 
select max(idade), min(idade), dept, nome
  from funcionario
 group by dept; --Erro: todas as colunas do select que não saõ funções de grupo devem estar no group by

 /*3*/select	sum(idade)soma, 
				dept
 /*1*/ from funcionario
 /*2*/group by soma; --Erro: não é possível usar alias no group by PORQUE ELE É EXECUTADO ANTES SELECT
 
select sum(idade) soma, dept
  from funcionario
 where dept > 1
 group by dept;
 
select sum(idade) soma, dept
  from funcionario
 where sum(idade) > 10 
 group by dept; --Erro: funções de grupo não podem ser incluidas no where condições para funcionario
 
select sum(idade) soma, dept
  from funcionario
 group by dept
having sum(idade) > 10 ; 


select sum(idade) soma, dept
  from funcionario
having sum(idade) > 10 
 group by dept ; 
 
select sum(max(idade))
  from funcionario
 group by dept; --Só é possível aninhar funções de grupo até o segundo nível

--*****************************************************************
--Secao 7: Mostrar registros de multiplas tabelas utilizando join *
--*****************************************************************








-----------------------VIEW--------------------------------------------------------------------
view: não é uma representação logica não é uma forma de armazenamento igual a uma tabela.
forma de mostra os dados de uma maneira diferente.
São baseados em select podemos visualizar e alterar
BaseTable - View
ex:.tabela funcionarios com uma coluna referente salário
nem todo mundo pode ter acesso a essa informação criamos view

*RESTRINGIR DADOS
*COLOCAR SELECT GIGANTE DENTRO VIEW SELECT * FROM 

SIMPLE VIEW UMA TABELA -> NÃO PODE TER FUNÇÃO->NÃO PODE TER GRUPO DADOS->OPERAÇÃO DML PODE
COMPLEX VIEW UMA OU MAIS-> PODE TER UMA FUNÇÃO->PODE TER GROUP BY->NEM SEMPRE 

select*from funcionario
select*from func
---criando view restringindo salário--
create view func
as
select id, nome
  from funcionario;
----inserindo dado direto view------
insert into func values (2,'Ana');
----------excluindo view--------------
drop view func
----view com colunas apelidadas------
create view func
as
select id id_func, nome nome_func
  from funcionario;
--view com colunas apelidadas no creat view
create view func (id_func, nome_func)
as
select id, nome 
from funcionario;
--------------------------------------


------------exemplo de função criada para obter o nome atravez código pessoal------------------
create or replace function      obter_nome_pf(cd_pessoa_fisica_p 	varchar2)         
								return varchar2 is ds_retorno_w		varchar2(200);

begin

if (cd_pessoa_fisica_p is not null) then
	begin
	select  substr(nm_pessoa_fisica,1,200)
	into	ds_retorno_w
	from 	table(search_names_dev(null,cd_pessoa_fisica_p,null,null,null, null));
	end;
end if;

return ds_retorno_w;

end obter_nome_pf;
----------------------------------------------------------------------------------------------------
PADRÃO PARA CRIAÇÃO VIEW
CREATE OR REPLACE FORCE VIEW "TASY"."HCB_CCIH_V" AS
/*ANTIBIÓTICO SIM*/
    SELECT 
    DISTINCT 
    1 nr_seq_apresent,
    a.nr_cirurgia  nr_cirurgia, 
    DECODE(b.ds_antib_sim_aic,'', 'Não', 'X', 'Sim') ds_checkbox_26,
    b.DS_ANTIB_HORA DS_ANTIB_HORA_26, 
    substr( obter_status_cirurgia(a.ie_status_cirurgia), 1, 200) ds_status, 
    DECODE(a.ie_porte,'M','Médio','P','Pequeno','G','Grande','E','Especial','D','Superior','','Não Informado') ds_porte, 
    c.ds_procedimento ds_procedimento, 
    a.nr_atendimento nr_atendimento, 
    a.dt_termino dt_termino, 
    obter_nome_pf(a.cd_pessoa_fisica) nm_paciente, 
    obter_telefone_pf(a.cd_pessoa_fisica, 12) telefone, 
    obter_nome_pf(a.cd_medico_cirurgiao) nm_medico, 
    a.cd_tipo_cirurgia, 
    a.ie_porte, 
    DECODE(b.ANT_S,'', 'Não', 'X', 'Sim') ds_checkbox_29, 
    b.DS_ANT_HORA, 
    obter_especialidade_medico(a.cd_medico_cirurgiao, 'C') cd_especialidade, 
    c.cd_procedimento cd_procedimento,
    a.dt_inicio_real dt_inicio_real

FROM    cirurgia a, 
        hcb_cirurgia_segura_v b, 
        procedimento c
WHERE
   -- a.dt_inicio_real BETWEEN :dt_inicial AND fim_dia(:dt_final)
    c.cd_procedimento = a.cd_procedimento_princ
    AND a.nr_cirurgia = b.nr_cirurgia
    AND a.dt_termino IS NOT NULL
    AND a.ie_status_cirurgia IN (2)
    and c.cd_procedimento in (411010034,411010042,411010026,45080224,45080020,45080194,45080020,45080194,35009012,45080038,45080038,31309208,35084014,35082011,35085010,35028017,31309054,31309054,408040041,408040050,39003124,30724082,30724082,30724058,30724058,408040068,39018121,39016129,408040084,408040092,30719020,408050047,52130045,52130045,408050055, 30726034,30726034,39022145,408050063,408050071,49010140,49010140,403010101,96010099,96010107,96010038,96010093,30602351,96010064,96010058,96010045,96010082,96010061, 96010062,45090289,47010282,45090289,47010282,38059061,413040089,96010121,96010090,96010108)
    and b.ds_antib_sim_aic is not null
    and b.ANT_S is not null