        --OS ENCERRADAS DENTRO DO MÊS
        select count(distinct(a.NR_SEQUENCIA) )
        from 
        MAN_ORDEM_SERVICO a
        where
        (A.dt_ordem_servico between :DT_INICIAL and fim_dia(:DT_FINAL))
        and A.nr_seq_wheb is null  
        and A.ie_status_ordem =  '3'  --encerradas
        and A.nr_grupo_trabalho =  '2'--informática
        and A.nr_seq_estagio in (select nr_sequencia  from man_estagio_processo  where ie_acao = 1) 
        and A.nr_seq_meta_pe is null 
        AND A.DT_FIM_REAL <= fim_dia(:DT_FINAL)

        --(Todas,Abertas,Em processo,Encerradas)(0,1,2,3) 
        -- janeiro 193 OS ENCERRADAS  