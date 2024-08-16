 /*---------- OS 117760 Gostaria de verificar a possibilidade de gerar um 
 relatório das notificações  de eventos com essas informações e quebra por setor:*/

-----------------BANDA SETOR APRESENTA SETOR QUEBRA SETOR-----------------------
SELECT  
        distinct a.cd_setor_atendimento,
        substr(obter_ds_setor_atendimento(a.cd_setor_atendimento),1,50)ds_setor
FROM qua_evento_paciente a 
WHERE
    a.dt_evento BETWEEN :dt_inicial AND fim_dia(:dt_final)
order by 2
-----------------SQL COM  CLASSIFICAÇÃO/QUAL/COUT-------------------------------
SELECT  
        count(a.NR_ATENDIMENTO)total_atend,
        substr(Obter_Desc_Quali_Evento(a.NR_SEQ_EVENTO),1,50)ds_class,
        substr(obter_desc_qua_classif_evento(a.ie_classificacao,1),1,255)ds_qua
FROM qua_evento_paciente a  
WHERE
    a.dt_evento BETWEEN :dt_inicial AND fim_dia(:dt_final)
and (a.cd_setor_atendimento = :cd_setor_atendimento or :cd_setor_atendimento = 0)
group by substr(Obter_Desc_Quali_Evento(a.NR_SEQ_EVENTO),1,50),
        substr(obter_desc_qua_classif_evento(a.ie_classificacao,1),1,255)
--------------------TOTALIZADOR GERAL-------------------------------------------
SELECT  
        count(a.NR_ATENDIMENTO)total_atend,
        substr(obter_ds_setor_atendimento(a.cd_setor_atendimento),1,50)ds_setor
        substr(obter_desc_qua_classif_evento(a.ie_classificacao,1),1,255)ds_qua
FROM qua_evento_paciente a  
WHERE
    a.dt_evento BETWEEN :dt_inicial AND fim_dia(:dt_final)
and (a.cd_setor_atendimento = :cd_setor_atendimento or :cd_setor_atendimento = 0)

group by substr(obter_ds_setor_atendimento(a.cd_setor_atendimento),1,50)
            
order by 2
--------------------TOTALIZADOR SETOR-------------------------------------------

SELECT  
        count(a.NR_ATENDIMENTO)total_atend
FROM qua_evento_paciente a  
WHERE
    a.dt_evento BETWEEN :dt_inicial AND fim_dia(:dt_final)
and (a.cd_setor_atendimento = :cd_setor_atendimento or :cd_setor_atendimento = 0)
group by substr(obter_desc_qua_classif_evento(a.ie_classificacao,1),1,255)

HCB - Eventos Pacientes Qualidade



-------------------------
SELECT  
        distinct(substr(obter_ds_setor_atendimento(a.cd_setor_atendimento),1,50))ds_setor,
        count(a.NR_ATENDIMENTO)total_atend,
        substr(Obter_Desc_Quali_Evento(NR_SEQ_EVENTO),1,50)ds_class
        --substr(obter_desc_qua_classif_evento(ie_classificacao,1),1,255) ie_classificacao
FROM
      qua_evento_paciente a 
WHERE
    a.dt_evento BETWEEN TO_DATE(:data_inicio,'dd/mm/yyyy hh24:mi:ss')AND fim_dia(TO_DATE(:data_fim,'dd/mm/yyyy hh24:mi:ss'))
--AND a.NR_SEQ_EVENTO = :NR_SEQ_EVENTO 
--AND A.IE_STATUS  = :IE_STATUS
group by    substr(obter_ds_setor_atendimento(a.cd_setor_atendimento),1,50), 
            substr(Obter_Desc_Quali_Evento(NR_SEQ_EVENTO),1,50)
            --substr(obter_desc_qua_classif_evento(ie_classificacao,1),1,255)
order by 1,3
----------------
SELECT  
        count(a.NR_ATENDIMENTO)total_atend,
        substr(Obter_Desc_Quali_Evento(NR_SEQ_EVENTO),1,50)ds_class
FROM
      qua_evento_paciente a  
WHERE
    a.dt_evento BETWEEN :dt_inicial AND fim_dia(:dt_final)
and (a.cd_setor_atendimento = :cd_setor_atendimento or :cd_setor_atendimento = 0)
group by substr(Obter_Desc_Quali_Evento(NR_SEQ_EVENTO),1,50)
