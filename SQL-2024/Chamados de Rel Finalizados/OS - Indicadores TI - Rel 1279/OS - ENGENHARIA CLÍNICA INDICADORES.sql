/*Bom dia,
Conforme conversado previamente com o colega Eduardo, 
identificamos que os indicadores automáticos da Eng. Clínica 
estão sofrendo alterações dos valores conforme calculamos.

O indicador "% Manutenções preventivas equipamentos para manter vidas - Engenharia Clínica" no dia 01/03 está com valor 100% no período de fevereiro e hoje 12/03 está com valor 87,8% referente ao mesmo período de fevereiro.
*/
Segue os indicadores:       1083 1083
3.3.1.771.1 - % Manutenções preventivas equipamentos para manter vidas - Engenharia Clínica --auto
/*Total de OS preventivas encerradas no mês * 100 / Total de OS abertas no mês*/
SELECT CASE
        WHEN TOTAL > 100 THEN 100
        ELSE TOTAL
    END TOTAL
FROM (
        SELECT (
                (
                    select COUNT(x.nr_sequencia) TOTAL
                    from man_ordem_servico x
                    WHERE X.IE_TIPO_ORDEM = 2
                        AND X.NR_GRUPO_TRABALHO = 22
                        AND X.NR_GRUPO_PLANEJ = 14
                        and x.NR_SEQ_ESTAGIO = 41
                        AND X.NR_SEQ_TIPO_ORDEM = 4
                        AND X.DT_FIM_REAL BETWEEN :DT_INICIAL AND FIM_DIA(:DT_FINAL)
                ) / (
                    select COUNT(x.nr_sequencia) TOTAL
                    from man_ordem_servico x
                    WHERE X.IE_TIPO_ORDEM = 2
                        AND X.NR_GRUPO_TRABALHO = 22
                        AND X.NR_GRUPO_PLANEJ = 14
                        and x.NR_SEQ_ESTAGIO not in (92)
                        AND X.NR_SEQ_TIPO_ORDEM = 4
                        AND X.DT_ORDEM_SERVICO BETWEEN :DT_INICIAL AND FIM_DIA(:DT_FINAL)
                )
            ) * 100 TOTAL
        FROM DUAL
    )
/*************ajustado**********************************/
--INDICADOR:3.3.1.771.1
SELECT 
    (ENCERRADAS.TOTAL_ENCERRADAS / ABERTAS.TOTAL_ABERTAS)*100 AS total,
    ENCERRADAS.TOTAL_ENCERRADAS AS ENCERRADAS,
    ABERTAS.TOTAL_ABERTAS AS ABERTAS
FROM
(
    -- Total de ordens encerradas
    SELECT COUNT(x.nr_sequencia) AS TOTAL_ENCERRADAS
    FROM man_ordem_servico x 
    WHERE x.IE_TIPO_ORDEM = 2 
    AND x.NR_GRUPO_TRABALHO = 22 -- ENG.CLÍNICA
    AND x.NR_GRUPO_PLANEJ = 14    -- GRUPO ENGENHA
    AND x.NR_SEQ_ESTAGIO = 41
    AND x.NR_SEQ_TIPO_ORDEM = 4
    AND x.DT_FIM_REAL BETWEEN :DT_INICIAL AND FIM_DIA(:DT_FINAL)
) ENCERRADAS,
(
    -- Total de ordens abertas
    SELECT COUNT(x.nr_sequencia) AS TOTAL_ABERTAS
    FROM man_ordem_servico x 
    WHERE x.IE_TIPO_ORDEM = 2 
    AND x.NR_GRUPO_TRABALHO = 22 
    AND x.NR_GRUPO_PLANEJ = 14
    AND x.NR_SEQ_ESTAGIO NOT IN (92)
    AND x.NR_SEQ_TIPO_ORDEM = 4
    AND x.DT_ORDEM_SERVICO BETWEEN :DT_INICIAL AND FIM_DIA(:DT_FINAL)
) ABERTAS
/**NOVO INDICADOR**/
SELECT CASE
        WHEN TOTAL > 100 THEN 100
        ELSE TOTAL
    END TOTAL
