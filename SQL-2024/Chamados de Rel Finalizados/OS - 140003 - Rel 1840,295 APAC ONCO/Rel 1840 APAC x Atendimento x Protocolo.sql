/*  -----(BANDA APAC) -----
RESTRIÇÃO:
→setor
→plano de convênio
→dt_fim_validade

PASSAGEM DE PARÂMETRO
→ cd_2
*/
SELECT
    d.nr_apac,
    obter_dados_atendimento(d.nr_atendimento, 'NP') ds_nome,
    obter_dados_atendimento(d.nr_atendimento, 'CP') cd_2,
    obter_dados_atendimento(d.nr_atendimento, 'PSCD') cd_SETOR,
    d.dt_inicio_validade,
    d.dt_fim_validade,
    d.nr_atendimento                                atend_2
FROM
    sus_apac_unif d
WHERE
    d.dt_fim_validade BETWEEN :dt_inicio AND :dt_final
    AND to_char(d.dt_competencia, 'mm/yyyy') = :dt_competencia
    AND obter_plano_conv_atend(d.nr_atendimento) = 02
    AND obter_dados_atendimento(d.nr_atendimento, 'CP') IN(37)
@sql_where

SELECT * FROM sus_apac_unif d
------------------------------------------------------------------

/*  -----(BANDA ATENDIMENTO) -----
RESTRIÇÃO:
→DT_ENTRADA 
→NR_SEQ_CLASSIFICACAO

PASSAGEM DE PARÂMETRO
→CD_PESSOA FÍSICA

*/
SELECT  b.NR_ATENDIMENTO AS NR_ATENDIMENTO2,
        b.DT_ENTRADA,
        b.DT_ALTA,
        --Obter_Valor_Dominio(12,b.IE_TIPO_ATENDIMENTO)ds_tipo_atendimento,
        --b.DS_OBS_UNIDADE,
        b.DS_TIPO_ATENDIMENTO,
        b.DS_SETOR_ATENDIMENTO,
        b.NM_UNIDADE_COMPL,
        b.DS_CONVENIO,
        b.DS_CATEGORIA,
        b.DS_PROC_PRINCIPAL,
        b.cd_pessoa_fisica cd_3,
 b.NR_SEQ_CLASSIFICACAO

FROM
    atendimento_paciente_v b
WHERE
b.DT_ENTRADA BETWEEN :dt_inicio AND :dt_final
and b.cd_pessoa_fisica = :cd_2 
and b.NR_SEQ_CLASSIFICACAO in (4,5,15)
order by 2 desc

SELECT * FROM  atendimento_paciente_v
----------------------------------------------------------------------

/*--(BANDA PROTOCOLO (ABA QUIMIO) NÃO VAI SER MAIS UTILIZADA */
SELECT
    x.cd_protocolo,
    obter_desc_protocolo(x.cd_protocolo) protocolo,
    obter_desc_protocolo_medic(X.nr_seq_medicacao, X.cd_protocolo) med,
    x.nr_seq_medicacao,
    x.nm_usuario,
    x.cd_medico_resp,
    x.dt_protocolo,
    x.nr_ciclos,
    x.qt_dias_intervalo,
    X.CD_PESSOA_FISICA,
    x.IE_STATUS,
    X.CD_SETOR_ATENDIMENTO
FROM
    paciente_setor x
  where x.cd_pessoa_fisica = :cd_3
AND X.IE_STATUS = 'A'
-----
select * from paciente_setor x



















--------------------1º VERSÃO SQL SAME PRONTUÁRIO-------------------------- 
SELECT 
b.DT_HISTORICO,
b.NR_SEQ_OPERACAO,
substr(obter_desc_same_operacao(b.nr_seq_operacao),1,40)ds_seq_operacao,
CONCAT(obter_nome_pf(B.cd_pessoa_fisica),'→', B.NM_USUARIO) AS ds_nome_pf_usuario,
A.*,
B.*
FROM
(   select *
    from SAME_PRONTUARIO)A,
 --HISTÓRICO
