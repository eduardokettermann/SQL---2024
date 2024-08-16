
--HCB - Internações/Peso UTI NEO
select 1 from dual
--Quebra por setor 

WITH atendimentos_anteriores AS (  -- Pega atendimentos do mês anterior  -1
    SELECT DISTINCT
        nr_atendimento
    FROM
        atend_paciente_unidade
    WHERE
        ie_passagem_setor = 'N' -- Não pode ser passagem
        AND cd_setor_atendimento = 44 -- UTI Neonatal
        AND to_char(DT_ENTRADA_UNIDADE, 'mm/yyyy') = to_char(ADD_MONTHS(TO_DATE(:dt_competencia, 'mm/yyyy'), -1), 'mm/yyyy')
)

SELECT DISTINCT --Select busca avaliações do peso da criança 
    Obter_Dados_Atendimento(a.nr_atendimento,'CC') cd_convenio_p,
    Obter_Dados_Atendimento(a.nr_atendimento,'NC') ds_convenio
FROM
    atendimento_sinal_vital a,
(SELECT DISTINCT
    nr_atendimento,
    dt_entrada_unidade,
    --dt_saida_unidade,
    CD_SETOR_ATENDIMENTO,
    obter_dias_entre(dt_entrada_unidade, dt_saida_unidade) AS dias_internado,
    obter_dados_pf(obter_cd_pes_fis_atend(nr_atendimento), 'PNC') AS nm_paciente
FROM
    atend_paciente_unidade
WHERE
    ie_passagem_setor = 'N' -- Não pode ser passagem
    AND cd_setor_atendimento = 44 -- UTI Neonatal
    AND to_char(DT_ENTRADA_UNIDADE, 'mm/yyyy') = :dt_competencia -- Competência atual
    AND nr_atendimento NOT IN (SELECT nr_atendimento FROM atendimentos_anteriores)  --aqui onde faz restrição que NÃO pode pega atendimentos
    AND NR_SEQ_INTERNO = (                                                          --do mês passado
                SELECT MIN(Y.NR_SEQ_INTERNO)
                FROM ATEND_PACIENTE_UNIDADE Y
                WHERE Y.IE_PASSAGEM_SETOR = 'N'
                AND Y.CD_SETOR_ATENDIMENTO = 44
                AND Y.NR_ATENDIMENTO = ATEND_PACIENTE_UNIDADE.NR_ATENDIMENTO))c  -- Aqui pega restrição menor atendimento
WHERE C.NR_ATENDIMENTO = A.NR_ATENDIMENTO --JUNÇÃO SUBSELECT ATENDIMENTO COM/AVALIAÇÃO
AND A.IE_SITUACAO = 'A'    
AND A.DT_LIBERACAO IS NOT NULL
AND a.qt_peso IS NOT NULL
--TRAZER SOMENTE A 1º AVALIAÇÃO menor
AND a.NR_SEQUENCIA = (SELECT  MIN(B.NR_SEQUENCIA) 
                          FROM atendimento_sinal_vital b
                          WHERE b.nr_atendimento = a.nr_atendimento
                          AND B.IE_SITUACAO = 'A'    
                          AND B.DT_LIBERACAO IS NOT NULL
                          AND B.qt_peso IS NOT NULL
                          AND to_char(DT_SINAL_VITAL, 'mm/yyyy') = :dt_competencia)
 AND ((:CD_CONVENIO = 0 ) OR (:CD_CONVENIO = Obter_Dados_Atendimento(a.nr_atendimento,'CC') ))
order by 2    


















------------------Banda dados versão antiga
--aonde pegava data de entrada e saida sem contar passagem de setor ocasionando problema
--mais abaixo tem banda ajustada no padrão
-------------------- 

 --VERIFICA OS REGISTROS MÊS ANTERIOR
WITH atendimentos_anteriores AS (
    SELECT DISTINCT
        nr_atendimento
    FROM
        atend_paciente_unidade
    WHERE
        ie_passagem_setor = 'N' -- Não pode ser passagem
        AND cd_setor_atendimento = 44 -- UTI Neonatal
        AND to_char(DT_ENTRADA_UNIDADE, 'mm/yyyy') = to_char(ADD_MONTHS(TO_DATE(:dt_competencia, 'mm/yyyy'), -1), 'mm/yyyy')
)

SELECT DISTINCT
    c.nr_atendimento,
    obter_dados_pf(obter_cd_pes_fis_atend(a.nr_atendimento), 'DN') dt_nascimento,
    obter_dados_pf(obter_cd_pes_fis_atend(a.nr_atendimento), 'PNC') nm_paciente,
    TO_CHAR(a.dt_sinal_vital, 'dd/mm/yyyy hh24:mi:ss') dt_sinal_vital,
    TO_CHAR(c.dt_entrada_unidade, 'dd/mm/yyyy hh24:mi:ss') dt_entrada_unidade,
    a.qt_peso || '' || a.ie_unid_med_peso qtd_peso,
    c.dias_internado
FROM
    atendimento_sinal_vital a,
