/**

São dois subselects com a tabela prescrição e outro com tabela procedimento
Atualmente as bolsas são solicitadas no REP>ABA procedimentos

ATENDIMENTO → prescr_medica

NR_PRESCRICAO → prescr_procedimento
NR_PRESCRICAO → prescr_medica
Atendimento(analitico)
**/
SELECT DISTINCT
    a.NR_ATENDIMENTO  NR_ATENDIMENTO2,
    SUBSTR(obter_nome_pf(a.CD_PESSOA_FISICA), 1, 255) AS nm_paciente,
    SUBSTR(obter_nome_setor(a.cd_setor_atendimento),1,100)as setor,
    a.cd_setor_atendimento,
    a.NR_ATENDIMENTO,
    a.convenio,
    a.ds_convenio

FROM
    (SELECT DISTINCT
        NR_ATENDIMENTO,
        NR_PRESCRICAO,
        CD_MEDICO,
        CD_PESSOA_FISICA,
        CD_SETOR_ATENDIMENTO,
        substr(Obter_Convenio_Atendimento(nr_atendimento),1,50) convenio,
        substr(obter_nome_convenio(Obter_Convenio_Atendimento(obter_atendimento_prescr(nr_prescricao))),1,100) AS ds_convenio
    FROM
        prescr_medica
    WHERE
        DT_PRESCRICAO BETWEEN :dt_inicial AND fim_dia(:dt_final)
        and DT_LIBERACAO IS NOT NULL
    )a
INNER JOIN --INNER SOMENTE O QUE TEM EM INTERSEÇÃO ENTRE AS DUAS TABELAS
    (SELECT
        NR_PRESCRICAO,
        CD_PROCEDIMENTO,
        nr_seq_proc_interno,
        QT_PROCEDIMENTO,
        DT_ATUALIZACAO,
        ie_status_execucao
    FROM
        prescr_procedimento
    WHERE
        
        DT_ATUALIZACAO BETWEEN :dt_inicial AND fim_dia(:dt_final)
    and cd_setor_atendimento = 32 --banc de sangue
    AND IE_SUSPENSO = 'N'
    ) b
ON
    a.NR_PRESCRICAO = b.NR_PRESCRICAO
    and :CD_RELATORIO = 1
@SQL_WHERE
ORDER BY
    a.NR_ATENDIMENTO

/**
INFORMAÇÕES DO PROCEDIMENTO
procedimento(analitico)
**/
SELECT DISTINCT
    b.NR_PRESCRICAO,
    SUBSTR(Obter_Desc_Prescr_Proc(b.CD_PROCEDIMENTO, 1, b.nr_seq_proc_interno), 1, 200) AS ds_procedimento,
    b.QT_PROCEDIMENTO,
    b.DT_ATUALIZACAO,
    SUBSTR(obter_valor_dominio(1226, b.ie_status_execucao), 1, 200) AS status_execucao,
    SUBSTR(obter_ie_origem_proced(obter_atendimento_prescr(b.nr_prescricao)), 1, 200) AS ie_origem_proced,
    substr(obter_nome_convenio(Obter_Convenio_Atendimento(obter_atendimento_prescr(b.nr_prescricao))),1,100) AS convenio_atendimento,
    b.NR_SEQUENCIA,
    A.DT_PRESCRICAO

FROM
    (SELECT DISTINCT
        NR_PRESCRICAO,
        CD_MEDICO,
        CD_PESSOA_FISICA,
        DT_PRESCRICAO,
        NM_USUARIO_ORIGINAL,
        nr_atendimento,
        DT_LIBERACAO,
        substr(Obter_Convenio_Atendimento(nr_atendimento),1,50) convenio,
        obter_setor_prescricao(nr_prescricao,'C')CD_SETOR_ATENDIMENTO

    FROM
        prescr_medica
    WHERE
    DT_LIBERACAO IS NOT NULL
    AND dt_liberacao BETWEEN :dt_inicial AND fim_dia(:dt_final)

    ) a
INNER JOIN
   (SELECT
        NR_PRESCRICAO,
        CD_PROCEDIMENTO,
        nr_seq_proc_interno,
        QT_PROCEDIMENTO,
        DT_ATUALIZACAO,
        ie_status_execucao,
        NR_SEQUENCIA
    FROM
        prescr_procedimento
    WHERE   
    DT_ATUALIZACAO BETWEEN :dt_inicial AND fim_dia(:dt_final)
    and cd_setor_atendimento = 32 --banc de sangue
    AND IE_SUSPENSO = 'N'
    ) b