(select * 
from SAME_PRONTUARIO_HIST 
)B
WHERE
A.NR_SEQUENCIA = B.NR_SEQ_SAME --Ligação das duas tabelas
AND NR_ATENDIMENTO = 2046079
ORDER BY B.DT_HISTORICO desc


--------------2º VERSÃO SQL SAME PRONTUÁRIO -----------------------------
SELECT 
    B.DT_HISTORICO,
    B.NR_SEQ_OPERACAO,
    SUBSTR(obter_desc_same_operacao(B.nr_seq_operacao), 1, 40) AS ds_seq_operacao,
    obter_nome_pf(B.cd_pessoa_fisica)||' ==> '||B.NM_USUARIO AS ds_nome_pf_usuario
FROM
    SAME_PRONTUARIO A,
    SAME_PRONTUARIO_HIST B 
WHERE  A.NR_SEQUENCIA = B.NR_SEQ_SAME
AND    A.NR_ATENDIMENTO = 2046079
ORDER BY
    B.DT_HISTORICO DESC
FETCH FIRST ROW ONLY;

---------------3º VERSÃO SQL SAME PRONTUÁRIO COM JOIN ---------------------------
SELECT 
    B.DT_HISTORICO,
    B.NR_SEQ_OPERACAO,
    SUBSTR(obter_desc_same_operacao(B.nr_seq_operacao), 1, 40) AS ds_seq_operacao,
    obter_nome_pf(B.cd_pessoa_fisica)||' ==> '||B.NM_USUARIO AS ds_nome_pf_usuario
FROM
    SAME_PRONTUARIO A
JOIN
    SAME_PRONTUARIO_HIST B ON A.NR_SEQUENCIA = B.NR_SEQ_SAME
WHERE
    A.NR_ATENDIMENTO = NR_ATENDIMENTO
ORDER BY
    B.DT_HISTORICO DESC
FETCH FIRST ROW ONLY;
--------------------------------------------------------------------

--FUNÇÃO CRIADA PARA TRAZER OS VALORES GESTÃO DE PRODUÁRIOS

CREATE OR REPLACE FUNCTION HCB_OBTER_DADOS_DA_GESTAO_PRONTUARIO(
--INPUT DA FUNÇÃO
    NR_ATENDIMENTO_p NUMBER,
    IE_OPCAO_P VARCHAR2
)
--SAÍDA
RETURN VARCHAR2
IS
    DS_SAIDA VARCHAR2(255);
--LÓGICA
BEGIN
    CASE NVL(IE_OPCAO_P,'DT_HISTORICO')
        WHEN 'DT_HISTORICO' THEN
              SELECT B.DT_HISTORICO
              INTO DS_SAIDA
              FROM SAME_PRONTUARIO A,SAME_PRONTUARIO_HIST B 
              WHERE A.NR_SEQUENCIA = B.NR_SEQ_SAME
              AND A.NR_ATENDIMENTO = NR_ATENDIMENTO_P
              AND ROWNUM = 1
              ORDER BY B.DT_HISTORICO DESC;
        WHEN 'NR_SEQ_OPERACAO' THEN
              SELECT B.NR_SEQ_OPERACAO
              INTO DS_SAIDA
              FROM SAME_PRONTUARIO A,SAME_PRONTUARIO_HIST B 
              WHERE A.NR_SEQUENCIA = B.NR_SEQ_SAME
              AND A.NR_ATENDIMENTO = NR_ATENDIMENTO_P
              AND ROWNUM = 1
              ORDER BY B.DT_HISTORICO DESC;
        WHEN 'CD_PESSOA_FISICA' THEN
              SELECT B.cd_pessoa_fisica
              INTO DS_SAIDA
              FROM SAME_PRONTUARIO A,SAME_PRONTUARIO_HIST B 
              WHERE A.NR_SEQUENCIA = B.NR_SEQ_SAME
              AND A.NR_ATENDIMENTO = NR_ATENDIMENTO_P
              AND ROWNUM = 1
              ORDER BY B.DT_HISTORICO DESC;
        WHEN 'NM_USUARIO' THEN
              SELECT B.NM_USUARIO
              INTO DS_SAIDA
              FROM SAME_PRONTUARIO A,SAME_PRONTUARIO_HIST B 
              WHERE A.NR_SEQUENCIA = B.NR_SEQ_SAME
              AND A.NR_ATENDIMENTO = NR_ATENDIMENTO_P
              AND ROWNUM = 1
              ORDER BY B.DT_HISTORICO DESC;
        ELSE
            DS_SAIDA := 'Opção inválida';
    END CASE;   
    RETURN DS_SAIDA;
