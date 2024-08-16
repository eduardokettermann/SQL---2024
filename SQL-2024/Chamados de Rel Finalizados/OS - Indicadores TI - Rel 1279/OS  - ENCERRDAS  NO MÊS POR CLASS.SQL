select 
round((AVG(Obter_Min_Entre_Datas(a.DT_ORDEM_SERVICO,a.DT_FIM_REAL,1))/60)/24,2) ||' Dias' tempo,
decode(A.IE_PRIORIDADE,'E','Emergência','U','Urgência','A','Alta','M','Média','B','Baixa','S','Sem Informação') IE_CLASSIFICACAO
from 
MAN_ORDEM_SERVICO a
where
(A.dt_ordem_servico between :DT_INICIAL and fim_dia(:DT_FINAL))
and A.nr_seq_wheb is null  
and A.ie_status_ordem =  '3' --encerradas
and A.nr_grupo_trabalho =  '2' --informática
and A.nr_seq_estagio in (select nr_sequencia  from man_estagio_processo  where ie_acao = 1) 
and A.nr_seq_meta_pe is null 
AND A.DT_FIM_REAL <= fim_dia(:DT_FINAL)

group by decode(A.IE_PRIORIDADE,'E','Emergência','U','Urgência','A','Alta','M','Média','B','Baixa','S','Sem Informação')