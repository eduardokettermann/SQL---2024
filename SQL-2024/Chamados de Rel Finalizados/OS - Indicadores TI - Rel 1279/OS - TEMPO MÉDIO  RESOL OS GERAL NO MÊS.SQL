--RESOLUÇÃO ENCERRADAS EX JANEIRO 2424 = 333
--TEM QUE PEGA DT_ORDEN_SERVICO PEGA APENAS NO MÊS 
------------------SQL NOVO------------------------  
SELECT 
    ROUND(AVG(Obter_Min_Entre_Datas(a.DT_ORDEM_SERVICO, a.DT_FIM_REAL, 1)) / (60 * 24), 2) || ' Dias' AS tempo_medio,
    TRUNC(ROUND(HCB_OBTER_TEMPO_PRIM_TRIAGEM(:DT_INICIAL, :DT_FINAL, 2, 82), 2)) || ' Min.' AS med_triagem
FROM 
    MAN_ORDEM_SERVICO a
WHERE
    A.dt_ordem_servico BETWEEN :DT_INICIAL AND fim_dia(:DT_FINAL)
    AND A.nr_seq_wheb IS NULL  
    AND A.ie_status_ordem =  '3' 
    AND A.nr_grupo_trabalho = '2'
    AND A.nr_seq_estagio IN (SELECT nr_sequencia FROM man_estagio_processo WHERE ie_acao = 1) 
    AND A.nr_seq_meta_pe IS NULL 
    AND A.DT_FIM_REAL <= fim_dia(:DT_FINAL); -- <-- MUDANÇA
    
------------------SQL ANTIGO------------------------  
    SELECT med_triagem,
       temp_med_resol 
FROM
    (SELECT TRUNC(ROUND(HCB_OBTER_TEMPO_PRIM_TRIAGEM(:DT_INICIAL, :DT_FINAL, 2, 82), 2)) || ' Min.' AS med_triagem
     FROM dual)a,
    (select round((AVG(Obter_Min_Entre_Datas(a.DT_ORDEM_SERVICO,a.DT_FIM_REAL,1))/60)/24,2) ||' Dias.' temp_med_resol
    from 
    MAN_ORDEM_SERVICO a
    where
    (A.dt_ordem_servico between :DT_INICIAL and fim_dia(:DT_FINAL))
    and A.nr_seq_wheb is null  
    and A.ie_status_ordem =  '3' 
    and A.nr_grupo_trabalho =  '2'
    and A.nr_seq_estagio in (select nr_sequencia  from man_estagio_processo  where ie_acao = 1) 
    and A.nr_seq_meta_pe is null)b 