END HCB_OBTER_DADOS_DA_GESTAO_PRONTUARIO;


----------------------------------VERSÃO CORRETA-------------------------------------------
create or replace FUNCTION HCB_OBTER_DADOS_DA_GESTAO_PRONTUARIO(
--INPUT DA FUNÇÃO
    NR_ATENDIMENTO_p NUMBER,
    IE_OPCAO_P VARCHAR2
)
--SAÍDA
RETURN VARCHAR2
IS
    DS_SAIDA VARCHAR2(255);
--LÓGICA
BEGIN
    CASE NVL(IE_OPCAO_P,'DT_HISTORICO')
        WHEN 'DT_HISTORICO' THEN
              SELECT B.DT_HISTORICO
              INTO DS_SAIDA
              FROM SAME_PRONTUARIO A, SAME_PRONTUARIO_HIST B 
              WHERE A.NR_SEQUENCIA = B.NR_SEQ_SAME
              AND A.NR_ATENDIMENTO = NR_ATENDIMENTO_P
              AND B.DT_HISTORICO = (SELECT MAX(DT_HISTORICO)
                                    FROM SAME_PRONTUARIO_HIST
                                    WHERE NR_SEQ_SAME = A.NR_SEQUENCIA)
              AND ROWNUM = 1;
        WHEN 'NR_SEQ_OPERACAO' THEN
              SELECT B.NR_SEQ_OPERACAO
              INTO DS_SAIDA
              FROM SAME_PRONTUARIO A, SAME_PRONTUARIO_HIST B 
              WHERE A.NR_SEQUENCIA = B.NR_SEQ_SAME
              AND A.NR_ATENDIMENTO = NR_ATENDIMENTO_P
              AND B.DT_HISTORICO = (SELECT MAX(DT_HISTORICO)
                                    FROM SAME_PRONTUARIO_HIST
                                    WHERE NR_SEQ_SAME = A.NR_SEQUENCIA)
              AND ROWNUM = 1;
        WHEN 'CD_PESSOA_FISICA' THEN
              SELECT B.cd_pessoa_fisica
              INTO DS_SAIDA
              FROM SAME_PRONTUARIO A, SAME_PRONTUARIO_HIST B 
              WHERE A.NR_SEQUENCIA = B.NR_SEQ_SAME
              AND A.NR_ATENDIMENTO = NR_ATENDIMENTO_P
              AND B.DT_HISTORICO = (SELECT MAX(DT_HISTORICO)
                                    FROM SAME_PRONTUARIO_HIST
                                    WHERE NR_SEQ_SAME = A.NR_SEQUENCIA)
              AND ROWNUM = 1;
        WHEN 'NM_USUARIO' THEN
              SELECT B.NM_USUARIO
              INTO DS_SAIDA
              FROM SAME_PRONTUARIO A, SAME_PRONTUARIO_HIST B 
              WHERE A.NR_SEQUENCIA = B.NR_SEQ_SAME
              AND A.NR_ATENDIMENTO = NR_ATENDIMENTO_P
              AND B.DT_HISTORICO = (SELECT MAX(DT_HISTORICO)
                                    FROM SAME_PRONTUARIO_HIST
                                    WHERE NR_SEQ_SAME = A.NR_SEQUENCIA)
              AND ROWNUM = 1;
                
        ELSE
            DS_SAIDA := 'Opção inválida';
    END CASE;   
    RETURN DS_SAIDA;