ON
    a.NR_PRESCRICAO = b.NR_PRESCRICAO and
    a.NR_ATENDIMENTO = :NR_ATENDIMENTO2 
    and :CD_RELATORIO = 1 
@SQL_WHERE
order by    NR_PRESCRICAO, NR_SEQUENCIA

/*
Totalizador com atendimento 
Atendimento(sintético) 
*/
/*ATENDIMENTO*/
SELECT DISTINCT
    a.NR_ATENDIMENTO  NR_ATENDIMENTO2,
    SUBSTR(obter_nome_pf(a.CD_PESSOA_FISICA), 1, 255) AS nm_paciente,
    SUBSTR(obter_nome_setor(a.cd_setor_atendimento),1,100)as setor,
    a.cd_setor_atendimento,
    a.NR_ATENDIMENTO,
    a.convenio,
    a.ds_convenio
FROM
    (SELECT DISTINCT
        NR_ATENDIMENTO,
        NR_PRESCRICAO,
        CD_MEDICO,
        CD_PESSOA_FISICA,
        CD_SETOR_ATENDIMENTO,
        substr(Obter_Convenio_Atendimento(nr_atendimento),1,50) convenio,
       substr(obter_nome_convenio(Obter_Convenio_Atendimento(obter_atendimento_prescr(nr_prescricao))),1,100) AS ds_convenio

    FROM
        prescr_medica
    WHERE
        DT_PRESCRICAO BETWEEN :dt_inicial AND fim_dia(:dt_final)
        and DT_LIBERACAO IS NOT NULL
    )a
INNER JOIN
    (SELECT
        NR_PRESCRICAO,
        CD_PROCEDIMENTO,
        nr_seq_proc_interno,
        QT_PROCEDIMENTO,
        DT_ATUALIZACAO,
        ie_status_execucao
    FROM
        prescr_procedimento
    WHERE
        DT_ATUALIZACAO BETWEEN :dt_inicial AND fim_dia(:dt_final)
        AND IE_SUSPENSO = 'N'
        and cd_setor_atendimento = 32 --banc de sangue
    ) b
ON
    a.NR_PRESCRICAO = b.NR_PRESCRICAO
     and :CD_RELATORIO = 2
@SQL_WHERE
ORDER BY
    a.NR_ATENDIMENTO







/*TOTALIZADOR DE PROCEDIMENTO */
SELECT 
    COUNT(b.QT_PROCEDIMENTO) AS num_procedimentos,
    Obter_Desc_Prescr_Proc(b.CD_PROCEDIMENTO, 1, b.nr_seq_proc_interno) procedimento,
    a.convenio,
    a.CD_SETOR_ATENDIMENTO
FROM
    (SELECT
        NR_PRESCRICAO,
        CD_MEDICO,
        CD_PESSOA_FISICA,
        DT_PRESCRICAO,
        NM_USUARIO_ORIGINAL,
        nr_atendimento,
        DT_LIBERACAO,
        substr(Obter_Convenio_Atendimento(nr_atendimento),1,50) convenio,
        obter_setor_prescricao(nr_prescricao,'C')CD_SETOR_ATENDIMENTO
    FROM
        prescr_medica
    WHERE
        DT_LIBERACAO IS NOT NULL
        AND DT_PRESCRICAO BETWEEN :dt_inicial AND fim_dia(:dt_final)
    ) a
INNER JOIN
    (SELECT
        NR_PRESCRICAO,
        CD_PROCEDIMENTO,
        nr_seq_proc_interno,
        QT_PROCEDIMENTO,
        DT_ATUALIZACAO,
        ie_status_execucao
    FROM
        prescr_procedimento
    WHERE DT_ATUALIZACAO BETWEEN :dt_inicial AND fim_dia(:dt_final)
    AND IE_SUSPENSO = 'N'
    and cd_setor_atendimento = 32 --banco de sangue
    ) b
ON
    a.NR_PRESCRICAO = b.NR_PRESCRICAO
    AND a.NR_ATENDIMENTO = :NR_ATENDIMENTO2
    and :CD_RELATORIO = 2
@SQL_WHERE
GROUP BY
    Obter_Desc_Prescr_Proc(b.CD_PROCEDIMENTO, 1, b.nr_seq_proc_interno), a.convenio, a.CD_SETOR_ATENDIMENTO
