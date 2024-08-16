        select   DISTINCT to_char(to_date(to_char(x.dt_ordem_servico,'mm'), 'mm'), 'Month') DS_MES
        from 	
        man_ordem_servico x 
        where   	
        (x.dt_ordem_servico between :DT_INICIAL and fim_dia(:DT_FINAL))
        and x.nr_seq_wheb is null 
        and x.nr_grupo_trabalho =  :NR_GRUPO_TRABALHO
        and x.ie_grau_satisfacao <> '0'
        and x.nr_seq_meta_pe is null 
        