(SELECT DISTINCT
    nr_atendimento,
    MIN(dt_entrada_unidade) AS dt_entrada_unidade,
    MAX(dt_saida_unidade) AS dt_saida_unidade,
    CD_SETOR_ATENDIMENTO,
    obter_dias_entre(min(dt_entrada_unidade), max(dt_saida_unidade)) AS dias_internado,
    obter_dados_pf(obter_cd_pes_fis_atend(nr_atendimento), 'PNC') AS nm_paciente
FROM
    atend_paciente_unidade
WHERE
    ie_passagem_setor = 'N' -- Não pode ser passagem
    AND cd_setor_atendimento = 44 -- UTI Neonatal
    AND to_char(DT_ENTRADA_UNIDADE, 'mm/yyyy') = :dt_competencia -- Competência atual
    AND nr_atendimento NOT IN (SELECT nr_atendimento FROM atendimentos_anteriores)
    AND NR_SEQ_INTERNO = (
                SELECT MIN(Y.NR_SEQ_INTERNO)
                FROM ATEND_PACIENTE_UNIDADE Y
                WHERE Y.IE_PASSAGEM_SETOR = 'N'
                AND Y.CD_SETOR_ATENDIMENTO = 44
                AND Y.NR_ATENDIMENTO = ATEND_PACIENTE_UNIDADE.NR_ATENDIMENTO)
    GROUP BY
        nr_atendimento, cd_setor_atendimento)c
WHERE C.NR_ATENDIMENTO = A.NR_ATENDIMENTO --JUNÇÃO SUBSELECT ATEND COM AVALIAÇÃO
AND A.IE_SITUACAO = 'A'    
AND A.DT_LIBERACAO IS NOT NULL
AND a.qt_peso IS NOT NULL
--TRAZER SOMENTE A 1º AVALIAÇÃO 
AND a.NR_SEQUENCIA = (SELECT  MIN(B.NR_SEQUENCIA) 
                          FROM atendimento_sinal_vital b
                          WHERE b.nr_atendimento = a.nr_atendimento
                          AND B.IE_SITUACAO = 'A'    
                          AND B.DT_LIBERACAO IS NOT NULL
                          AND B.qt_peso IS NOT NULL
                          AND to_char(DT_SINAL_VITAL, 'mm/yyyy') = :dt_competencia)
and  Obter_Dados_Atendimento(a.nr_atendimento,'CC')   = :cd_convenio_p      

---bandda dados nova conferida data de entrada e sáida e 1º peso






















--Banda dados modificada
-----------------------------------
WITH atendimentos_anteriores AS (
    SELECT DISTINCT
        nr_atendimento
    FROM
        atend_paciente_unidade
    WHERE
        ie_passagem_setor = 'N' -- Não pode ser passagem
        AND cd_setor_atendimento = 44 -- UTI Neonatal
        AND to_char(DT_ENTRADA_UNIDADE, 'mm/yyyy') = to_char(ADD_MONTHS(TO_DATE(:dt_competencia, 'mm/yyyy'), -1), 'mm/yyyy')
),
--Permannecia 
-----------------------------------------
permanencia_correta AS (
    SELECT
        nr_atendimento,
        MIN(dt_entrada_unidade) AS dt_entrada_unidade,
        MAX(dt_saida_unidade) AS dt_saida_unidade,
        cd_setor_atendimento,
        obter_dias_entre(MIN(dt_entrada_unidade), MAX(dt_saida_unidade)) AS dias_internado
    FROM
        atend_paciente_unidade
    WHERE
        ie_passagem_setor = 'N' -- Não pode ser passagem
        AND cd_setor_atendimento = 44 -- UTI Neonatal
        AND nr_atendimento NOT IN (SELECT nr_atendimento FROM atendimentos_anteriores)
    GROUP BY
        nr_atendimento, cd_setor_atendimento
)
--------------------------------
SELECT DISTINCT
    Obter_Dados_Atendimento(a.nr_atendimento,'CC') cd_convenio_p,
    Obter_Dados_Atendimento(a.nr_atendimento,'NC') ds_convenio
FROM
    atendimento_sinal_vital a,
    permanencia_correta c --aqui faz vinculo 
WHERE
    C.NR_ATENDIMENTO = A.NR_ATENDIMENTO --JUNÇÃO SUBSELECT ATEND COM AVALIAÇÃO
    AND A.IE_SITUACAO = 'A'    
    AND A.DT_LIBERACAO IS NOT NULL
    AND a.qt_peso IS NOT NULL
    --TRAZER SOMENTE A 1ª AVALIAÇÃO 
    AND a.NR_SEQUENCIA = (SELECT MIN(B.NR_SEQUENCIA)
                          FROM atendimento_sinal_vital b
                          WHERE b.nr_atendimento = a.nr_atendimento
                          AND B.IE_SITUACAO = 'A'    
                          AND B.DT_LIBERACAO IS NOT NULL
                          AND B.qt_peso IS NOT NULL
                          AND to_char(DT_SINAL_VITAL, 'mm/yyyy') = :dt_competencia)
and  Obter_Dados_Atendimento(a.nr_atendimento,'CC')   = :cd_convenio_p      
