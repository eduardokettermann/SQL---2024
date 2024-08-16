--BIZU ENCERRADAS SEMPRE x.dt_fim_real
--ABERTAS SEMPRE , dt_ordem_servico

/*SQL OS ABERTAS E ENCERRADAS*/
Select a.abertas,
       e.encerradas,
       (e.encerradas * 100)/a.abertas, --VARIAS CASAS COMO RESULTADO
       TRUNC((e.encerradas * 100)/a.abertas,2) AS PORCETAGEM, --TRUNCA  2 CASAS APÓS
       TRUNC((r.fim_real * 100)/e.encerradas,2) 
from
--ENCERRADAS
(select  
COUNT(X.NR_SEQUENCIA) AS encerradas
from	
man_ordem_servico x 
where 1=1 
and x.ie_status_ordem =  '3' --ENCERRADAS  
and x.nr_seq_estagio in (select nr_sequencia  from man_estagio_processo    where ie_acao = 1) 
and x.nr_grupo_trabalho =  :NR_GRUPO_TRABALHO 
and x.nr_seq_wheb is null 
and x.nr_seq_estagio in (select nr_sequencia  from man_estagio_processo  where ie_acao = 1) 
and x.nr_seq_meta_pe is null 
and (x.dt_fim_real between :DT_INICIAL and fim_dia(:DT_FINAL))
)e,
--ABERTAS
(select count(x.nr_sequencia) AS abertas
 from	
 man_ordem_servico x 
 WHERE x.nr_seq_estagio in (select nr_sequencia  from man_estagio_processo    where ie_acao = 1) 
 and x.nr_grupo_trabalho =  :NR_GRUPO_TRABALHO
 and x.nr_seq_wheb is null  
 and x.nr_seq_estagio in (select nr_sequencia  from man_estagio_processo  where ie_acao = 1) 
 and x.nr_seq_meta_pe is null 
 and (x.dt_ordem_servico between :DT_INICIAL and fim_dia(:DT_FINAL)) 
)a