FROM
(SELECT  (ENCERRADAS.TOTAL_ENCERRADAS / ABERTAS.TOTAL_ABERTAS)*100 AS TOTAL
FROM
(
    -- Total de ordens encerradas
    SELECT COUNT(x.nr_sequencia) AS TOTAL_ENCERRADAS
    FROM man_ordem_servico x 
    WHERE x.IE_TIPO_ORDEM = 2 
    AND x.NR_GRUPO_TRABALHO = 22 -- ENG.CLÍNICA
    AND x.NR_GRUPO_PLANEJ = 14    -- GRUPO ENGENHA
    AND x.NR_SEQ_ESTAGIO = 41
    AND x.NR_SEQ_TIPO_ORDEM = 4
    AND x.DT_FIM_REAL BETWEEN :DT_INICIAL AND FIM_DIA(:DT_FINAL)
) ENCERRADAS,
(
    -- Total de ordens abertas
    SELECT COUNT(x.nr_sequencia) AS TOTAL_ABERTAS
    FROM man_ordem_servico x 
    WHERE x.IE_TIPO_ORDEM = 2 
    AND x.NR_GRUPO_TRABALHO = 22 
    AND x.NR_GRUPO_PLANEJ = 14
    AND x.NR_SEQ_ESTAGIO NOT IN (92)
    AND x.NR_SEQ_TIPO_ORDEM = 4
    AND x.DT_ORDEM_SERVICO BETWEEN :DT_INICIAL AND FIM_DIA(:DT_FINAL)
) ABERTAS)




/********************************************************************/
--SQL ANTIGO ORIGEM 
SELECT
((select  COUNT(x.nr_sequencia)TOTAL
from	man_ordem_servico x 
WHERE X.IE_TIPO_ORDEM =  2 
AND X.NR_GRUPO_TRABALHO =  22 
and x.NR_SEQ_ESTAGIO not in (92)
AND X.NR_SEQ_META_PE IS NULL 
AND X.DT_FIM_REAL BETWEEN :DT_INICIAL AND FIM_DIA(:DT_FINAL))*100)/
(SELECT  COUNT(NR_SEQUENCIA)TOTAL
FROM	MAN_EQUIPAMENTO 
WHERE NR_SEQ_CATEGORIA IN (7)
AND IE_SITUACAO = 'A')TOTAL
FROM DUAL
/**************************************************************************************************/





/*INDICADOR 3.3.1.771.2   1082    1082
% Manutenções preventivas equipamentos para salvar vidas - Engenharia Clínica --auto
*/Total de OS preventivas encerradas no mês * 100 / Total de OS abertas no mês
SELECT
CASE
WHEN TOTAL > 100 THEN 100
ELSE TOTAL END TOTAL
FROM
(SELECT
((select  COUNT(x.nr_sequencia)TOTAL
from	man_ordem_servico x 
WHERE X.IE_TIPO_ORDEM =  2 
AND X.NR_GRUPO_TRABALHO =  22 
AND X.NR_GRUPO_PLANEJ = 14
and x.NR_SEQ_ESTAGIO = 41
AND X.NR_SEQ_TIPO_ORDEM = 3
AND X.DT_FIM_REAL BETWEEN :DT_INICIAL AND FIM_DIA(:DT_FINAL))/

(select  COUNT(x.nr_sequencia)TOTAL
from	man_ordem_servico x 
WHERE X.IE_TIPO_ORDEM =  2 
AND X.NR_GRUPO_TRABALHO =  22 
AND X.NR_GRUPO_PLANEJ = 14
and x.NR_SEQ_ESTAGIO not in (92)
AND X.NR_SEQ_TIPO_ORDEM = 3
AND X.DT_ORDEM_SERVICO BETWEEN :DT_INICIAL AND FIM_DIA(:DT_FINAL)))*100 TOTAL
FROM DUAL)

/******************ajustado*********************************************/
/*AJUSTADO BSC NÃO ACEITOU FICO APARECENDO COM 100% EM TODOS
DEVIDO SER PROCEDURE QUE EXECUTA CALCULO
*/
SELECT  CASE
        WHEN ROUND((ENCERRADAS*100)/ABERTAS,2) > 100 THEN 100
        ELSE ROUND((ENCERRADAS*100)/ABERTAS,2) END TOTAL
      
FROM
        (   --ABERTAS
            SELECT COUNT(x.nr_sequencia) AS ABERTAS
            FROM man_ordem_servico x 
            WHERE x.IE_TIPO_ORDEM = 2 
            AND x.NR_GRUPO_TRABALHO = 22 
            AND x.NR_GRUPO_PLANEJ = 14
            AND x.NR_SEQ_ESTAGIO = 41
            AND x.NR_SEQ_TIPO_ORDEM = 3
            AND x.DT_FIM_REAL BETWEEN :DT_INICIAL AND FIM_DIA(:DT_FINAL)
        ),
        (   --ENCERRDAS
            SELECT COUNT(x.nr_sequencia) AS ENCERRADAS
            FROM man_ordem_servico x 
            WHERE x.IE_TIPO_ORDEM = 2 
            AND x.NR_GRUPO_TRABALHO = 22 
            AND x.NR_GRUPO_PLANEJ = 14
            AND x.NR_SEQ_ESTAGIO NOT IN (92)
            AND x.NR_SEQ_TIPO_ORDEM = 3
            AND x.DT_ORDEM_SERVICO BETWEEN :DT_INICIAL AND FIM_DIA(:DT_FINAL)
        )  
