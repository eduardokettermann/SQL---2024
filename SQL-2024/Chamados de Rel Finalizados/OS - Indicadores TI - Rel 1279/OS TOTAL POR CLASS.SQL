SELECT
U.Ie_Classificacao,
U.Total,
U.Ie_Prioridade,
(round(((U.Total*100) / select  COUNT (x.nr_sequencia) T_ENCERRADAS
                        froM man_ordem_servico x  where 1=1 and x.ie_status_ordem =  '3'   
                        and x.nr_seq_estagio in (select nr_sequencia  from man_estagio_processo    where ie_acao = 1) 
                        and x.nr_grupo_trabalho =  :NR_GRUPO_TRABALHO 
                        and x.nr_seq_wheb is null  
                        and x.nr_seq_estagio in (select nr_sequencia  from man_estagio_processo  where ie_acao = 1) 
                        and x.nr_seq_meta_pe is null 
                        and (x.dt_fim_real between :DT_INICIAL and fim_dia(:DT_FINAL))
)),2)) PORCENT
FROM
(
/*TOTAL AGRUPADO POR CLASSIFICAÇÃO*/
Select  
count (x.IE_PRIORIDADE) total,
decode(x.IE_PRIORIDADE,'E','Emergência','U','Urgência','A','Alta','M','Média','B','Baixa','S','Sem Informação') IE_CLASSIFICACAO,
x.IE_PRIORIDADE IE_PRIORIDADE
from	
man_ordem_servico x 
where 1=1 
and x.nr_seq_estagio in (select nr_sequencia  from man_estagio_processo    where ie_acao = 1) 
and x.nr_grupo_trabalho =  :NR_GRUPO_TRABALHO 
and x.nr_seq_wheb is null 
and x.nr_seq_estagio in (select nr_sequencia  from man_estagio_processo  where ie_acao = 1) 
and x.nr_seq_meta_pe is null 
and (x.dt_fim_real between :DT_INICIAL and fim_dia(:DT_FINAL)) 
group by decode(x.IE_PRIORIDADE,'E','Emergência','U','Urgência','A','Alta','M','Média','B','Baixa','S','Sem Prioridade'), x.IE_PRIORIDADE, 'E', 'Emergência', decode(x.IE_PRIORIDADE,'E','Emergência','U','Urgência','A','Alta','M','Média','B','Baixa','S','Sem Informação'), 
'U', 'Urgência', 'A', 'Alta', 'M', 
'Média', 'B', 'Baixa', 'S', 'Sem Prioridade' 
order by IE_CLASSIFICACAO
) U 
order by Ie_Classificacao