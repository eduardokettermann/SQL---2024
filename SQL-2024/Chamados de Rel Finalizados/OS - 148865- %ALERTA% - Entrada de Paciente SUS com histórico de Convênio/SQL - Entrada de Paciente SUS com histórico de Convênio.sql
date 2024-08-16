/*
OS → 148865
COMO ACESSAR O ALERTA QUE DISPARA UM COMUNICADOR PARA USUÁRIO 
SHIFT+F11
ESCREVE %ALERTA%
QUALIDADE
ALERTAS DO TASY 
NOME DO ALERTA = Entrada de Paciente SUS com histórico de Convênio
*/

--BACKUP DO ANTIGO
select  sum(total) from (select count(*)total
from ATENDIMENTO_PACIENTE a 
where DT_ENTRADA between sysdate - 0.0072 and sysdate 
and  exists  ( SELECT 1 FROM ATENDIMENTO_PACIENTE X
WHERE  X.CD_PESSOA_FISICA = a.CD_PESSOA_FISICA
AND X.IE_TIPO_CONVENIO in (2,1)
AND OBTER_DADOS_ATENDIMENTO(X.NR_ATENDIMENTO,'CC') NOT IN (1,19)
AND ((X.IE_TIPO_ATENDIMENTO = 7 AND OBTER_DADOS_ATENDIMENTO(X.NR_ATENDIMENTO,'CC') NOT IN (16))OR(1=1)))
AND a.IE_TIPO_CONVENIO in (3)
and IE_TIPO_ATENDIMENTO in (1) 
and  IE_TIPO_CONVENIO in (3)
union all
select count(*)total
from ATENDIMENTO_PACIENTE a 
where DT_ENTRADA between sysdate - 0.0072 and sysdate 
and  exists  ( SELECT 1 FROM ATENDIMENTO_PACIENTE X
WHERE  X.CD_PESSOA_FISICA = a.CD_PESSOA_FISICA
AND X.IE_TIPO_CONVENIO in (2,1)
AND OBTER_DADOS_ATENDIMENTO(X.NR_ATENDIMENTO,'CC') NOT IN (1,19))
AND a.IE_TIPO_CONVENIO in (3)
and IE_TIPO_ATENDIMENTO in (8)
and IE_CLINICA in (2))

--SQL NOVO
SELECT
    SUM(total)
FROM
    (
        SELECT COUNT(*) total
        FROM atendimento_paciente a
        WHERE dt_entrada BETWEEN sysdate - 0.0072 AND sysdate
        AND EXISTS (SELECT 1
                    FROM atendimento_paciente x
                    WHERE x.cd_pessoa_fisica = a.cd_pessoa_fisica
                    AND x.ie_tipo_convenio IN ( 2, 1 )
                    AND obter_dados_atendimento(x.nr_atendimento, 'CC') NOT IN ( 1, 19 )
            AND (( x.ie_tipo_atendimento = 7  AND obter_dados_atendimento(x.nr_atendimento, 'CC') NOT IN ( 16,1,4 ))
                    OR ( 1 = 1 ) )
                    )
            AND a.ie_tipo_convenio IN ( 3 )
            AND ie_tipo_atendimento IN ( 1 )
            AND ie_tipo_convenio IN ( 3 )
        
        UNION ALL
        
        SELECT COUNT(*) total
        FROM atendimento_paciente a
        WHERE dt_entrada BETWEEN sysdate - 0.0072 AND sysdate
        AND EXISTS (SELECT 1 
                    FROM atendimento_paciente x
                    WHERE x.cd_pessoa_fisica = a.cd_pessoa_fisica
                    AND x.ie_tipo_convenio IN ( 2, 1 )
                    AND obter_dados_atendimento(x.nr_atendimento, 'CC') NOT IN ( 1,19,4,16)
                    )
        AND a.ie_tipo_convenio IN ( 3 )
        AND ie_tipo_atendimento IN ( 8 )
        AND ie_clinica IN ( 2 )
    )



        
    SELECT * FROM CONVENIO
    WHERE CD_CONVENIO  IN (16,1,4)
    
    SELECT A.CD_CONVENIO FROM  atendimento_paciente a