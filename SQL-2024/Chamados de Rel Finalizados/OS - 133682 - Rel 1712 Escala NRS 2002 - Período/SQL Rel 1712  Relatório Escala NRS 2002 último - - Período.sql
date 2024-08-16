/*Relatório filtra total  de escalas dos pacientes internados
ATENDIMENTO_PACIENTE_v → ATENDIMENTOS INTERNADOS
escala_nrs              → ESCALAS REALIZADAS NA FUNÇÃO PEP ESCALAS

OBS: BANDA SETOR,CONVENIO,RESUMO, RESUMO DESCRIÇÃO
TODOS OS FILTROS FORAM PASSADOS COM @SQL_WHERE

O PARÂMETRO UTILIZADO PARA PASSAR DA BANDA MÃE PARA FILHA FOI  A.NR_SEQUENCIA
NA BANDA /*RESUMO GERAL*/ -→passgem de parâmetro: a.nr_sequencia e QT_PONTUACAO  /*RESUMO GERAL DESCRICAO*/ 
*/

SELECT	/*SETOR*/
    DISTINCT b.CD_SETOR_ATENDIMENTO,
    b.DS_SETOR_ATENDIMENTO,
    a.nr_sequencia nr_sequencia1,
    a.nr_atendimento
FROM	escala_nrs a
JOIN
    ATENDIMENTO_PACIENTE_v b ON a.NR_ATENDIMENTO = b.NR_ATENDIMENTO
where a.DT_LIBERACAO BETWEEN :DT_INICIAL and fim_dia(:DT_FINAL) 
and :CD_RELATORIO = 1
@SQL_WHERE
order by 2
/***************************************/
SELECT	/*CONVÊNO*/
    DISTINCT b.CD_CONVENIO,
    b.DS_CONVENIO,
    a.nr_sequencia nr_sequencia2
FROM	escala_nrs a
JOIN
    ATENDIMENTO_PACIENTE_v b ON a.NR_ATENDIMENTO = b.NR_ATENDIMENTO
where a.DT_LIBERACAO BETWEEN :DT_INICIAL and fim_dia(:DT_FINAL) 
AND a.nr_sequencia  = :nr_sequencia1 
and :CD_RELATORIO = 1
@SQL_WHERE
order by 2
/***************************************/
SELECT	/*RESUMO GERAL*/
    count(a.nr_sequencia)total,
    a.QT_PONTUACAO AS PONT1,
	SUBSTR(Obter_Resul_nrs(a.qt_pontuacao),1,255) ds_pontuacao,
    b.CD_CONVENIO, 
    b.CD_SETOR_ATENDIMENTO,
    a.nr_sequencia nr_sequencia3
FROM	escala_nrs a
JOIN
    ATENDIMENTO_PACIENTE_v b ON a.NR_ATENDIMENTO = b.NR_ATENDIMENTO
where a.DT_LIBERACAO BETWEEN :DT_INICIAL and fim_dia(:DT_FINAL) 
and :CD_RELATORIO = 1
AND a.nr_sequencia  = :nr_sequencia2 
@SQL_WHERE
group by    a.QT_PONTUACAO, 
            SUBSTR(Obter_Resul_nrs(a.qt_pontuacao),1,255),
            b.CD_CONVENIO, 
            b.CD_SETOR_ATENDIMENTO,
            a.nr_sequencia
order by 2
/***************************************/
SELECT /*RESUMO GERAL DESCRICAO*/
    b.DS_IDADE, 
    b.DS_SEXO,
    b.NR_ATENDIMENTO,
    Obter_Clinica_Atendimento(b.NR_ATENDIMENTO) DS_CLINICA,
    a.DS_OBSERVACAO,
    NVL(SUBSTR(obter_desc_cid_doenca((  SELECT y.CD_CID_PRINCIPAL
                                        FROM SUS_LAUDO_PACIENTE y
                                        WHERE y.DT_EMISSAO =    (SELECT MIN(z.DT_EMISSAO)
                                                                FROM SUS_LAUDO_PACIENTE z
                                                                WHERE z.DT_EMISSAO BETWEEN :dt_inicial AND fim_dia(:dt_final)
                                                                AND z.nr_atendimento = y.nr_atendimento
                    AND y.nr_atendimento = a.nr_atendimento
                    )), 1, 100),'Não possui diagnóstico') AS ds_cid2,
    NVL(SUBSTR(obter_desc_cid_doenca((  SELECT y.cd_doenca
                                        FROM diagnostico_doenca  y
                                        WHERE y.dt_diagnostico =(SELECT MIN(z.dt_diagnostico)
                                                                FROM diagnostico_doenca  z
                                                                WHERE z.dt_diagnostico BETWEEN :dt_inicial AND fim_dia(:dt_final)
                                                                AND z.ie_situacao = 'A'
                                                                AND z.dt_inativacao IS NULL
                                                                AND z.nr_atendimento = y.nr_atendimento)
                    AND y.ie_situacao = 'A'
                    AND y.dt_inativacao IS NULL
                    AND y.nr_atendimento = a.nr_atendimento
                    )), 1, 100),'Não possui diagnóstico') AS ds_cid
    

FROM	escala_nrs a
JOIN
    ATENDIMENTO_PACIENTE_v b ON a.NR_ATENDIMENTO = b.NR_ATENDIMENTO
where a.DT_LIBERACAO BETWEEN :DT_INICIAL and fim_dia(:DT_FINAL) 
and :CD_RELATORIO = 1
AND a.QT_PONTUACAO = :PONT1
AND a.nr_sequencia  = :nr_sequencia3
@SQL_WHERE
order by 2

/********************DADOS RESUMIDO POR NOTA**************************************/
SELECT	
    count(a.nr_sequencia)total,
    'De 0 até 2 - Reavaliar o paciente semanalmente. Se o paciente realizará grande cirurgia, um plano de cuidado nutricional deve ser considerado para evitar estado de risco associado.' pontuacao
FROM	escala_nrs a, ATENDIMENTO_PACIENTE_v b
WHERE	
a.DT_LIBERACAO BETWEEN :DT_INICIAL and fim_dia(:DT_FINAL) 
and a.NR_ATENDIMENTO = b.NR_ATENDIMENTO
and a.QT_PONTUACAO >=0 and a.QT_PONTUACAO < 3 
and :CD_RELATORIO = 2
AND a.nr_sequencia  = :nr_sequencia2 
@SQL_WHERE
group by 'De 0 até 2 - Reavaliar o paciente semanalmente. Se o paciente realizará grande cirurgia, um plano de cuidado nutricional deve ser considerado para evitar estado de risco associado.'
UNION
SELECT	
    count(a.nr_sequencia)total,
    'Maior e igual a 3 - O paciente está em risco nutricional e um plano nutricional é iniciado' pontuacao
FROM	escala_nrs a, ATENDIMENTO_PACIENTE_v b
WHERE	
a.DT_LIBERACAO BETWEEN :DT_INICIAL and fim_dia(:DT_FINAL)
and a.NR_ATENDIMENTO = b.NR_ATENDIMENTO
and a.QT_PONTUACAO >= 3 
and :CD_RELATORIO = 2
AND a.nr_sequencia  = :nr_sequencia2 
@SQL_WHERE
group by 'Maior e igual a 3 - O paciente está em risco nutricional e um plano nutricional é iniciado '

