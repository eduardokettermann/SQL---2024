select * from 	table


select * from 	table(search_names_dev(null,32007,null,null,null, null));
TO_CHAR(123456.78, '999,999.99')



SELECT 0 cd, 
    'TODOS' ds
FROM dual
UNION ALL
SELECT  cd, 
        ds 
FROM
    (
    SELECT cd_convenio cd, 
            ds_convenio ds 
    FROM convenio 
    WHERE ie_situacao = 'A'
    ORDER BY ds_convenio
    )


/*relatório dq alice a questão esta relacionada ao diagnostico assim não esta puxando todas escalas
realizadas para realizar o processo PEP>escalas e indices*/
01/04/2024 À 01/04/2024


45	Unidade 300	12420	2033004
39	UTI Adulto 1	12422	2033039
98	UTI Adulto 2	12424	2032922
98	UTI Adulto 2	12425	2032944

    /*SETOR*/
SELECT	
    DISTINCT b.CD_SETOR_ATENDIMENTO CD_SETOR_ATENDIMENTO1,
    b.DS_SETOR_ATENDIMENTO,
    a.NR_SEQUENCIA,
    a.nr_atendimento
FROM	escala_nrs a, ATENDIMENTO_PACIENTE_v b,DIAGNOSTICO_DOENCA  c
WHERE	
a.NR_ATENDIMENTO = b.NR_ATENDIMENTO
--and c.NR_ATENDIMENTO = a.NR_ATENDIMENTO
and b.NR_ATENDIMENTO = b.NR_ATENDIMENTO
and a.DT_LIBERACAO BETWEEN :DT_INICIAL and fim_dia(:DT_FINAL) 
and b.cd_convenio = 4
AND a.NR_SEQUENCIA = (select max(nr_sequencia)
                     from escala_nrs y 
                     where y.nr_atendimento = a.nr_atendimento)
and c.DT_DIAGNOSTICO =  (select max(DT_DIAGNOSTICO)
                        from DIAGNOSTICO_DOENCA  y
                        where y.NR_ATENDIMENTO = c.NR_ATENDIMENTO
                        and y.IE_SITUACAO = 'A')

order by 2

select * FROM	escala_nrs 

select  * from  ATENDIMENTO_PACIENTE_v a where a.cd_convenio = 4 and a.nr_atendimento = 2032944

select  * from ESCALA_NRS

select cd_convenio cd, ds_convenio ds
from convenio
where ie_situacao = 'A'
order by 2


SELECT b.nome,a.*
from rhcontratosfolha a, RHPESSOAS b
where a.pessoa =  b.pessoa
and a.DATAFOLHA >= '01/01/2024' and a.DATAFOLHA <= '30/01/2024'


Relatório das apacs 
apac



apacs X quebra(atendimentos)



tratamento onco
---------------------
CD_PROTOCOLO
NR_SEQ_MEDICACAO

Atendimento APAC	Autorização APAC 	Início Vig	Fim de Vig.	Nome	Código procedimento	Esquema	Ciclo	Dia	Atendimentos do Ciclo	Próxima data agendada	Envio faturamento
									Todos os atendimentos abertos no período do filtro que são classificados como entrega de medicamento VO, quimioterapia injetavel e hormonio injetavel.		Informação da gestão de prontuários
											
						Informações podem ser retiradas do tratamento oncológico, atendimento do ciclo		

/***************************************************************/

/*************banda apac*******************/
SELECT  d.NR_APAC,
        Obter_Dados_Atendimento	(d.NR_ATENDIMENTO,'NP')ds_nome,
        Obter_Dados_Atendimento	(d.NR_ATENDIMENTO,'CP')CD_2,
        d.DT_INICIO_VALIDADE,
        d.DT_FIM_VALIDADE,
        d.NR_ATENDIMENTO atend_2

from sus_apac_unif d
WHERE
    d.dt_fim_validade BETWEEN :dt_inicio AND :dt_final
    AND to_char(d.dt_competencia, 'mm/yyyy') = :dt_competencia
    and Obter_Plano_Conv_Atend(d.NR_ATENDIMENTO) = 02

/*******************banda atendimento →:cd_2*******************/
SELECT  b.NR_ATENDIMENTO,
        b.DT_ENTRADA,
        b.DT_ALTA,
        --Obter_Valor_Dominio(12,b.IE_TIPO_ATENDIMENTO)ds_tipo_atendimento,
        --b.DS_OBS_UNIDADE,
        b.DS_TIPO_ATENDIMENTO,
        b.DS_SETOR_ATENDIMENTO,
        b.NM_UNIDADE_COMPL,
        b.DS_CONVENIO,
        b.DS_CATEGORIA,
        b.DS_PROC_PRINCIPAL

FROM
    atendimento_paciente_v b
WHERE
    b.cd_pessoa_fisica = :cd_2
and b.DT_ENTRADA BETWEEN :dt_inicio AND :dt_final

/**************************protocolo*************************************/