END HCB_OBTER_DADOS_DA_GESTAO_PRONTUARIO;
---------------------------------------------------------------------------------------------------------
--COMO CHAMAR A FUNÇÃO
SELECT
HCB_OBTER_DADOS_DA_GESTAO_PRONTUARIO(2018429,'DT_HISTORICO') dt_hist,
obter_desc_same_operacao(HCB_OBTER_DADOS_DA_GESTAO_PRONTUARIO(2018429,'NR_SEQ_OPERACAO'))operacao,
obter_nome_pf(HCB_OBTER_DADOS_DA_GESTAO_PRONTUARIO(2018429,'CD_PESSOA_FISICA'))solicitante,
HCB_OBTER_DADOS_DA_GESTAO_PRONTUARIO(2018429,'NM_USUARIO') usuario
FROM DUAL
------------------------------------------------------------------
--COM A FUNÇÃO FICO MUITO LENTO A CONSULTA DEVIDO ISSO FOI NECESSARIO 
--INSERIR UMA 3 TABELA NO SQL DA BANDA (ATENDIMENTO)

SELECT 
a.NR_ATENDIMENTO,
a.DT_ENTRADA,
b.nr_ciclo,
b.ds_dia_ciclo, 
b.DT_PREVISTA,

y.DT_HISTORICO,
y.NR_SEQ_OPERACAO,
ds_seq_operacao,
ds_nome_pf_usuario
FROM 
(SELECT  
    b.NR_ATENDIMENTO,
    b.DT_ENTRADA,
    b.DT_ALTA,
    --Obter_Valor_Dominio(12,b.IE_TIPO_ATENDIMENTO)ds_tipo_atendimento,
    --b.DS_OBS_UNIDADE,
    b.DS_TIPO_ATENDIMENTO,
    b.DS_SETOR_ATENDIMENTO,
    b.NM_UNIDADE_COMPL,
    b.DS_CONVENIO,
    b.DS_CATEGORIA,
    b.DS_PROC_PRINCIPAL,
    b.cd_pessoa_fisica cd_3,
    b.NR_SEQ_CLASSIFICACAO
    FROM
    atendimento_paciente_v b
    WHERE b.DT_ENTRADA BETWEEN :dt_inicio AND :dt_final
    and b.NR_SEQ_CLASSIFICACAO in (4,5,15)
    order by 2 desc 
)a,
(SELECT
    b.nr_ciclo, 
    b.ds_dia_ciclo,
    b.DT_PREVISTA,
    b.nr_atendimento,
    Obter_Dados_Atendimento(b.NR_ATENDIMENTO,'CP') CD_PESSOA_FISICA
    FROM paciente_atendimento b
    order by 4,2
)b,
(SELECT 
    K.DT_HISTORICO,
    K.NR_SEQ_OPERACAO,
    SUBSTR(obter_desc_same_operacao(K.nr_seq_operacao), 1, 40) AS ds_seq_operacao,
    obter_nome_pf(K.cd_pessoa_fisica)||' ==> '||K.NM_USUARIO AS ds_nome_pf_usuario,
    j.nr_atendimento
    FROM
    SAME_PRONTUARIO J,
    SAME_PRONTUARIO_HIST K 
    WHERE  J.NR_SEQUENCIA = K.NR_SEQ_SAME
    AND K.DT_HISTORICO = (SELECT MAX(K.DT_HISTORICO)
                                    FROM SAME_PRONTUARIO_HIST K
                                    WHERE K.NR_SEQ_SAME = J.NR_SEQUENCIA) 
)y
where a.nr_atendimento = b.nr_atendimento
and b.cd_pessoa_fisica = :cd_2 
and     y.NR_ATENDIMENTO = a.NR_ATENDIMENTO 



