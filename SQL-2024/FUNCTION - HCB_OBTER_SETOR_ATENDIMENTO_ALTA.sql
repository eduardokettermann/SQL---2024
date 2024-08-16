
/*
FUNÇÃO CRIADA POR EDUARDO 11/04/2024 OBJETIVO FORNCER O SETOR QUE O PACIENTE GANHOU ALTA 
    INPUT →[ATENDIMENTO[NUMBER]]
    OUTPUT→[DS_SETOR_ALTA_W[VARCHAR2}] 
*/
create or replace function hcb_obter_setor_atendimento_alta(
--Entrada
nr_atendimento_p	Number)
--Retorno da função
return varchar2 is ds_setor_alta_w	 varchar2(255);

begin --Inicio Lógica 
select  SUBSTR(obter_nome_setor(a.cd_setor_atendimento),1,100)
--armazena o resultado
into	ds_setor_alta_w
FROM
    atend_paciente_unidade A
WHERE
    A.nr_atendimento = nr_atendimento_p --Entrada
    AND A.ie_passagem_setor = 'N'
    and  SUBSTR(obter_valor_dominio(1493,OBTER_TIPO_UNIDADE_atend(A.NR_ATENDIMENTO,A.nr_seq_interno,A.ie_passagem_setor)),1,50) = 'Alta';

return	ds_setor_alta_w;
end hcb_obter_setor_atendimento_alta;

commit
/*******************************************************/
--LOGICAS PARA SQL 
--porcentagem CALCULADO DE DUAS FORMAS
select (:porcent/100)*:valor as juro from dual
select round((:porcent/:valor)*100,2) AS juro_2 from dual
select (:porcent*:valor)/100 as juro_3 from dual

--MONTANTE CALCULADO DE DUAS FORMAS
select ((:porcent/100)*:valor + :valor) as montante from dual
select ROUND(((:porcent/:valor)*100)+:valor) montante_2 from dual

/****EXEMPPLO DE FUNÇÃO PORCENTAGEM******/
create or replace function obter_porcentagem (
    valor number,
    porcent number
)return number is resultado number;
begin
resultado := ((valor * porcent)/100);
return resultado;
end;
commit
--COMO UTILIZAR
select obter_porcentagem (102.20,10) from dual

/*******************EXEMPPLO DE FUNÇÃO********************/
CREATE OR REPLACE FUNCTION calcular_area_triangulo (
    base NUMBER,
    altura NUMBER
) RETURN NUMBER --  ←E O TIPO DO DADO
AS
BEGIN --INICIO DO CORPO DA FUNÇÃO 
    RETURN base * altura / 2;
END;

select  calcular_area_triangulo (2,3) from dual
/*******************FUNÇÃO CONVERTE MM EM CM **************/
CREATE OR REPLACE FUNCTION convert_mm_em_centimetro(
    dado number
) RETURN number is resultado number;


begin 
resultado := (dado/10);
return resultado;
end;
commit

select convert_mm_em_centimetro(100) from dual

/******************Função calcula média carro**********************************/
CREATE OR REPLACE FUNCTION km_por_litro(
    km number,
    litros number
) RETURN number is resultado number;


begin 
resultado := (km/litros); --qunatos km por litro
return round(resultado,2);
end;
commit