SELECT
    x.cd_protocolo,
    x.nr_seq_medicacao,
    x.nm_usuario,
    x.cd_medico_resp,
    x.dt_protocolo,
    x.nr_ciclos,
    x.qt_dias_intervalo
FROM
    paciente_setor x
where x.cd_pessoa_fisica = :cd_2

/***************************************************************/



/*
MÊS DT_COMPETENCIA =  MÊS DT_INICIO_VALIDADE JANEIRO = JANEIRO → Início

MÊS DT_COMPETENCIA =  MÊS DT_INICIO_VALIDADE JANEIRO = JANEIRO +1 =  feveiro → continuidade


*/


       CASE
        WHEN EXTRACT(MONTH FROM D.DT_COMPETENCIA) = EXTRACT(MONTH FROM D.DT_INICIO_VALIDADE) THEN 'Início'
        WHEN EXTRACT(MONTH FROM D.DT_COMPETENCIA) = EXTRACT(MONTH FROM D.DT_INICIO_VALIDADE) + 1 THEN 'Continuidade'
        WHEN EXTRACT(MONTH FROM D.DT_COMPETENCIA) = EXTRACT(MONTH FROM D.DT_INICIO_VALIDADE) + 2 THEN 'Renovação'
         ELSE 'Outro'
        END AS fase,
        
        CASE
        WHEN EXTRACT(MONTH FROM DT_INICIO_VALIDADE) = EXTRACT(MONTH FROM DT_COMPETENCIA) THEN 'Início'
        WHEN EXTRACT(MONTH FROM ADD_MONTHS(DT_INICIO_VALIDADE, 1)) = EXTRACT(MONTH FROM DT_COMPETENCIA) THEN 'Continuidade'
        WHEN EXTRACT(MONTH FROM ADD_MONTHS(DT_INICIO_VALIDADE, 2)) = EXTRACT(MONTH FROM DT_COMPETENCIA) THEN 'Renovação'
        ELSE 'Outro'
    END AS fase_trimestre




    SELECT * from sus_apac_unif d

select  *
from 
/*********************************************/
select count(fase), fase
from
(SELECT
    NR_APAC,
    DT_INICIO_VALIDADE,
    DT_COMPETENCIA,
    DT_FIM_VALIDADE,
    Obter_Dados_Atendimento(d.NR_ATENDIMENTO,'NP') AS ds_nome,
    CASE
    WHEN EXTRACT(MONTH FROM DT_COMPETENCIA) = EXTRACT(MONTH FROM DT_INICIO_VALIDADE) THEN 'Início'
    WHEN EXTRACT(MONTH FROM DT_COMPETENCIA) = EXTRACT(MONTH FROM DT_INICIO_VALIDADE) + 1 THEN 'Continuidade'
    WHEN EXTRACT(MONTH FROM DT_COMPETENCIA) = EXTRACT(MONTH FROM DT_INICIO_VALIDADE) + 2 THEN 'Renovação'
    ELSE 'Outro'
    END AS fase 
FROM
    sus_apac_unif d
WHERE 
    --EXTRACT(YEAR FROM DT_INICIO_VALIDADE) = 2024
    DT_INICIO_VALIDADE BETWEEN :dt_inicio AND :dt_final
    --d.dt_fim_validade BETWEEN :dt_inicio AND :dt_final  --- esse aqui 181 apenas vencidas
    --AND to_char(d.dt_competencia, 'mm/yyyy') = :dt_competencia
    --AND NR_APAC =  4324200450010
ORDER BY NR_APAC)
GROUP BY fase





SELECT  d.NR_APAC,
        Obter_Dados_Atendimento	(d.NR_ATENDIMENTO,'NP')ds_nome,
        Obter_Dados_Atendimento	(d.NR_ATENDIMENTO,'CP')CD_2,
        d.DT_INICIO_VALIDADE,
        d.DT_FIM_VALIDADE,
        D.DT_COMPETENCIA,
        d.NR_ATENDIMENTO atend_2,
        d.dt_competencia,
        CASE
        WHEN EXTRACT(MONTH FROM D.DT_COMPETENCIA) = EXTRACT(MONTH FROM D.DT_INICIO_VALIDADE) THEN 'Início'
        WHEN EXTRACT(MONTH FROM D.DT_COMPETENCIA) = EXTRACT(MONTH FROM D.DT_INICIO_VALIDADE) + 1 THEN 'Continuidade'
        WHEN EXTRACT(MONTH FROM D.DT_COMPETENCIA) = EXTRACT(MONTH FROM D.DT_INICIO_VALIDADE) + 2 THEN 'Renovação'
        ELSE 'Outro'
        END AS fase  
FROM
    sus_apac_unif d
WHERE
    d.dt_fim_validade BETWEEN :dt_inicio AND :dt_final
--AND NR_APAC =  4324200450010
AND to_char(d.dt_competencia, 'mm/yyyy') = :dt_competencia
order by 1   
    
    
    
    
Março  =  181 apac com vencimento     
    
    
    AND NR_APAC =  4324200450010
    and Obter_Plano_Conv_Atend(d.NR_ATENDIMENTO) = 02