------------------------------------------------------------
------------ATENDIMENTO NOVO FEITO NA SEXTA-----------------
------------------------------------------------------------
SELECT DISTINCT
a.NR_ATENDIMENTO,
a.DT_ENTRADA,
b.ds_dia_ciclo, 
b.DT_PREVISTA,
B.nr_ciclo_do_protocolo,
B.nr_ciclo_do_ciclo,
B.MED,
b.ds_protocolo,
y.DT_HISTORICO,
y.NR_SEQ_OPERACAO,
ds_seq_operacao,
ds_nome_pf_usuario
FROM 
(SELECT  
    b.NR_ATENDIMENTO,
    b.DT_ENTRADA,
    b.DT_ALTA,
    --Obter_Valor_Dominio(12,b.IE_TIPO_ATENDIMENTO)ds_tipo_atendimento,
    --b.DS_OBS_UNIDADE,
    b.DS_TIPO_ATENDIMENTO,
    b.DS_SETOR_ATENDIMENTO,
    b.NM_UNIDADE_COMPL,
    b.DS_CONVENIO,
    b.DS_CATEGORIA,
    b.DS_PROC_PRINCIPAL,
    b.cd_pessoa_fisica cd_3,
    b.NR_SEQ_CLASSIFICACAO
    FROM
    atendimento_paciente_v b
    WHERE b.DT_ENTRADA BETWEEN :dt_inicio AND :dt_final
    and b.NR_SEQ_CLASSIFICACAO in (4,5,15)
    
)a,
--TABELA CICLO/PROTOCOLO
(SELECT
    --x.cd_protocolo,
    obter_desc_protocolo(x.cd_protocolo) ds_protocolo,
    obter_desc_protocolo_medic(X.nr_seq_medicacao, X.cd_protocolo) med,
    --x.nr_seq_medicacao,
    --x.nm_usuario,
    --x.cd_medico_resp,
    --x.dt_protocolo,
    x.nr_ciclos as nr_ciclo_do_protocolo,
    x.qt_dias_intervalo,
    X.CD_PESSOA_FISICA,
    x.IE_STATUS,
    X.CD_SETOR_ATENDIMENTO,
    y.nr_ciclo nr_ciclo_do_ciclo,
    y.ds_dia_ciclo, 
    y.DT_PREVISTA,
    Y.nr_atendimento
FROM
    paciente_setor x,  --protocolo
    paciente_atendimento y -- ciclo
WHERE
    x.NR_SEQ_PACIENTE = y.NR_SEQ_PACIENTE
    AND X.IE_STATUS = 'A' --protocolo ativo

)b,
(SELECT 
    K.DT_HISTORICO,
    K.NR_SEQ_OPERACAO,
    SUBSTR(obter_desc_same_operacao(K.nr_seq_operacao), 1, 40) AS ds_seq_operacao,
    obter_nome_pf(K.cd_pessoa_fisica)||' ==> '||K.NM_USUARIO AS ds_nome_pf_usuario,
    j.nr_atendimento
    FROM
    SAME_PRONTUARIO J,
    SAME_PRONTUARIO_HIST K 
    WHERE  J.NR_SEQUENCIA = K.NR_SEQ_SAME
     AND K.DT_HISTORICO = (SELECT MAX(K.DT_HISTORICO)
                                    FROM SAME_PRONTUARIO_HIST K
                                    WHERE K.NR_SEQ_SAME = J.NR_SEQUENCIA) 
)y
where a.nr_atendimento = b.nr_atendimento
and b.cd_pessoa_fisica = :cd_2 
and     y.NR_ATENDIMENTO = a.NR_ATENDIMENTO
ORDER BY 2,3






-------------------------------------
------------VALIDADO-----------------
-------------------------------------
SELECT
HCB_OBTER_DADOS_DA_GESTAO_PRONTUARIO(2018429,'DT_HISTORICO') dt_hist,
obter_desc_same_operacao(HCB_OBTER_DADOS_DA_GESTAO_PRONTUARIO(2018429,'NR_SEQ_OPERACAO'))operacao,
obter_nome_pf(HCB_OBTER_DADOS_DA_GESTAO_PRONTUARIO(2018429,'CD_PESSOA_FISICA'))solicitante,
HCB_OBTER_DADOS_DA_GESTAO_PRONTUARIO(2018429,'NM_USUARIO') usuario
FROM DUAL
--------------------------------------------------------------