/*SQL DO INDICADOR COM SUBSELECT TOP*/
SELECT  CASE
        WHEN TOTAL > 100 THEN 100
        ELSE TOTAL END TOTAL
FROM        
(SELECT  ((ENCERRADAS*100)/ABERTAS) TOTAL  
FROM
        (   --ABERTAS
            SELECT COUNT(x.nr_sequencia) AS ABERTAS
            FROM man_ordem_servico x 
            WHERE x.IE_TIPO_ORDEM = 2 
            AND x.NR_GRUPO_TRABALHO = 22 
            AND x.NR_GRUPO_PLANEJ = 14
            AND x.NR_SEQ_ESTAGIO = 41
            AND x.NR_SEQ_TIPO_ORDEM = 3
            AND x.DT_FIM_REAL BETWEEN :DT_INICIAL AND FIM_DIA(:DT_FINAL)
        ),
        (   --ENCERRDAS
            SELECT COUNT(x.nr_sequencia) AS ENCERRADAS
            FROM man_ordem_servico x 
            WHERE x.IE_TIPO_ORDEM = 2 
            AND x.NR_GRUPO_TRABALHO = 22 
            AND x.NR_GRUPO_PLANEJ = 14
            AND x.NR_SEQ_ESTAGIO NOT IN (92)
            AND x.NR_SEQ_TIPO_ORDEM = 3
            AND x.DT_ORDEM_SERVICO BETWEEN :DT_INICIAL AND FIM_DIA(:DT_FINAL)
        ))







--ORIGEM
SELECT
((select  COUNT(x.nr_sequencia)TOTAL
from	man_ordem_servico x 
WHERE X.IE_TIPO_ORDEM =  2 
AND X.NR_GRUPO_TRABALHO =  22 
and x.NR_SEQ_ESTAGIO not in (92)
AND X.NR_SEQ_META_PE IS NULL 
AND X.DT_FIM_REAL BETWEEN :DT_INICIAL AND FIM_DIA(:DT_FINAL))*100)/
(SELECT  COUNT(NR_SEQUENCIA)TOTAL
FROM	MAN_EQUIPAMENTO 
WHERE NR_SEQ_CATEGORIA IN (6)
AND IE_SITUACAO = 'A')TOTAL
FROM DUAL


--INDICADORES MANUAIS 
% Manutenções corretivas equipamentos para manter vidas - Engenharia Clínica  --manu
--Total de Corretivas realizadas no mês * 100 / Total de equipamentos Manter Vidas
% Manutenções corretivas equipamentos para salvar vidas - Engenharia Clínica  --manu
--Total de Corretivas realizadas no mês * 100 / Total de equipamentos Salvar Vidas


OS - Engenharia Clínica indicadores






































Segue os indicadores:
3.3.1.771.1 - % Manutenções preventivas equipamentos para manter vidas - Engenharia Clínica --auto
CALCULO REALIZADO VIA SQL 1083
/*Total de OS preventivas encerradas no mês * 100 / Total de OS abertas no mês*/

OBS: Quando resultado é acima de 100 o sql retorna 100
MARÇO 
RESULTADO = 134.14 = 100  
ENCERRADAS = 55  
ABERTAS = 41

FEVEREIRO
RESULTADO = 78,260869
ENCERRADAS = 36
ABERTAS = 46

JANEIRO
RESULTADO = 94,59
ENCERRADAS = 35
ABERTAS = 37

/*INDICADOR 3.3.1.771.2 
% Manutenções preventivas equipamentos para salvar vidas - Engenharia Clínica --auto
*/Total de OS preventivas encerradas no mês * 100 / Total de OS abertas no mês


        
OBS: Quando resultado é acima de 100 o sql retorna 100
MARÇO 
RESULTADO = 100 
ENCERRADAS = 149 
ABERTAS = 149

FEVEREIRO
RESULTADO = 96.97
ENCERRADAS = 160
ABERTAS = 146

JANEIRO
RESULTADO = 98.82
ENCERRADAS = 167
ABERTAS = 169
        
        