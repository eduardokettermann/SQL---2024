


SELECT a.cd_material,
    SUBSTR(obter_desc_material(a.cd_material), 1, 120) ds_material,
    SUBSTR(DECODE(a.ie_acao,'I',obter_texto_tasy(458780, wheb_usuario_pck.get_nr_seq_idioma),obter_texto_tasy(458781, wheb_usuario_pck.get_nr_seq_idioma)),1,50) ie_acao,
    a.qt_material
FROM mat_atend_pac_log a,
     cirurgia b
WHERE a.nr_prescricao = b.nr_prescricao
    AND a.cd_funcao IN (900, -2009)
    and a.DT_ENTRADA_UNIDADE is null
    and b.dt_inicio_real BETWEEN inicio_dia(:dt_inicial) AND fim_dia(:dt_final)
    and ((a.ie_acao = :ie_acao)
        or (:ie_acao = 'T'))
    AND B.NR_ATENDIMENTO = PNR_ATENDIMENTO
order by 2

/****************************************************************/
/*LOCALIZA O NÚMERO DO DOMINIO DE ALGUM ATRIBUTO QUE DESEJE SABER/
/****************************************************************/
select  NM_TABELA,
        NM_ATRIBUTO,
        IE_TIPO_ATRIBUTO,
        DS_ATRIBUTO,
        IE_SITUACAO,
        DS_VALORES,
        CD_DOMINIO,
        DS_LABEL,
        DS_LABEL_GRID,
        DS_MASCARA,   
        CD_EXP_DESC,
        substr(obter_desc_expressao(cd_exp_desc),1,254)ds_exp_desc
from TABELA_ATRIBUTO
where NM_ATRIBUTO = ('IE_CLASSIFICACAO')
AND NM_TABELA LIKE ('%MAN_ORDEM_SERVICO')

/******************************************/
/*RESULTADO CD_DOMINIO RETORNA OS VALORES /
/****************************************/
SELECT  DISTINCT
        --a.NM_DOMINIO,
        A.CD_DOMINIO,
        OBTER_NOME_DOMINIO(A.CD_DOMINIO)NOME_DOMINIO,
        b.VL_DOMINIO,
        b.DS_VALOR_DOMINIO,
        substr(Obter_Desc_Modulo(a.NR_SEQ_MODULO),1,250)modulo,
        B.CD_EXP_VALOR_DOMINIO,
        A.CD_EXP_DOMINIO,
        A.CD_EXP_DESC_DOMINIO
from DOMINIO A , VALOR_DOMINIO B
WHERE  A.CD_DOMINIO = B.CD_DOMINIO
AND  B.CD_DOMINIO = :CD_DOMINIO                                       --FILTRO PELO CD_DOMINIO
--AND B.DS_VALOR_DOMINIO LIKE ('%SMS%')                                --FILTRO PELO DS_DOMINIO
--AND (substr(OBTER_NOME_DOMINIO(A.CD_DOMINIO),1,250) LIKE '%sms%')    --FILTRO PELO NOME_DOMINIO
--substr(Obter_Desc_Modulo(a.NR_SEQ_MODULO),1.250) LIKE '%Cadastros pessoas%') --FILTRO PELO MODULO
AND IE_SITUACAO = 'A'
ORDER BY 1,4







 /*Só no momento de impressão*/
 SELECT * FROM LOG_IMPRESSAO_RELAT where DT_FASE1 <= sysdate







SELECT
    obter_dado_atributo('ATENDIMENTO_PACIENTE', 'IE_TIPO_ATENDIMENTO')
FROM
    dual
----------------------------
SELECT
    obter_dados_atributo('DT_OCORRENCIA', 'SUS_APAC_UNIF', 'LB')
FROM
    dual
    









SELECT
DECODE(O.IE_CLASSIFICACAO, 'D', 'Dúvida', 'E', 'Defeito','S', 'Solicitação','T', 'Sugestão') DS_CLASSIFICACAO,
O.TOTAL_CLASSIFICACAO
FROM
(
    select 
    count(x.IE_CLASSIFICACAO) TOTAL_CLASSIFICACAO,
    x.IE_CLASSIFICACAO
    from	
          man_ordem_servico x 
    where 1=1 
    and x.IE_CLASSIFICACAO is not null
    and x.ie_status_ordem =  '3'   
    and x.nr_seq_estagio in (select nr_sequencia  from man_estagio_processo    where ie_acao = 1) 
    and x.nr_grupo_trabalho =  :NR_GRUPO_TRABALHO 
    and x.nr_seq_wheb is null  
    and (x.dt_fim_real between :DT_INICIAL and fim_dia(:DT_FINAL))
    group by x.IE_CLASSIFICACAO
) O 
 ORDER BY DS_CLASSIFICACAO ASC






select  
' ' || SUBSTR(AVAL(NR_SEQUENCIA,3065),1,255) ORIGEM,
' ' || SUBSTR(AVAL(NR_SEQUENCIA,3066),1,255) DESTINO,
' ' || SUBSTR(AVAL(NR_SEQUENCIA,3068),1,255) MOTIVO_INT,
SUBSTR(AVAL(NR_SEQUENCIA,3109),1,255) MORSE,
DECODE(AVAL(NR_SEQUENCIA,3074),'S','X','') NAO_APLICA_MORSE,
DECODE(AVAL(NR_SEQUENCIA,3069),'S','X','') ALERGIA_NAO,
DECODE(AVAL(NR_SEQUENCIA,3075),'S','X','') ALERGIA_SIM,
' ' || SUBSTR(AVAL(NR_SEQUENCIA,3076),1,255) ALERGIA_QUAL,
DECODE(AVAL(NR_SEQUENCIA,3079),'S','X','') BRONCO_SIM,
DECODE(AVAL(NR_SEQUENCIA,3080),'S','X','') BRONCO_NAO,
DECODE(AVAL(NR_SEQUENCIA,3085),'S','X','') ISOLAMENTO_NAO,
DECODE(AVAL(NR_SEQUENCIA,3086),'S','X','') ISOLAMENTO_SIM,
' ' || SUBSTR(AVAL(NR_SEQUENCIA,3087),1,255) ISOLAMENTO_QUAL,
' ' || SUBSTR(AVAL(NR_SEQUENCIA,3089),1,255) ECA,
DECODE(AVAL(NR_SEQUENCIA,3090),'S','X','') ECA_NAO_APLICA,
' ' || SUBSTR(AVAL(NR_SEQUENCIA,3070),1,255) MEWS,
DECODE(AVAL(NR_SEQUENCIA,3077),'S','X','') MEWS_NAO_APLICA,
' ' || SUBSTR(AVAL(NR_SEQUENCIA,3081),1,255) PEWS,
DECODE(AVAL(NR_SEQUENCIA,3082),'S','X','') PEWS_NAO_APLICA,
SUBSTR(AVAL(NR_SEQUENCIA,3113),1,255) || ' mm/Hg' PA,
SUBSTR(AVAL(NR_SEQUENCIA,3114),1,255) || ' bpm' FC,
SUBSTR(AVAL(NR_SEQUENCIA,3112),1,255) || ' %' SAT_O2,
SUBSTR(AVAL(NR_SEQUENCIA,3111),1,255) || ' ipm' FR,
SUBSTR(AVAL(NR_SEQUENCIA,3083),1,255) || ' C°' TEMPERATURA,
DECODE(AVAL(NR_SEQUENCIA,3116),'S','X','') AA,
DECODE(AVAL(NR_SEQUENCIA,3117),'S','X','') O2_ATRAVES,
' ' || SUBSTR(AVAL(NR_SEQUENCIA,3118),1,255) DS_O2_ATRAVES,
DECODE(AVAL(NR_SEQUENCIA,3120),'S','X','') TQT_SIM,
DECODE(AVAL(NR_SEQUENCIA,3121),'S','X','') TQT_NAO,
DECODE(AVAL(NR_SEQUENCIA,3123),'S','X','') VO,
DECODE(AVAL(NR_SEQUENCIA,3124),'S','X','') SNE_SNG,
DECODE(AVAL(NR_SEQUENCIA,3125),'S','X','') DIETAS_OUTRO,
' ' || SUBSTR(AVAL(NR_SEQUENCIA,3126),1,255) DS_DIETAS_OUTRO,
DECODE(AVAL(NR_SEQUENCIA,3128),'S','X','') AVP,
' ' || SUBSTR(AVAL(NR_SEQUENCIA,3129),1,255) AVP_LOCAL,
DECODE(AVAL(NR_SEQUENCIA,3130),'S','X','') AVC,
' ' || SUBSTR(AVAL(NR_SEQUENCIA,3131),1,255) AVC_LOCAL,
DECODE(AVAL(NR_SEQUENCIA,3060),'S','X','') FAV,
' ' || SUBSTR(AVAL(NR_SEQUENCIA,3061),1,255) FAV_LOCAL,
DECODE(AVAL(NR_SEQUENCIA,3096),'S','X','') CURATIVO_NAO,
DECODE(AVAL(NR_SEQUENCIA,3097),'S','X','') CURATIVO_SIM,
' ' || SUBSTR(AVAL(NR_SEQUENCIA,3098),1,255) CURATIVO_LOCAL,
DECODE(AVAL(NR_SEQUENCIA,3092),'S','X','') DRENOS_NAO,
DECODE(AVAL(NR_SEQUENCIA,3093),'S','X','') DRENOS_SIM,
' ' || SUBSTR(AVAL(NR_SEQUENCIA,3094),1,255) DRENOS_QUAL,
DECODE(AVAL(NR_SEQUENCIA,3133),'S','X','') ESPONTANEA,
DECODE(AVAL(NR_SEQUENCIA,3134),'S','X','') SVD,
DECODE(AVAL(NR_SEQUENCIA,3135),'S','X','') ELIM_OUTRO,
' ' || SUBSTR(AVAL(NR_SEQUENCIA,3136),1,255) DS_ELIM_OUTRO,
DECODE(AVAL(NR_SEQUENCIA,3100),'S','X','') VIGENTE_SIM,
DECODE(AVAL(NR_SEQUENCIA,3101),'S','X','') VIGENTE_NAO,
DECODE(AVAL(NR_SEQUENCIA,3139),'S','X','') LIBERADA_SIM,
DECODE(AVAL(NR_SEQUENCIA,3140),'S','X','') LIBERADA_NAO,
DECODE(AVAL(NR_SEQUENCIA,3142),'S','X','') MEDICACAO_SIM,
DECODE(AVAL(NR_SEQUENCIA,3143),'S','X','') MEDICACAO_NAO,
DECODE(AVAL(NR_SEQUENCIA,3103),'S','X','') PENDENCIA_NAO,
DECODE(AVAL(NR_SEQUENCIA,3104),'S','X','') PENDENCIA_SIM,
' ' || SUBSTR(AVAL(NR_SEQUENCIA,3105),1,255) PENDENCIA_QUAL,
DECODE(AVAL(NR_SEQUENCIA,3145),'S','X','') ACOMPANHANTE_SIM,
DECODE(AVAL(NR_SEQUENCIA,3146),'S','X','') ACOMPANHANTE_NAO,

' ' || SUBSTR(AVAL(NR_SEQUENCIA,3106),1,255) OBSERVACAO,
' ' || SUBSTR(AVAL(NR_SEQUENCIA,3107),1,255) NM_ORIGEM,
' ' || SUBSTR(AVAL(NR_SEQUENCIA,3108),1,255) NM_DESTINO,
' ' || SUBSTR(AVAL(NR_SEQUENCIA,3151),1,255) RETORNO,
' ' || SUBSTR(AVAL(NR_SEQUENCIA,3152),1,255) TECNICO_ORIGEM,
' ' || SUBSTR(AVAL(NR_SEQUENCIA,3153),1,255) TECNICO_DESTINO
from    
    MED_AVALIACAO_PACIENTE a
where  
    a.NR_SEQUENCIA = :nr_seq_avaliacao_p



/*Dados Atendimento*/
select  a.cd_pessoa_fisica,
       	a.nr_prontuario,
       	a.nr_atendimento,
       	a.nm_paciente,
       	a.dt_entrada,
       	a.dt_alta, 
        a.cd_cid_principal,
        a.cd_cid_secundario,
        a.ie_sexo,
	    a.ds_origem_usuario,
       	a.nm_medico_crm,
 	    a.dt_validade_carteira,
	    b.dt_periodo_inicial,
	    b.dt_periodo_final,
	    b.dt_mesano_referencia,
       	(a.cd_motivo_alta || '  ' || a.ds_motivo_alta) ds_motivo_alta,
       	c.ds_convenio,
	    b.dt_acerto_conta,
	    d.ds_categoria,
      	(a.ie_clinica || '  ' ||  a.ds_clinica) ds_clinica,
      	(a.ie_tipo_atendimento || '  ' || a.ds_tipo_atendimento) ds_tipo_atendimento,
       	c.cd_interno,
       	substr(OBTER_CODIGO_USUARIO_ATECACO(a.nr_atendimento, b.cd_convenio_parametro),1,40) cd_usuario_convenio,
	    substr(OBTER_TITULO_CONTA_PROTOCOLO(null, b.nr_interno_conta),1,100) nr_titulo,
       	b.nr_interno_conta,
       	b.cd_convenio_parametro,
       	obter_guias_conta(b.nr_interno_conta) ds_guias,
       	substr(obter_valor_dominio(1122, b.ie_tipo_nascimento),1,60) ds_tipo_nascimento,
       	substr(OBTER_PROC_PRINCIPAL(A.NR_ATENDIMENTO, b.cd_convenio_parametro, A.IE_TIPO_ATENDIMENTO, b.nr_interno_conta,'C'),1,8) CD_PROC_PRINC_CONTA,
      	InitCap(substr(OBTER_PROC_PRINCIPAL(A.NR_ATENDIMENTO, b.cd_convenio_parametro, A.IE_TIPO_ATENDIMENTO, b.nr_interno_conta,'D'),1,240)) 														DS_PROC_PRINC_CONTA,
       	b.ie_status_acerto, b.DS_OBSERVACAO

from 	convenio c,
	    categoria_convenio d,
        atendimento_paciente_v a,
        conta_paciente b

where 	a.nr_atendimento = b.nr_atendimento
and 	b.cd_convenio_parametro = c.cd_convenio
and 	b.cd_convenio_parametro = d.cd_convenio
and 	b.cd_categoria_parametro = d.cd_categoria
and 	b.nr_interno_conta = :nr_interno_conta

/*Quebra Histórico Contas Anter*/
select  'Histórico de Contas Anteriores' ds_quebra
from    conta_paciente_anterior_v
where nr_interno_conta = :nr_interno_conta
--and ie_emite_conta = '24'-- ←

/*Dados Histórico Conta*/
select	rownum nr_seq,
	    nr_interno_conta_ant,
	    dt_periodo_inicial,
	    dt_periodo_final
from	conta_paciente_anterior_v
where	nr_interno_conta = :nr_interno_conta
--and	ie_emite_conta = '24'

/*Quebra Procedimento*/
select	e.cd_estrutura cd_estrutura_p,
	e.ds_estrutura ds_quebra
from	conta_paciente_estrutura e
where	e.cd_estrutura in 	(select	p.ie_emite_conta
		       	            from	conta_paciente_procedimento_v p
			                where 	p.nr_interno_conta = :nr_interno_conta
			                and	p.ie_emite_conta <> 100)
union
select	0,
	'Procedimentos'
from	dual
where	0 <	(select	count(cd_procedimento)
		    from 	conta_paciente_procedimento_v
		    where 	nr_interno_conta = :nr_interno_conta
		    and	ie_emite_conta is null)

/*Dados Procedimentos*/
select	cd_procedimento,
	ds_procedimento,
	sum(qt_procedimento) qt_procedimento,
	sum(vl_desconto) vl_desconto,
	sum(vl_liquido) vl_liquido,
	vl_unitario,
	sum(vl_procedimento) vl_procedimento
from(
    select	ds_procedimento,
	    decode(nvl(cd_procedimento_tuss,0), 0, cd_procedimento, cd_procedimento_tuss) cd_procedimento,
	    nvl((sum(vl_procedimento) + sum(vl_desconto)) / sum(qt_procedimento),0) vl_unitario,
	    sum( nvl(vl_procedimento + vl_desconto ,0) ) vl_procedimento,
	    sum( nvl(vl_desconto,0) ) vl_desconto,
	    sum( nvl(vl_procedimento + vl_desconto,0) - nvl(vl_desconto,0) ) vl_liquido,
	    sum( nvl(qt_procedimento,0) ) qt_procedimento
        from 	conta_paciente_procedimento_v
        where 	nr_interno_conta = :nr_interno_conta
        and	ie_emite_conta = :cd_estrutura_p
        group by 	ds_procedimento,
	    decode(nvl(cd_procedimento_tuss,0), 0, cd_procedimento, cd_procedimento_tuss)
union all
        select	ds_procedimento,
	    decode(nvl(cd_procedimento_tuss,0), 0, cd_procedimento, cd_procedimento_tuss) cd_procedimento,
	    nvl((sum(vl_procedimento) + sum(vl_desconto)) / sum(qt_procedimento),0) vl_unitario,
	    sum( nvl(vl_procedimento + vl_desconto,0) ) vl_procedimento,
	    sum( nvl(vl_desconto,0) ) vl_desconto,
	    sum( nvl(vl_procedimento + vl_desconto,0) - nvl(vl_desconto,0) ) vl_liquido,
	    sum( nvl(qt_procedimento,0) ) qt_procedimento
        from 	conta_paciente_procedimento_v
        where 	nr_interno_conta = :nr_interno_conta
        and	ie_emite_conta is null
        and	:cd_estrutura_p = 0
        group by 	ds_procedimento,
	    decode(nvl(cd_procedimento_tuss,0), 0, cd_procedimento, cd_procedimento_tuss)
)
    group by    cd_procedimento,
	            ds_procedimento,
	            vl_unitario
    order by   -- ds_procedimento


    ie_emite_conta   --> '202'





/// ---------- SQL original ------------ \\\
select	obter_desc_material(x.cd_material) ds_material,
	x.ds_lab_brasindice,
	x.ds_apresentacao,
	x.cd_material,
	x.cd_unidade_medida_consumo,
	x.vl_unitario vl_unitario,
	sum(x.qt_material) qt_material,
	sum(x.vl_material) vl_material,
	sum(x.vl_desconto) vl_desconto,
	sum(x.vl_liquido) vl_liquido
from	(	select	nvl(nvl(obter_desc_brasindice(b.cd_laboratorio, b.cd_apresentacao, b.cd_medicamento, 'M'), hcb_obter_dados_brasindice(:cd_estabelecimento_cor,b.cd_convenio,b.cd_categoria,fim_dia(b.dt_atendimento),b.cd_material,null,null,
		b.cd_setor_atendimento,b.cd_cgc_fornecedor,null,b.nr_sequencia,null,null,null,'DMED')), substr(obter_desc_material(b.cd_material),1,255)) ds_material,		nvl(obter_desc_brasindice(b.cd_laboratorio, b.cd_apresentacao, b.cd_medicamento, 'L'),hcb_obter_dados_brasindice(:cd_estabelecimento_cor, b.cd_convenio, b.cd_categoria, fim_dia(b.dt_atendimento), b.cd_material, null, null, b.cd_setor_atendimento, b.cd_cgc_fornecedor, null, b.nr_sequencia, null, null, null, 'DLAB')) ds_lab_brasindice,			nvl(obter_desc_brasindice(b.cd_laboratorio, b.cd_apresentacao, b.cd_medicamento, 'A'),hcb_obter_dados_brasindice(:cd_estabelecimento_cor,b.cd_convenio,b.cd_categoria,fim_dia(b.dt_atendimento),b.cd_material,null,null,
		b.cd_setor_atendimento,b.cd_cgc_fornecedor,null,b.nr_sequencia,null,null,null,'DAPR')) ds_apresentacao,
	a.cd_material,
	a.cd_unidade_medida_consumo,
	sum(a.qt_material) qt_material,
	b.vl_unitario vl_unitario,
	sum(a.vl_material + a.vl_desconto) vl_material,
	sum( nvl(a.vl_desconto,0) ) vl_desconto,
	sum( nvl(a.vl_material + a.vl_desconto,0) - nvl(a.vl_desconto,0) ) vl_liquido
from	conta_paciente_material_v a,
	material_atend_paciente b
where 	a.nr_interno_conta = :nr_interno_conta
and	a.nr_interno_conta = b.nr_interno_conta
and	a.CD_CONVENIO = 3 
and	a.nr_Sequencia = b.nr_sequencia
and	a.ie_emite_conta = :cd_estrutura_p
and	(select 	sum(x.qt_material) 
	from	conta_paciente_material_v x
	where 	x.nr_interno_conta = :nr_interno_conta
	and	a.cd_material = x.cd_material
	and	x.ie_emite_conta = :cd_estrutura_p) > 0
group by	a.cd_material,
	b.cd_convenio,
	b.cd_categoria,
	b.cd_laboratorio,
	b.cd_apresentacao,
	b.cd_medicamento,
	b.vl_unitario,
	fim_dia(b.dt_atendimento),
	b.cd_material,
	b.cd_setor_atendimento,
	b.cd_cgc_fornecedor,
	b.nr_sequencia,
	a.cd_unidade_medida_consumo	) x
where	1 = 1
group by	x.ds_material,
	x.ds_lab_brasindice,
	x.ds_apresentacao,
	x.cd_material,
	x.cd_unidade_medida_consumo,
	x.vl_unitario	
order by	1

/// ---------- SQL substituído ---------- \\\
select obter_desc_material(x.cd_material) ds_material,
    x.ds_lab_brasindice,
    x.ds_apresentacao,
    x.cd_material,
    x.cd_unidade_medida_consumo,
    x.vl_unitario vl_unitario,
    sum(x.qt_material) qt_material,
    sum(x.vl_material) vl_material,
    sum(x.vl_desconto) vl_desconto,
    sum(x.vl_liquido) vl_liquido
from (
        select nvl(
                nvl(
                    obter_desc_brasindice(
                        b.cd_laboratorio,
                        b.cd_apresentacao,
                        b.cd_medicamento,
                        'M'
                    ),
                    hcb_obter_dados_brasindice(
                        '1',
                        b.cd_convenio,
                        b.cd_categoria,
                        fim_dia(b.dt_atendimento),
                        b.cd_material,
                        null,
                        null,
                        b.cd_setor_atendimento,
                        b.cd_cgc_fornecedor,
                        null,
                        b.nr_sequencia,
                        null,
                        null,
                        null,
                        'DMED'
                    )
                ),
                substr(obter_desc_material(b.cd_material), 1, 255)
            ) ds_material,
            nvl(
                obter_desc_brasindice(
                    b.cd_laboratorio,
                    b.cd_apresentacao,
                    b.cd_medicamento,
                    'L'
                ),
                hcb_obter_dados_brasindice(
                    '1',
                    b.cd_convenio,
                    b.cd_categoria,
                    fim_dia(b.dt_atendimento),
                    b.cd_material,
                    null,
                    null,
                    b.cd_setor_atendimento,
                    b.cd_cgc_fornecedor,
                    null,
                    b.nr_sequencia,
                    null,
                    null,
                    null,
                    'DLAB'
                )
            ) ds_lab_brasindice,
            nvl(
                obter_desc_brasindice(
                    b.cd_laboratorio,
                    b.cd_apresentacao,
                    b.cd_medicamento,
                    'A'
                ),
                hcb_obter_dados_brasindice(
                    '1',
                    b.cd_convenio,
                    b.cd_categoria,
                    fim_dia(b.dt_atendimento),
                    b.cd_material,
                    null,
                    null,
                    b.cd_setor_atendimento,
                    b.cd_cgc_fornecedor,
                    null,
                    b.nr_sequencia,
                    null,
                    null,
                    null,
                    'DAPR'
                )
            ) ds_apresentacao,
            a.cd_material,
            a.cd_unidade_medida_consumo,
            sum(a.qt_material) qt_material,
            b.vl_unitario vl_unitario,
            sum(a.vl_material + a.vl_desconto) vl_material,
            sum(nvl(a.vl_desconto, 0)) vl_desconto,
            sum(
                nvl(a.vl_material + a.vl_desconto, 0) - nvl(a.vl_desconto, 0)
            ) vl_liquido
        from conta_paciente_material_v a,
            material_atend_paciente b
        where a.nr_interno_conta = '3172556'
            and a.nr_interno_conta = b.nr_interno_conta
            and a.CD_CONVENIO = 3
            and a.nr_Sequencia = b.nr_sequencia
            and a.ie_emite_conta = '0'
            and (
                select sum(x.qt_material)
                from conta_paciente_material_v x
                where x.nr_interno_conta = '3172556'
                    and a.cd_material = x.cd_material
                    and x.ie_emite_conta = '0'
            ) > 0
        group by a.cd_material,
            b.cd_convenio,
            b.cd_categoria,
            b.cd_laboratorio,
            b.cd_apresentacao,
            b.cd_medicamento,
            b.vl_unitario,
            fim_dia(b.dt_atendimento),
            b.cd_material,
            b.cd_setor_atendimento,
            b.cd_cgc_fornecedor,
            b.nr_sequencia,
            a.cd_unidade_medida_consumo
    ) x
where 1 = 1
group by x.ds_material,
    x.ds_lab_brasindice,
    x.ds_apresentacao,
    x.cd_material,
    x.cd_unidade_medida_consumo,
    x.vl_unitario
order by 1










SELECT CASE
        WHEN TOTAL > 100 THEN 100
        ELSE TOTAL
    END TOTAL
from (
        (
            SELECT ENCERRADAS.TOTAL AS ENCERRADAS,
                ABERTAS.TOTAL AS ABERTAS,
                (ENCERRADAS.TOTAL) /(ABERTAS.TOTAL) * 100 AS RESULTADO,
                (ENCERRADAS.TOTAL * 100) /(ABERTAS.TOTAL) AS RESULTADO1
            FROM (
                    --TOTAL OS ABERTAS
                    select COUNT(x.nr_sequencia) TOTAL
                    from man_ordem_servico x
                    WHERE X.IE_TIPO_ORDEM = 2
                        AND X.NR_GRUPO_TRABALHO = 22
                        AND X.NR_GRUPO_PLANEJ = 14
                        and x.NR_SEQ_ESTAGIO = 41
                        AND X.NR_SEQ_TIPO_ORDEM = 3
                        AND X.DT_FIM_REAL BETWEEN :DT_INICIAL AND FIM_DIA(:DT_FINAL)
                ) ABERTAS,
                (
                    --TOTAL DE OS ENCERRADAS
                    select COUNT(x.nr_sequencia) TOTAL
                    from man_ordem_servico x
                    WHERE X.IE_TIPO_ORDEM = 2
                        AND X.NR_GRUPO_TRABALHO = 22
                        AND X.NR_GRUPO_PLANEJ = 14
                        and x.NR_SEQ_ESTAGIO not in (92)
                        AND X.NR_SEQ_TIPO_ORDEM = 3
                        AND X.DT_ORDEM_SERVICO BETWEEN :DT_INICIAL AND FIM_DIA(:DT_FINAL)
                )
        ) * 100 TOTAL
        FROM DUAL
    )

    @


















/*Obtem a descrição do atibuto*/
select  NM_TABELA,
        NM_ATRIBUTO,
        IE_TIPO_ATRIBUTO,
        DS_ATRIBUTO,
        IE_SITUACAO,
        DS_VALORES,
        CD_DOMINIO,
        DS_LABEL,
        DS_LABEL_GRID,
        DS_MASCARA,
        CD_EXP_DESC,
        substr(obter_desc_expressao(cd_exp_desc),1,254)ds_exp_desc
from TABELA_ATRIBUTO
WHERE NM_TABELA = ('MAN_ORDEM_SERVICO')
AND  NM_ATRIBUTO = ('IE_SOLICITANTE')


-------------------------
select
  A.CD_EVOLUCAO,
  a.dt_evolucao,
	a.ds_evolucao,
	a.dt_liberacao,
	b.nm_paciente,
	b.dt_nascimento,
	b.cd_setor_atendimento,
	b.cd_unidade,
	b.nr_atendimento,
	b.ds_setor_atendimento,
	a.nm_usuario,
	DECODE(c.ds_codigo_prof, NULL, '',DECODE(a.ie_tipo_evolucao, 1, 'CRM ', 5, 'CRP ', 8, 'CRFª ', 11,                 'CRESITO ', 10, 'CRF ', 7, 'CRN ', 4, 'CRN ', 'COREN ') || c.ds_codigo_prof) ds_codigo_prof,
	SUBSTR(obter_valor_dominio(72, a.ie_tipo_evolucao),1,60) ds_tipo_evolucao,
	SUBSTR(obter_desc_espec_medica(a.cd_especialidade),1,40) ds_especialidade,
	DECODE(a.ie_evolucao_clinica,'P',SUBSTR(obter_valor_dominio(1221, a.ie_evolucao_clinica),1,60) ||' 		à' ,'R',SUBSTR(obter_valor_dominio(1221, a.ie_evolucao_clinica),1,60) ||' da' , 			SUBSTR(obter_valor_dominio(1221, a.ie_evolucao_clinica),1,60)) ds_evolucao_clinica,
	b.ds_idade,
	substr(Obter_Dias_Internacao(b.nr_atendimento),1,255) || 'd' qt_dias_inter
FROM	pessoa_fisica c,
	Atendimento_paciente_v b,
	evolucao_paciente_lib_v a
WHERE	a.dt_evolucao BETWEEN :dt_inicial AND :dt_final
  AND	a.nr_atendimento = b.nr_atendimento
  AND	a.cd_pessoa_fisica	= c.cd_pessoa_fisica
  AND	((b.cd_setor_atendimento = :cd_setor_atendimento) OR (0 = :cd_setor_atendimento))
  and	((a.IE_EVOLUCAO_CLINICA = :CD_TIPO_EVOLUCAO) or ('0' = :CD_TIPO_EVOLUCAO))
  and B.DT_ALTA is null 
  //---and A.CD_EVOLUCAO = (select max(cd_evolucao) from evolucao_paciente_lib_v where nr_atendimento = A.NR_ATENDIMENTO group by NR_ATENDIMENTO)--- \\
  order by	B.DS_SETOR_ATENDIMENTO,	B.CD_UNIDADE,	B.NM_PACIENTE,	a.DT_EVOLUCAO









------------------------







delete  from GRUPO_BANDEIRA_CR where NR_SEQUENCIA = 2

select count(*)
from ATENDIMENTO_PACIENTE  
where DT_ENTRADA between sysdate - 0.00694 and sysdate 
and Obter_Usuario_Ativo <> 'EDUARDOK'
and IE_CLINICA in (10,17) 
and IE_TIPO_ATENDIMENTO in (8) 
and  IE_TIPO_CONVENIO in (1)



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






select count(*)
from ATENDIMENTO_PACIENTE  
where DT_ENTRADA between sysdate - 0.00694 and sysdate 
and IE_CLINICA in (10,17) 
and IE_TIPO_ATENDIMENTO in (8) 
and  IE_TIPO_CONVENIO in (1)


--ALERTA VENCIMENTO APAC ok
select 'O paciente '||obter_pessoa_atendimento(x.qt_registro,'N')||' possui APAC com vencimento inferior a 30 dias no atendimento '||x.qt_registro||'.' " "
from(
select
nvl(max(a.nr_atendimento),0) qt_registro
from 
sus_apac_unif a,
atendimento_paciente b
where b.nr_atendimento = a.nr_atendimento
and	b.cd_pessoa_fisica = :cd_pessoa_fisica
and	obter_dias_entre_datas(sysdate, dt_fim_validade) <= 30
and	obter_dias_entre_datas(sysdate, dt_fim_validade) >= 0
and Obter_Usuario_Ativo <> 'EDUARDOSE'
)x where  x.qt_registro > 0

--Alerta para preenchimento do Loco Regional! ok
select DISTINCT 'Paciente não possui o cadastro do Loco Regional! Preencher o Item Loco Regional!' ALERTA
from CAN_LOCO_REGIONAL a 
where 
A.DT_AVALIACAO IS not NULL
and Obter_Clinica_Atendimento(hcb_obter_ultimo_atend_pf
(:CD_PESSOA_FISICA)) = 'Oncologia'
AND OBTER_PERFIL_ATIVO = '1983'
and Obter_Usuario_Ativo <> 'EDUARDOSE'

--Alerta Vencimento APAC
select 'O paciente '||obter_pessoa_atendimento(x.qt_registro,'N')||' possui APAC com vencimento inferior a 30 dias no atendimento '||x.qt_registro||'.' " "
from(
select
nvl(max(a.nr_atendimento),0) qt_registro
from 
sus_apac_unif a,
atendimento_paciente b
where b.nr_atendimento = a.nr_atendimento
and	b.cd_pessoa_fisica = :cd_pessoa_fisica
and	obter_dias_entre_datas(sysdate, dt_fim_validade) <= 30
and	obter_dias_entre_datas(sysdate, dt_fim_validade) >= 0
and Obter_Usuario_Ativo <> 'EDUARDOSE'
)x where  x.qt_registro > 0

--Alerta de avaliação/parecer pendente
SELECT DISTINCT
   'O paciente '||  
  A.NR_ATENDIMENTO||' - '||X.CD_UNIDADE||' - '||OBTER_DADOS_ATENDIMENTO(A.NR_ATENDIMENTO,'NP') 
  ||' está aguardando seu parecer/avaliação!' PARECER
FROM PARECER_MEDICO_REQ A, ATENDIMENTO_PACIENTE_V X
WHERE ((A.CD_PESSOA_PARECER = OBTER_PESSOA_FISICA_USUARIO(Obter_Usuario_Ativo,'C'))
OR ((SELECT CD_PESSOA_FISICA FROM
(SELECT DISTINCT A.CD_PESSOA_FISICA, A.NR_SEQ_EQUIPE FROM PF_EQUIPE_PARTIC A, PF_EQUIPE B 
WHERE A.NR_SEQ_EQUIPE = B.NR_SEQUENCIA AND B.IE_SITUACAO = 'A')WHERE NR_SEQ_EQUIPE = A.NR_SEQ_EQUIPE_DEST 
AND CD_PESSOA_FISICA = OBTER_PESSOA_FISICA_USUARIO(Obter_Usuario_Ativo,'C')) = OBTER_PESSOA_FISICA_USUARIO(Obter_Usuario_Ativo,'C')))
AND A.DT_LIBERACAO                                 IS NOT NULL
AND A.IE_SITUACAO                                   = 'A'
AND SUBSTR(OBTER_SE_PAR_RESPOSTA(A.NR_PARECER),1,5) = 'N'
and Obter_Usuario_Ativo <> 'EDUARDOSE'
AND X.DT_ALTA IS NULL
AND A.NR_ATENDIMENTO = X.NR_ATENDIMENTO






--SQL RELATÓRIO 

select	
    cd_setor_atendimento cd_setor_p,
	substr(obter_nome_setor(cd_setor_atendimento),1,150) ds_setor,
    substr(ds_evento, 1, 1000)
from	qua_evento_paciente

where 	(nvl(:dt_inicial,'  /  /    ') = '  /  /    ' or dt_evento >= to_date(:dt_inicial,'dd/mm/yyyy'))
and 	(nvl(:dt_final,'  /  /    ') = '  /  /    ' or dt_evento <= to_date(:dt_final,'dd/mm/yyyy'))
AND 
(substr(ds_evento, 1, 1000) LIKE '%' || :DESCRISAO_EVENTO || '%' OR :DESCRISAO_EVENTO = '0')
and (IE_STATUS = :IE_STATUS or :IE_STATUS = '0')








--SQL AJUSTADO CAMPO RIGTH EDIT
select 	
	obter_nome_pf(cd_pessoa_fisica) nm_paciente,
	obter_dados_pf(cd_pessoa_fisica,'CPF') nr_cpf,
	obter_compl_pf(cd_pessoa_fisica,1,'E') ds_end,
	obter_nome_pf(cd_pessoa_responsavel) nm_responsavel,
	obter_data_extenso(sysdate,'0') ds_data,
    
    (select obter_nome_pf(CD_PESSOA_RESP)
    from SETOR_ATENDIMENTO 
    where CD_SETOR_ATENDIMENTO in (23)) nm_resposavel_spp,
    (select obter_dados_pf(CD_PESSOA_RESP,'CPF')
    from SETOR_ATENDIMENTO where CD_SETOR_ATENDIMENTO in (23)) cpf_resposavel_spp,
    
    (select obter_nome_pf(CD_PESSOA_RESP)
    from SETOR_ATENDIMENTO 
    where CD_SETOR_ATENDIMENTO in (5)) NM_RESPOSAVEL_FAT,
    (select obter_dados_pf(CD_PESSOA_RESP,'CPF')
    from SETOR_ATENDIMENTO where CD_SETOR_ATENDIMENTO in (5)) cpf_resposavel_FAT,
    
    (select obter_nome_pf(CD_PESSOA_RESP)
    from SETOR_ATENDIMENTO 
    where CD_SETOR_ATENDIMENTO in (101)) nm_resposavel_comerc,
    (select obter_dados_pf(CD_PESSOA_RESP,'CPF')
from SETOR_ATENDIMENTO where CD_SETOR_ATENDIMENTO in (101)) cpf_resposavel_comerc
from	
	atendimento_paciente
where 	
	nr_atendimento = :nr_atendimento
	and Obter_Convenio_Atendimento(nr_atendimento) = 2--ipe

%NM_RESPOSAVEL_FAT%             %CPF_RESPOSAVEL_FAT%   n.003.165.210-78
%NM_RESPOSAVEL_COMERC%          %CPF_RESPOSAVEL_COMERC%   
%NM_RESPOSAVEL_SPP%             %CPF_RESPOSAVEL_SPP%
    
    
1455
CATE - 214 HCB - Autorização convênio IPERGS PA
CATE - 3583 HCB -  HCB - Autorização convênio IPERGS
-- EXEMPLO 2 DE COMO PODERIA SER AJUSTADO 
SELECT 
    a.nm_paciente,
    a.nr_cpf,
    a.ds_end,
    a.nm_responsavel,
    a.ds_data,
    b.campo,
    b.cpf,
    b.CD_PESSOA_RESP
FROM
    (
        SELECT 
            obter_nome_pf(cd_pessoa_fisica) AS nm_paciente,
            obter_dados_pf(cd_pessoa_fisica,'CPF') AS nr_cpf,
            obter_compl_pf(cd_pessoa_fisica,1,'E') AS ds_end,
            obter_nome_pf(cd_pessoa_responsavel) AS nm_responsavel,
            obter_data_extenso(sysdate,'0') AS ds_data
        FROM	
            atendimento_paciente
        WHERE 	
            nr_atendimento = :nr_atendimento
    ) a,
    /* Subquery B */
    (
        SELECT  
            CD_PESSOA_RESP AS cd_pessoa_resp,
            OBTER_NOME_PF(CD_PESSOA_RESP) AS campo,
            obter_dados_pf(CD_PESSOA_RESP,'CPF') AS cpf
        FROM 
            SETOR_ATENDIMENTO 
        WHERE 
            CD_SETOR_ATENDIMENTO = 75
    ) b --AMB.EXTERNO












select * from TEXTO_PADRAO
select * from tabela_macro


select * from macro_prontuario --Esse aqui macro do prontuário




select *
from MATERIAL
where CD_MATERIAL in(90,58491,56929,943)

select CD_MATERIAL,DS_MATERIAL
from MATERIAL

select Obter_Desc_Material(a.CD_MATERIAL),
a.cd_material_convenio 
from material_atend_paciente a where a.nr_interno_conta =3137714

select CD_MATERIAL,substr(obter_desc_material(cd_material),1,254),VL_MATERIAL,VL_UNITARIO,CD_MATERIAL_CONVENIO
from material_atend_paciente 
where nr_atendimento = 2040059
and CD_MATERIAL_CONVENIO in('0136540','49532715','40100308','49131010','10483900','60023384')

select *
from material_atend_paciente 
where nr_atendimento = 2040059



SELECT PAGING.*,
    ROWNUM RecNo
FROM (
        select a.*,
            to_char(dt_alteracao, 'dd/mm/yyyy hh24:mi:ss') DT_ALTERACAO_GRID,
            substr(obter_valor_dominio(1620, ie_alteracao), 1, 100) DS_ALTERACAO,
            substr(obter_nome_pf(cd_pessoa_fisica), 1, 60) NM_PESSOA_FISICA,
            substr(ds_observacao, 1, 255) DS_OBSERVACAO_GRID,
            decode(nr_seq_item_sae,null,obter_data_inicio_prescr(nr_prescricao),to_date(    obter_dados_prescr_enf(nr_prescricao, 'I'),    'dd/mm/yyyy hh24:mi:ss')
            ) DT_INICIO_PRESCR,
            decode(nr_seq_item_sae,null,obter_data_validade_prescr(nr_prescricao),to_date(    obter_dados_prescr_enf(nr_prescricao, 'T'),    'dd/mm/yyyy hh24:mi:ss')
            ) DT_VALIDADE_PRESCR,
            substr( subst_ponto_virgula_adic_zero(obter_qt_dose_comp(nr_sequencia, qt_dose_adm)), 1, 20
            ) QT_DOSE_GRID,
            substr( obter_desc_qualidade_refeicao(nr_seq_qualidade), 1, 255
            ) DS_QUALIDADE,
            substr(obter_nome_pf(cd_medico_solic), 1, 255) DS_PESSOA_FISICA,(
                select substr(max(ds_motivo), 1, 30) ds
                from motivo_suspensao_prescr
                where nr_sequencia = nr_seq_motivo_susp
            ) DS_MOTIVO_SUSP,
            substr(
                obter_desc_motivo_interrupcao(nr_seq_motivo),
                1,
                255
            ) DS_MOTIVO_EVENTO,
            substr(
                obter_desc_motivo_dispensacao(nr_seq_motivo_disp),
                1,
                255
            ) DS_MOTIVO_DISP,
            SUBSTR(
                obter_descricao_procedimento(cd_procedimento, ie_origem_proced),
                1,
                200
            ) DS_TAMANHO_PROCED,
            obter_data_assinatura_digital(NR_SEQ_ASSINATURA) DT_ASSINATURA,
            substr(obter_desc_funcao(cd_funcao), 1, 255) DS_FUNCAO,
            SUBSTR(obter_data_utc(DT_ATUALIZACAO, 'HV'), 1, 200) DS_REGISTRO_UTC,
            SUBSTR(obter_data_utc(DT_ALTERACAO, 'HV'), 1, 200) DS_EVENTO_UTC,
            nvl(
                to_char(dt_hor_acm_sn, 'dd/mm/yyyy hh24:mi:ss'),
                substr(
                    plt_obter_dados_hor_item(
                        nvl(
                            nvl(
                                nvl(
                                    nvl(nr_seq_horario, nr_seq_horario_proc),
                                    nr_seq_horario_rec
                                ),
                                nr_seq_horario_dieta
                            ),
                            nr_seq_horario_sae
                        ),
                        ie_tipo_item,
                        'H'
                    ),
                    1,
                    19
                )
            ) DS_HORARIO,
            substr(
                obter_se_hor_vigente_prescr(
                    to_date(
                        nvl(
                            to_char(dt_hor_acm_sn, 'dd/mm/yyyy hh24:mi:ss'),
                            substr(
                                obter_dados_hor_item_prescr(
                                    nvl(
                                        nvl(
                                            nvl(
                                                nvl(nr_seq_horario, nr_seq_horario_proc),
                                                nr_seq_horario_rec
                                            ),
                                            nr_seq_horario_dieta
                                        ),
                                        nr_seq_horario_sae
                                    ),
                                    ie_tipo_item,
                                    'H'
                                ),
                                1,
                                19
                            )
                        ),
                        'dd/mm/yyyy hh24:mi:ss'
                    ),
                    nr_prescricao
                ),
                1,
                1
            ) IE_REAPRAZAR_VALIDO,
            substr(
                obter_info_prescr_mat_alt(nr_sequencia, 'nr_seq_motivo_adm'),
                1,
                255
            ) DS_MOTIVO_ADM,
(
                select obter_evento_topo_lat(nr_sequencia)
                from dual
            ) DS_TOPO_LAT,
(
                select max(Obter_Via_Aplicacao(b.ie_via_aplicacao, 'D'))
                from prescr_mat_alteracao_comp b
                where b.nr_sequencia_prescr = a.nr_sequencia
            ) DS_VIA_APLICACAO,
            decode(
                ie_tipo_item,
                'M',
                obter_desc_material(cd_item),
                ''
            ) DS_ITEM
        from PRESCR_MAT_ALTERACAO a
        Where 1 = 1
            and nr_atendimento = '2043387'
            and ie_tipo_item = 'M'
            and (
                (cd_item = '1400')
                or (
                    (ie_tipo_item = 'R')
                    and nvl(
                        replace(
                            replace(cd_item, chr(10), '#@#10#@'),
                            chr(13),
                            '#@#13#@'
                        ),
                        'XPTO'
                    ) = nvl('1400', 'XPTO')
                )
                or (
                    (ie_tipo_item = 'R')
                    and (cd_item is null)
                    and (
                        exists (
                            select 1
                            from prescr_recomendacao b
                            where a.nr_prescricao = b.nr_prescricao
                                and a.nr_seq_recomendacao = b.nr_sequencia
                                and b.cd_intervalo = '6'
                        )
                    )
                )
            )
            and (
                (
                    (nvl(ie_mostra_adep, 'S') = 'S')
                    or (
                        (ie_mostra_adep = 'N')
                        and (ie_alteracao = 11)
                    )
                )
                or (nvl('S', 'S') = 'S')
            )
            and (
                (nvl(qt_dose_original, 0) = 0)
                or (ie_tipo_item in ('D', 'DE'))
                or (qt_dose_original = '1')
            )
            and nvl(nr_seq_proc_interno, 0) = 0
            and (
                (CD_UM_DOSE_ADM is null)
                or (ie_alteracao = 3)
                or (CD_UM_DOSE_ADM = 'cp')
            )
            and (nvl(nr_agrupamento, 0) = 0)
            and (nvl(ie_acm_sn, 'N') = 'N')
            and (nr_prescricao in (3628837))
            and (
                (
                    (ie_tipo_item <> 'IAG')
                    or (nr_seq_horario is null)
                )
                or exists (
                    select 1
                    from prescr_mat_hor a,
                        prescr_material b
                    where a.nr_prescricao = b.nr_prescricao
                        and b.nr_sequencia = a.nr_seq_material
                        and a.nr_sequencia = nr_seq_horario
                        and b.cd_intervalo = '6'
                )
            )
            and (
                (ds_observacao_item is null)
                or nvl(
                    replace(
                        replace(
                            replace(ds_observacao_item, chr(10), '#@#10#@'),
                            chr(13),
                            '#@#13#@'
                        ),
                        chr(34),
                        '#@#34#@'
                    ),
                    'XPTO'
                ) = nvl('XPTO', 'XPTO')
            )
            and (
                nr_seq_prescricao = 0
                or 0 = 0
            )
        Order by NR_SEQUENCIA desc,
            DT_ATUALIZACAO_NREC desc
    ) PAGING










// ---------- SQL original ------------ \\\
select a.*,
    SUBSTR( Obter_Desc_Expressao(CD_EXP_PARAMETRO, DS_PARAMETRO), 1, 254) DS_PARAMETRO_FUNC,
    substr(obter_desc_expressao(cd_exp_observacao, ds_observacao),1,4000) DS_EXP_OBSERVACAO,
    substr(obter_desc_expressao(cd_exp_observacao), 1, 255) DS_OBSERVACAO_GRID,
    SUBSTR(Obter_Desc_Expressao(CD_EXP_DEPENDENCIA, DS_DEPENDENCIA),1,254 ) DS_DEPENDENCIA_FUNC,
    substr(DS_OBSERVACAO_CLIENTE, 1, 255) DS_OBS_CLIENTE_GRID
from FUNCAO_PARAMETRO a
Where CD_FUNCAO = :CD_FUNCAO
    and cd_funcao = -1
Order by SUBSTR( Obter_Desc_Expressao(CD_EXP_PARAMETRO, DS_PARAMETRO), 1, 254 ) // / ---------- SQL substituído ---------- \\\
select a.*,
    SUBSTR( Obter_Desc_Expressao(CD_EXP_PARAMETRO, DS_PARAMETRO), 1, 254) DS_PARAMETRO_FUNC,
    substr( obter_desc_expressao(cd_exp_observacao, ds_observacao), 1, 4000) DS_EXP_OBSERVACAO,
    substr(obter_desc_expressao(cd_exp_observacao), 1, 255) DS_OBSERVACAO_GRID,
    SUBSTR(Obter_Desc_Expressao(CD_EXP_DEPENDENCIA, DS_DEPENDENCIA),1,254 ) DS_DEPENDENCIA_FUNC,
    substr(DS_OBSERVACAO_CLIENTE, 1, 255) DS_OBS_CLIENTE_GRID
from FUNCAO_PARAMETRO a
Where CD_FUNCAO = :CD_FUNCAO
    and cd_funcao = -1
Order by SUBSTR(Obter_Desc_Expressao(CD_EXP_PARAMETRO, DS_PARAMETRO),1,254)




--Modelo que remove todo e qulquer caracter especial que usuário registrar
TRANSLATE(HCB_OBTER_ITENS_GASO(A.NR_PRESCRICAO,c.nr_seq_gasoterapia, SUBSTR(to_char(c.dt_horario,'dd/mm/yyyy hh24:mi:ss'),12,2),1,1),'âàãáÁÂÀÃéêÉÊíÍóôõÓÔÕüúÜÚÇç','aaaaAAAAeeEEiIoooOOOuuUUCc') med1,



--exemplo de procedure e ponteiros
-----
Procedure
4/4 TISS - Guia de Resumo de Internação          → PROCEDURE = TISS_GERAR_W_RESUMO_INT
3/4 3.0 - TISS - Guia de outras despesas (Anexo) → PROCEDURE = TISS_GERAR_W_GUIA_OUTRAS_DESP
2/4 V.3.0 - TISS - Guia de Honorário Individual  → PROCEDURE = TISS_GERAR_W_GUIA_HONORARIO
1/4  - Conta Paciente Padrão

cursor c01 is
select	
	a.nr_sequencia,
	b.dt_entrada,
	b.dt_alta,
	b.nr_atendimento,	
	a.nr_interno_conta,
	a.dt_emissao_guia
from	tiss_conta_guia a,
	tiss_conta_atend b
where	a.nr_interno_conta	= b.nr_interno_conta
and	a.nr_interno_conta	= nr_interno_conta_p
and	a.ie_tiss_tipo_guia	= '6'
union
select	a.nr_sequencia,
	b.dt_entrada,
	b.dt_alta,
	b.nr_atendimento,
	a.nr_interno_conta,
	a.dt_emissao_guia
from
	tiss_conta_guia a,
	TISS_PROTOCOLO_GUIA c,
	tiss_conta_atend b
where	a.nr_interno_conta	= b.nr_interno_conta
and	c.nr_sequencia		= a.nr_seq_prot_guia
and	c.nr_seq_protocolo	= nr_seq_protocolo_p
and	a.ie_tiss_tipo_guia	= '6';

-------------------------------------
open c01;
		loop
		fetch c01 into
			nr_seq_conta_guia_w,
			dt_entrada_w,
			dt_alta_w,
			nr_atendimento_w,
			nr_interno_conta_w,
			dt_emissao_guia_w;
		exit when c01%notfound;

			select	max(to_number(obter_clinica_atend(nr_atendimento_w, 'C')))
			into	ie_clinica_w
			from	dual;

			nr_seq_apresentacao_w	:= 0;
			qt_proc_guia_w 		:= 0;
			nr_seq_apres_partic_w	:= 0;

			select	max(ie_tipo_atendimento)
			into	ie_tipo_atendimento_w
			from	atendimento_paciente
			where	nr_atendimento		= nr_atendimento_w;

			select	max(cd_categoria_parametro)
			into	cd_categoria_conv_w
			from	conta_paciente
			where	nr_interno_conta	= nr_interno_conta_w;






SELECT distinct
    a.nr_atendimento nr_atend2,
    a.NR_PRESCRICAO nr_presc2,
    b.dt_entrada,
    b.nm_paciente,
    to_char(b.dt_nascimento, 'dd/mm/yyyy') dt_nascimento,
    b.ds_convenio,
    b.cd_convenio convenio,
    b.ds_sexo,
    b.cd_unidade,
    obter_nome_setor(a.cd_setor_atendimento)  ds_setor_atendimento,
    a.dt_primeiro_horario,
    a.cd_setor_atendimento
 
FROM
    atendimento_paciente_v b,
    prescr_medica          a,
    prescr_procedimento c
WHERE
    a.dt_liberacao BETWEEN :dt_inicial AND fim_dia(:dt_final)
    AND a.nr_atendimento = b.nr_atendimento
    and a.DT_LIBERACAO IS NOT NULL
    and c.NR_PRESCRICAO = a.NR_PRESCRICAO
    and b.nr_atendimento = obter_atendimento_prescr(c.nr_prescricao)
    and CD_PROCEDIMENTO IN (
        27020045,
        27020010,
        27020053,
        27020061,
        27020070,
        27020096,
        27040038,
        27040151,
        27040208,
        27040224,
        27040283,
        27040305,
        27040348,
        27040364,
        27040380,
        27040399,
        27040402,
        27040414,
        27040429,
        27040437,
        27040461,
        27040518,
        40401014,
        40402037,
        40402045,
        40402061,
        40402070,
        40402088,
        40402096,
        40402100,
        40402118,
        40403173,
        40403181,
        40403262,
        40403688,
        95270027,
        95270035,
        95270043,
        212010026,
        212010034,
        212010050,
        212020013,
        301100012,
        306010011,
        306010038,
        306020041,
        306020068,
        306020076,
        306020084,
        306020092,
        306020106,
        306020130,
        306020149
    )
--@SQL_WHERE
order by 4


SELECT * FROM  atendimento_paciente_v WHERE NR_ATENDIMENTO = 2079816

SELECT * FROM  OCUPACAO_HOSPITALAR

SELECT * FROM prescr_medica A WHERE A.NR_ATENDIMENTO = 2079816 AND NR_PRESCRICAO = 3709445

SELECT SUBSTR(Obter_Desc_Prescr_Proc(b.CD_PROCEDIMENTO, 1, b.nr_seq_proc_interno), 1, 200),B.* 
FROM  prescr_procedimento B WHERE B.NR_PRESCRICAO = 3709445







/*sql etiqueta que define número etiquetas*/

SELECT 
:DS_TIPO_PRODUTO tipo_produto
FROM DUAL,
(SELECT 1 FROM ALL_TABLES WHERE ROWNUM<=:QTD_COPIA)

/*Programação EPL*/
Q25
q831
rN
S1
D7
ZT
JF
R 2,0
N
A5,80,0,1,9,9,N,"&tipo_produto"
P&nr_etiquetas
FE






/*bizu para saber nome atributo e que dado é*/
SELECT
    obter_dado_atributo('ATENDIMENTO_PACIENTE', 'IE_TIPO_ATENDIMENTO')
FROM
    dual
----------------------------
SELECT
    obter_dados_atributo('DT_OCORRENCIA', 'SUS_APAC_UNIF', 'LB')
FROM
    dual
    







/***
PEGA ATENDIMENTO →  NM_USUÁRIO

***/
 obter_usuario_atend(D.nr_atendimento) USUARIO




/*sql soltos*/
SELECT
CASE
WHEN TOTAL > 100 THEN 100
ELSE TOTAL END TOTAL
from
( (SELECT
       ENCERRADAS.TOTAL AS ENCERRADAS,
       ABERTAS.TOTAL AS ABERTAS,
       (ENCERRADAS.TOTAL)/(ABERTAS.TOTAL)*100 AS RESULTADO,
       (ENCERRADAS.TOTAL*100)/(ABERTAS.TOTAL) AS RESULTADO1
    FROM
    (   --TOTAL OS ABERTAS
       select  COUNT(x.nr_sequencia)TOTAL
       from	man_ordem_servico x 
       WHERE X.IE_TIPO_ORDEM =  2 
       AND X.NR_GRUPO_TRABALHO =  22 
       AND X.NR_GRUPO_PLANEJ = 14
       and x.NR_SEQ_ESTAGIO = 41
       AND X.NR_SEQ_TIPO_ORDEM = 3
       AND X.DT_FIM_REAL BETWEEN :DT_INICIAL AND FIM_DIA(:DT_FINAL)
    )/
    (  --TOTAL DE OS ENCERRADAS
       select  COUNT(x.nr_sequencia)TOTAL
       from	man_ordem_servico x 
       WHERE X.IE_TIPO_ORDEM =  2 
       AND X.NR_GRUPO_TRABALHO =  22 
       AND X.NR_GRUPO_PLANEJ = 14
       and x.NR_SEQ_ESTAGIO not in (92)
       AND X.NR_SEQ_TIPO_ORDEM = 3
       AND X.DT_ORDEM_SERVICO BETWEEN :DT_INICIAL AND FIM_DIA(:DT_FINAL)))*100 TOTAL
FROM DUAL)



NX 400 = 15-40 = 2,67 à cada uma volta do pinhão a roda gira 2,67
CBX250 = 13-37 = 2,85 à cada uma volta do pinhão a roda gira 2,85

Maior torque e força RELAÇÃO↓ - VELOCIDADE + TOQUE
Pinhões com menos dentes e coroas com mais dentes 
aumentam o torque e a força em baixas rotações, 
ideal para trilhas e subidas íngremes.

Maior velocidade final = RELAÇÃO ALTA↑ MAIOR VELOCIDADE - TORQUE 
Pinhões com mais dentes e coroas com menos 
dentes aumentam a velocidade final da moto, 
em detrimento da força em baixas rotações, 
ideal para uso em rodovias.

630MM A 640MM

180/55 R17
 180/10MM PARA CM = 18CM LARGURA 
 55 CM ALTURA

 Tamanho do pneu interfere diretamente na rotação do motor em 
 velocidade final 
 





SELECT
DECODE(O.IE_CLASSIFICACAO, 'D', 'Dúvida', 'E', 'Defeito','S', 'Solicitação','T', 'Sugestão') DS_CLASSIFICACAO,
O.TOTAL_CLASSIFICACAO
FROM
(
    select 
    count(x.IE_CLASSIFICACAO) TOTAL_CLASSIFICACAO,
    x.IE_CLASSIFICACAO
    from	
          man_ordem_servico x 
    where 1=1 
    and x.IE_CLASSIFICACAO mm/yy
    and x.ie_status_ordem =  '3'   
    and x.nr_seq_estagio in (select nr_sequencia  from man_estagio_processo    where ie_acao = 1) 
    and x.nr_grupo_trabalho =  :NR_GRUPO_TRABALHO 
    and x.nr_seq_wheb is null  
    and (x.dt_fim_real between :DT_INICIAL and fim_dia(:DT_FINAL))
    group by x.IE_CLASSIFICACAO
) O 
 ORDER BY DS_CLASSIFICACAO ASC



select  
' ' || SUBSTR(AVAL(NR_SEQUENCIA,3065),1,255) ORIGEM,
' ' || SUBSTR(AVAL(NR_SEQUENCIA,3066),1,255) DESTINO,
' ' || SUBSTR(AVAL(NR_SEQUENCIA,3068),1,255) MOTIVO_INT,
SUBSTR(AVAL(NR_SEQUENCIA,3109),1,255) MORSE,
DECODE(AVAL(NR_SEQUENCIA,3074),'S','X','') NAO_APLICA_MORSE,
DECODE(AVAL(NR_SEQUENCIA,3069),'S','X','') ALERGIA_NAO,
DECODE(AVAL(NR_SEQUENCIA,3075),'S','X','') ALERGIA_SIM,
' ' || SUBSTR(AVAL(NR_SEQUENCIA,3076),1,255) ALERGIA_QUAL,
DECODE(AVAL(NR_SEQUENCIA,3079),'S','X','') BRONCO_SIM,
DECODE(AVAL(NR_SEQUENCIA,3080),'S','X','') BRONCO_NAO,
DECODE(AVAL(NR_SEQUENCIA,3085),'S','X','') ISOLAMENTO_NAO,
DECODE(AVAL(NR_SEQUENCIA,3086),'S','X','') ISOLAMENTO_SIM,
' ' || SUBSTR(AVAL(NR_SEQUENCIA,3087),1,255) ISOLAMENTO_QUAL,
' ' || SUBSTR(AVAL(NR_SEQUENCIA,3089),1,255) ECA,
DECODE(AVAL(NR_SEQUENCIA,3090),'S','X','') ECA_NAO_APLICA,
' ' || SUBSTR(AVAL(NR_SEQUENCIA,3070),1,255) MEWS,
DECODE(AVAL(NR_SEQUENCIA,3077),'S','X','') MEWS_NAO_APLICA,
' ' || SUBSTR(AVAL(NR_SEQUENCIA,3081),1,255) PEWS,
DECODE(AVAL(NR_SEQUENCIA,3082),'S','X','') PEWS_NAO_APLICA,
SUBSTR(AVAL(NR_SEQUENCIA,3113),1,255) || ' mm/Hg' PA,
SUBSTR(AVAL(NR_SEQUENCIA,3114),1,255) || ' bpm' FC,
SUBSTR(AVAL(NR_SEQUENCIA,3112),1,255) || ' %' SAT_O2,
SUBSTR(AVAL(NR_SEQUENCIA,3111),1,255) || ' ipm' FR,
SUBSTR(AVAL(NR_SEQUENCIA,3083),1,255) || ' C°' TEMPERATURA,
DECODE(AVAL(NR_SEQUENCIA,3116),'S','X','') AA,
DECODE(AVAL(NR_SEQUENCIA,3117),'S','X','') O2_ATRAVES,
' ' || SUBSTR(AVAL(NR_SEQUENCIA,3118),1,255) DS_O2_ATRAVES,
DECODE(AVAL(NR_SEQUENCIA,3120),'S','X','') TQT_SIM,
DECODE(AVAL(NR_SEQUENCIA,3121),'S','X','') TQT_NAO,
DECODE(AVAL(NR_SEQUENCIA,3123),'S','X','') VO,
DECODE(AVAL(NR_SEQUENCIA,3124),'S','X','') SNE_SNG,
DECODE(AVAL(NR_SEQUENCIA,3125),'S','X','') DIETAS_OUTRO,
' ' || SUBSTR(AVAL(NR_SEQUENCIA,3126),1,255) DS_DIETAS_OUTRO,
DECODE(AVAL(NR_SEQUENCIA,3128),'S','X','') AVP,
' ' || SUBSTR(AVAL(NR_SEQUENCIA,3129),1,255) AVP_LOCAL,
DECODE(AVAL(NR_SEQUENCIA,3130),'S','X','') AVC,
' ' || SUBSTR(AVAL(NR_SEQUENCIA,3131),1,255) AVC_LOCAL,
DECODE(AVAL(NR_SEQUENCIA,3060),'S','X','') FAV,
' ' || SUBSTR(AVAL(NR_SEQUENCIA,3061),1,255) FAV_LOCAL,
DECODE(AVAL(NR_SEQUENCIA,3096),'S','X','') CURATIVO_NAO,
DECODE(AVAL(NR_SEQUENCIA,3097),'S','X','') CURATIVO_SIM,
' ' || SUBSTR(AVAL(NR_SEQUENCIA,3098),1,255) CURATIVO_LOCAL,
DECODE(AVAL(NR_SEQUENCIA,3092),'S','X','') DRENOS_NAO,
DECODE(AVAL(NR_SEQUENCIA,3093),'S','X','') DRENOS_SIM,
' ' || SUBSTR(AVAL(NR_SEQUENCIA,3094),1,255) DRENOS_QUAL,
DECODE(AVAL(NR_SEQUENCIA,3133),'S','X','') ESPONTANEA,
DECODE(AVAL(NR_SEQUENCIA,3134),'S','X','') SVD,
DECODE(AVAL(NR_SEQUENCIA,3135),'S','X','') ELIM_OUTRO,
' ' || SUBSTR(AVAL(NR_SEQUENCIA,3136),1,255) DS_ELIM_OUTRO,
DECODE(AVAL(NR_SEQUENCIA,3100),'S','X','') VIGENTE_SIM,
DECODE(AVAL(NR_SEQUENCIA,3101),'S','X','') VIGENTE_NAO,
DECODE(AVAL(NR_SEQUENCIA,3139),'S','X','') LIBERADA_SIM,
DECODE(AVAL(NR_SEQUENCIA,3140),'S','X','') LIBERADA_NAO,
DECODE(AVAL(NR_SEQUENCIA,3142),'S','X','') MEDICACAO_SIM,
DECODE(AVAL(NR_SEQUENCIA,3143),'S','X','') MEDICACAO_NAO,
DECODE(AVAL(NR_SEQUENCIA,3103),'S','X','') PENDENCIA_NAO,
DECODE(AVAL(NR_SEQUENCIA,3104),'S','X','') PENDENCIA_SIM,
' ' || SUBSTR(AVAL(NR_SEQUENCIA,3105),1,255) PENDENCIA_QUAL,
DECODE(AVAL(NR_SEQUENCIA,3145),'S','X','') ACOMPANHANTE_SIM,
DECODE(AVAL(NR_SEQUENCIA,3146),'S','X','') ACOMPANHANTE_NAO,

' ' || SUBSTR(AVAL(NR_SEQUENCIA,3106),1,255) OBSERVACAO,
' ' || SUBSTR(AVAL(NR_SEQUENCIA,3107),1,255) NM_ORIGEM,
' ' || SUBSTR(AVAL(NR_SEQUENCIA,3108),1,255) NM_DESTINO,
' ' || SUBSTR(AVAL(NR_SEQUENCIA,3151),1,255) RETORNO,
' ' || SUBSTR(AVAL(NR_SEQUENCIA,3152),1,255) TECNICO_ORIGEM,
' ' || SUBSTR(AVAL(NR_SEQUENCIA,3153),1,255) TECNICO_DESTINO
from    
    MED_AVALIACAO_PACIENTE a
where  
    a.NR_SEQUENCIA = :nr_seq_avaliacao_p


SELECT CASE
        WHEN TOTAL > 100 THEN 100
        ELSE TOTAL
    END TOTAL
from (
        (
            SELECT ENCERRADAS.TOTAL AS ENCERRADAS,
                ABERTAS.TOTAL AS ABERTAS,
                (ENCERRADAS.TOTAL) /(ABERTAS.TOTAL) * 100 AS RESULTADO,
                (ENCERRADAS.TOTAL * 100) /(ABERTAS.TOTAL) AS RESULTADO1
            FROM (
                    --TOTAL OS ABERTAS
                    select COUNT(x.nr_sequencia) TOTAL
                    from man_ordem_servico x
                    WHERE X.IE_TIPO_ORDEM = 2
                        AND X.NR_GRUPO_TRABALHO = 22
                        AND X.NR_GRUPO_PLANEJ = 14
                        and x.NR_SEQ_ESTAGIO = 41
                        AND X.NR_SEQ_TIPO_ORDEM = 3
                        AND X.DT_FIM_REAL BETWEEN :DT_INICIAL AND FIM_DIA(:DT_FINAL)
                ) ABERTAS,
                (
                    --TOTAL DE OS ENCERRADAS
                    select COUNT(x.nr_sequencia) TOTAL
                    from man_ordem_servico x
                    WHERE X.IE_TIPO_ORDEM = 2
                        AND X.NR_GRUPO_TRABALHO = 22
                        AND X.NR_GRUPO_PLANEJ = 14
                        and x.NR_SEQ_ESTAGIO not in (92)
                        AND X.NR_SEQ_TIPO_ORDEM = 3
                        AND X.DT_ORDEM_SERVICO BETWEEN :DT_INICIAL AND FIM_DIA(:DT_FINAL)
                )
        ) * 100 TOTAL
        FROM DUAL
    )

/*sql evoluçõe*/
select
  A.CD_EVOLUCAO,
  a.dt_evolucao,
	a.ds_evolucao,
	a.dt_liberacao,
	b.nm_paciente,
	b.dt_nascimento,
	b.cd_setor_atendimento,
	b.cd_unidade,
	b.nr_atendimento,
	b.ds_setor_atendimento,
	a.nm_usuario,
	DECODE(c.ds_codigo_prof, NULL, '',DECODE(a.ie_tipo_evolucao, 1, 'CRM ', 5, 'CRP ', 8, 'CRFª ', 11,                 'CRESITO ', 10, 'CRF ', 7, 'CRN ', 4, 'CRN ', 'COREN ') || c.ds_codigo_prof) ds_codigo_prof,
	SUBSTR(obter_valor_dominio(72, a.ie_tipo_evolucao),1,60) ds_tipo_evolucao,
	SUBSTR(obter_desc_espec_medica(a.cd_especialidade),1,40) ds_especialidade,
	DECODE(a.ie_evolucao_clinica,'P',SUBSTR(obter_valor_dominio(1221, a.ie_evolucao_clinica),1,60) ||' 		à' ,'R',SUBSTR(obter_valor_dominio(1221, a.ie_evolucao_clinica),1,60) ||' da' , 			SUBSTR(obter_valor_dominio(1221, a.ie_evolucao_clinica),1,60)) ds_evolucao_clinica,
	b.ds_idade,
	substr(Obter_Dias_Internacao(b.nr_atendimento),1,255) || 'd' qt_dias_inter
FROM	pessoa_fisica c,
	Atendimento_paciente_v b,
	evolucao_paciente_lib_v a
WHERE	a.dt_evolucao BETWEEN :dt_inicial AND :dt_final
  AND	a.nr_atendimento = b.nr_atendimento
  AND	a.cd_pessoa_fisica	= c.cd_pessoa_fisica
  AND	((b.cd_setor_atendimento = :cd_setor_atendimento) OR (0 = :cd_setor_atendimento))
  and	((a.IE_EVOLUCAO_CLINICA = :CD_TIPO_EVOLUCAO) or ('0' = :CD_TIPO_EVOLUCAO))
  and B.DT_ALTA is null 
  //---and A.CD_EVOLUCAO = (select max(cd_evolucao) from evolucao_paciente_lib_v where nr_atendimento = A.NR_ATENDIMENTO group by NR_ATENDIMENTO)--- \\
  order by	B.DS_SETOR_ATENDIMENTO,	B.CD_UNIDADE,	B.NM_PACIENTE,	a.DT_EVOLUCAO






/*SQL RELATÓRIOS APACS*/



SELECT  d.NR_APAC,
        Obter_Dados_Atendimento	(d.NR_ATENDIMENTO,'NP')ds_nome,
        Obter_Dados_Atendimento	(d.NR_ATENDIMENTO,'CP')CD_2,
        d.DT_INICIO_VALIDADE,
        d.DT_FIM_VALIDADE,
        D.DT_COMPETENCIA,
        d.NR_ATENDIMENTO atend_2,
        CASE
        WHEN EXTRACT(MONTH FROM D.DT_COMPETENCIA) = EXTRACT(MONTH FROM D.DT_INICIO_VALIDADE) THEN 'Início'
        WHEN EXTRACT(MONTH FROM D.DT_COMPETENCIA) = EXTRACT(MONTH FROM D.DT_INICIO_VALIDADE) + 1 THEN 'Continuidade'
        WHEN EXTRACT(MONTH FROM D.DT_COMPETENCIA) = EXTRACT(MONTH FROM D.DT_INICIO_VALIDADE) + 2 THEN 'Renovação'
        ELSE 'Outro'
        END AS fase  
FROM
    sus_apac_unif d
WHERE
  D.DT_INICIO_VALIDADE BETWEEN :dt_inicio AND :dt_final
--AND NR_APAC =  4324200450010
AND to_char(d.dt_competencia, 'mm/yyyy') = :dt_competencia --PEGA APENAS COM DATA FIM DE VALIDADE
order by 1,2,6





SELECT  d.NR_APAC,
        Obter_Dados_Atendimento	(d.NR_ATENDIMENTO,'NP')ds_nome,
        Obter_Dados_Atendimento	(d.NR_ATENDIMENTO,'CP')CD_2,
        d.DT_INICIO_VALIDADE,
        d.DT_FIM_VALIDADE,
        D.DT_COMPETENCIA,
        d.NR_ATENDIMENTO atend_2,
        CASE
        WHEN EXTRACT(MONTH FROM D.DT_COMPETENCIA) = EXTRACT(MONTH FROM D.DT_INICIO_VALIDADE) THEN 'Início'
        WHEN EXTRACT(MONTH FROM D.DT_COMPETENCIA) = EXTRACT(MONTH FROM D.DT_INICIO_VALIDADE) + 1 THEN 'Continuidade'
        WHEN EXTRACT(MONTH FROM D.DT_COMPETENCIA) = EXTRACT(MONTH FROM D.DT_INICIO_VALIDADE) + 2 THEN 'Renovação'
        ELSE 'Outro'
        END AS fase,
        OBTER_DESC_SETOR_ATENDIMENTO(D.NR_ATENDIMENTO),1,50
FROM
    sus_apac_unif d
WHERE
  D.DT_INICIO_VALIDADE BETWEEN :dt_inicio AND :dt_final
--AND NR_APAC =  4324200450010
--AND to_char(d.dt_competencia, 'mm/yyyy') = :dt_competencia --PEGA APENAS COM DATA FIM DE VALIDADE
order by 1,2,6





SELECT X.CD, X.DS
FROM 
(
    SELECT 'I' AS cd, 'Inicio' AS ds FROM DUAL
    UNION ALL
    SELECT 'C' AS cd, 'Continuidade' AS ds FROM DUAL
    UNION ALL
    SELECT 'R' AS cd, 'Renovação' AS ds FROM DUAL
) X

EXTRACT(YEAR FROM d.DT_COMPETENCIA) = EXTRACT(YEAR FROM SYSDATE) -- Condição para o ano atual





SELECT
    bsc_indicador.nr_sequencia,
    bsc_indicador.nm_indicador,
    bsc_indicador.ie_situacao,
    bsc_indicador.ds_indicador,
    bsc_indicador.nm_usuario,
    bsc_indicador.ds_formula,
    bsc_indicador.ie_tipo
FROM
    bsc_indicador
WHERE
    bsc_indicador.nr_sequencia IN ( 484 )
    AND bsc_indicador.ie_situacao = 'A'



/*MODELO INNER JOIN **/
SELECT
    a.nr_prescricao,
    b.DS_HORARIOS,
    b.CD_INTERVALO,
    obter_desc_material(b.cd_material)||' - '||b.cd_material,
    a.dt_prescricao,
    a.nm_usuario,
    a.dt_atualizacao,
    a.nr_atendimento
FROM
    prescr_medica a
INNER JOIN PRESCR_MATERIAL b on a.NR_PRESCRICAO = b.NR_PRESCRICAO 
where nr_atendimento = 2035671
and a.NR_PRESCRICAO = 3627988
and b.cd_material =11750
order by 4

/*REGRA PARA @SQL_WHERE*/

1º Não precisa colocar nada na condição apenas inserir @sql_where
2º @SQL_WHERE deve ficar antes do order by
3º Quando tiver retorno subselect deve  ter where para funcionar 
4º Cuidar tamanho  do atibuto no relatorio apac corta tem 5 digitos iguais




/*exemplo de passagem de parâmetro de uma banda para outra*/
/*BANDA DADOS MÉDICOS*/
select   distinct 
  obter_nome_medico(d.CD_MEDICO_RESPONSAVEL,'n') NM_MEDICO,
  d.CD_MEDICO_RESPONSAVEL MED,
  d.IE_TIPO_APAC  IE_TIPO_APAC2 /*  <- PEGA DAODS DAQUI INSERIDO PELO @SQL_WHERE */
from      SUS_APAC_UNIF        d,
             atendimento_paciente b, 
             ATEND_PACIENTE_UNIDADE a        
where    b.nr_atendimento     = d.nr_atendimento
and      d.DT_FIM_VALIDADE between :dt_inicio and :dt_final
and b.nr_atendimento = a.nr_atendimento
and d.dt_ocorrencia is null
and	to_char(d.dt_competencia,'mm/yyyy')	= :dt_competencia
@SQL_WHERE
order by d.CD_MEDICO_RESPONSAVEL
/*BANDA DADOS APAC*/
select  distinct 
        d.NR_APAC, 
        substr(obter_nome_pf(b.cd_pessoa_fisica),1,255) nome_pf,
        d.CD_PROCEDIMENTO, 
        substr(obter_descricao_procedimento(d.cd_procedimento, d.ie_origem_proced),1,255) DS_procedimento,
        d.DS_SIGLA_ESQUEMA, 
        d.DT_FIM_VALIDADE,
        d.nr_atendimento,
        d.CD_MEDICO_RESPONSAVEL,
        substr(Obter_Valor_Dominio(1092,IE_TIPO_APAC),1,50) ds,
         d.DT_FIM_VALIDADE

from        SUS_APAC_UNIF        d,
            atendimento_paciente b, 
            ATEND_PACIENTE_UNIDADE a        

where    b.nr_atendimento     = d.nr_atendimento
and      d.DT_FIM_VALIDADE between :dt_inicio and :dt_final
and b.nr_atendimento = a.nr_atendimento
and d.dt_ocorrencia is null
and	to_char(d.dt_competencia,'mm/yyyy')	= :dt_competencia
and d.CD_MEDICO_RESPONSAVEL = :MED
and (d.NR_APAC = :NR_APAC or :NR_APAC = 0)
and(d.IE_TIPO_APAC = :IE_TIPO_APAC2 or :IE_TIPO_APAC2 = 0) /*PASSA AQUI O PARÂMETRO DE CIMA */
order by 2




--relatório que é impresso automático pelo snd
SELECT
to_char(b.dt_prescricao,'dd/mm/yyyy') dt_prescricao,
b.nr_atendimento,
b.nr_prescricao,
SUBSTR(OBTER_UNIDADE_ATENDIMENTO(B.NR_ATENDIMENTO,'A','UB') || ' - ' || OBTER_UNIDADE_ATENDIMENTO(B.NR_ATENDIMENTO,'A','UC'),1,50) ||'  REFEICAO: '|| OBTER_VALOR_DOMINIO(99,:DS_REFEICAO) DS_LEITO,
SUBSTR(obter_nome_pf(b.cd_pessoa_fisica),1,100) nm_paciente,
SUBSTR(obter_idade_pf(b.cd_pessoa_fisica, SYSDATE, 'S'),1,50) ds_idade,
SUBSTR(obter_desc_material(a.cd_material),1,100) ds_material,
SUBSTR(obter_desc_via(a.ie_via_aplicacao),1,50) ds_via,
a.qt_dose,
SUBSTR(obter_desc_unid_med(a.cd_unidade_medida),1,50) ds_unid_medida,
SUBSTR(obter_desc_intervalo(a.cd_intervalo),1,50)||' Horario: ' || A.DS_HORARIOS  ds_intervalo,
' Horario: ' || A.DS_HORARIOS DS_HORARIO,
QT_VEL_INFUSAO ||' ml/h' ds_velocidade,
'DN: '||substr(OBTER_DATA_NASCTO_PF(b.CD_PESSOA_FISICA),1,50) DT_NASCTO,
to_char(sysdate, 'DD/MM/YYYY HH24:MM') HR_IMP
FROM	prescr_material a,
prescr_medica b,
material c,
nutricao_produto d
WHERE a.nr_prescricao = b.nr_prescricao
AND a.cd_material = c.cd_material
AND c.cd_material = d.cd_material(+)
AND a.ie_agrupador IN (8,12)
AND ((b.cd_setor_atendimento = :cd_setor_atendimento) or (:cd_setor_atendimento = 0))
AND ((a.nr_prescricao = :nr_prescricao) or (:nr_prescricao = 0))
AND ((b.nr_atendimento = :nr_atendimento) or (:nr_atendimento = 0))
AND ((d.nr_seq_classif = :nr_seq_classif) OR (:nr_seq_classif = 0)) 
AND b.dt_prescricao BETWEEN :dt_inicial AND fim_dia(:dt_final)
AND ((upper(a.ie_via_aplicacao) = :ie_via_aplicacao) or ('0' = :ie_via_aplicacao))
AND IE_SUSPENSO = 'N'
order by nm_paciente, ds_material


A480,175,0,1,1,1,N,"&DT_NASCTO"


/********OS PINGUINHO******/

select *
from PRESCR_DIETA
----------------------------------
select
/*Dieta e código*/
A.cd_dieta,
hcb_obter_descricao_dieta (A.NR_PRESCRICAO)ds_dieta,
obter_inf_dieta_adep(A.nr_prescricao,A.NR_SEQUENCIA,'D'),
/*descrição*/
OBTER_DESC_DIETA(A.cd_dieta) descrisao,
/*checkbox hora especial - hora - 1ºhora */
a.IE_DOSE_ESPEC_AGORA,
a.HR_DOSE_ESPECIAL,
a.HR_PRIM_HORARIO,
/*intervalo via - administração - justificativa*/
a.CD_INTERVALO,
A.IE_VIA_APLICACAO,
A.DS_JUSTIFICATIVA,
/*observaçao*/
A.DS_OBSERVACAO,
/*foi prescrição S ou n*/
obter_se_prescr_dieta(A.nr_prescricao)
from PRESCR_DIETA a,PRESCR_MEDICA b
where  a.NR_PRESCRICAO = b.NR_PRESCRICAO 
and nr_atendimento = 1964385

/*FILTROS ?????*/











/*MODELO ETIQUETA ZEBRA */

select
TO_CHAR('BANCO DE SANGUE - HCB')CABECALHO,
SUBSTR(OBTER_NOME_PF(a.CD_PESSOA_FISICA),1,50)NOME,
'DN: '||OBTER_DATA_NASCTO_PF(a.CD_PESSOA_FISICA) DT_NASCTO,
'SETOR: '||upperUBSTR(OBTER_DESC_SETOR_ATENDIMENTO((Sa.NR_ATENDIMENTO),1,50))||'->'||a.CD_UNIDADE DS_SETOR,
'AT: '||a.NR_ATENDIMENTO ATEND,
'Gerado: '||TO_CHAR(SYSDATE) IMP,
SUBSTR((Obter_Usuario_Ativo),1,150)USU
from   	ATENDIMENTO_PACIENTE_v a
where  	a.NR_ATENDIMENTO = :NR_ATENDIMENTO 

select Obter_Usuario_Ativo from dual




/*MODELO DE SUBSELECT TOP FEITO PELO ALEMON*/
select  x.DT_LIBERACAO DT_LIBERACAO,
        x.setor_presc setor_presc,
        x.nm_medico nm_medico,
        y.ds_procedimento ds_procedimento
from 
(
select  
		A.DT_LIBERACAO DT_LIBERACAO,
		obter_nome_setor(a.cd_setor_atendimento) setor_presc,
        obter_nome_medico (a.cd_medico, 'P') nm_medico
from 	atendimento_paciente_v b,
        prescr_medica a
where  	a.nr_prescricao 	= :nr_prescricao
and   	a.nr_atendimento	= b.nr_atendimento
)x,
(
select 	distinct
	nvl(obter_desc_exame_lab(a.nr_seq_exame,0,a.cd_procedimento,a.ie_origem_proced), b.ds_procedimento) ds_procedimento
from 	prescr_procedimento a,
        usuario_setor_v x,
        procedimento b
where 	a.cd_procedimento      	= b.cd_procedimento
and 	x.cd_setor_atendimento 	= b.cd_setor_exclusivo
--and 	x.nm_usuario           		= :nm_usuario_cor
and	a.cd_setor_atendimento	= 27
and	a.ie_origem_proced		= b.ie_origem_proced
and 	a.nr_prescricao        	= :nr_prescricao
and a.ie_suspenso <> 'S'
)y



/*SETOR*/
SELECT	
    DISTINCT b.CD_SETOR_ATENDIMENTO CD_SETOR_ATENDIMENTO1,
    b.DS_SETOR_ATENDIMENTO
FROM	escala_nrs a, ATENDIMENTO_PACIENTE_v b,DIAGNOSTICO_DOENCA  c
WHERE	
a.NR_ATENDIMENTO = b.NR_ATENDIMENTO
and c.NR_ATENDIMENTO = a.NR_ATENDIMENTO
and b.NR_ATENDIMENTO = b.NR_ATENDIMENTO
and a.DT_LIBERACAO BETWEEN :DT_INICIAL and fim_dia(:DT_FINAL) 
and (b.CD_CONVENIO = :CD_CONVENIO or :CD_CONVENIO = 0)
and (b.CD_SETOR_ATENDIMENTO = :CD_SETOR_ATENDIMENTO or :CD_SETOR_ATENDIMENTO = 0)
and :CD_RELATORIO = 1
AND a.NR_SEQUENCIA = (select max(nr_sequencia)
                      from escala_nrs y 
                      where y.nr_atendimento = a.nr_atendimento)
and c.DT_DIAGNOSTICO = (select max(DT_DIAGNOSTICO)
                   from DIAGNOSTICO_DOENCA  y
                   where y.NR_ATENDIMENTO = c.NR_ATENDIMENTO
                  and y.IE_SITUACAO = 'A')
@SQL_WHERE
order by 2
/*-----------------------------------------------------------*/
/*CONVÊNO*/
SELECT
    DISTINCT b.CD_CONVENIO,
    b.DS_CONVENIO,
b.CD_SETOR_ATENDIMENTO CD_SETOR_ATENDIMENTO2
FROM	escala_nrs a, ATENDIMENTO_PACIENTE_v b,DIAGNOSTICO_DOENCA  c
WHERE	
a.NR_ATENDIMENTO = b.NR_ATENDIMENTO
and c.NR_ATENDIMENTO = a.NR_ATENDIMENTO
and b.NR_ATENDIMENTO = b.NR_ATENDIMENTO
and a.DT_LIBERACAO BETWEEN :DT_INICIAL and fim_dia(:DT_FINAL) 
and (b.CD_CONVENIO = :CD_CONVENIO or :CD_CONVENIO = 0)
and (b.CD_SETOR_ATENDIMENTO = :CD_SETOR_ATENDIMENTO1 or :CD_SETOR_ATENDIMENTO1 = 0)
and :CD_RELATORIO = 1
AND a.NR_SEQUENCIA = (select max(nr_sequencia)
                      from escala_nrs y 
                      where y.nr_atendimento = a.nr_atendimento)
and c.DT_DIAGNOSTICO = (select max(DT_DIAGNOSTICO)
                   from DIAGNOSTICO_DOENCA  y
                   where y.NR_ATENDIMENTO = c.NR_ATENDIMENTO
                  and y.IE_SITUACAO = 'A')
@SQL_WHERE
order by 2
/*-----------------------------------------------------------*/
SELECT	/*RESUMO GERAL*/
    count(a.nr_sequencia)total,
    a.QT_PONTUACAO,
	SUBSTR(Obter_Resul_nrs(a.qt_pontuacao),1,255) ds_pontuacao,
    b.CD_CONVENIO, 
    b.CD_SETOR_ATENDIMENTO CD_SETOR_ATENDIMENTO3
FROM	escala_nrs a, ATENDIMENTO_PACIENTE_v b,DIAGNOSTICO_DOENCA  c
WHERE	
a.NR_ATENDIMENTO = b.NR_ATENDIMENTO
and c.NR_ATENDIMENTO = a.NR_ATENDIMENTO
and b.NR_ATENDIMENTO = b.NR_ATENDIMENTO
and a.DT_LIBERACAO BETWEEN :DT_INICIAL and fim_dia(:DT_FINAL) 
and (b.CD_CONVENIO = :CD_CONVENIO or :CD_CONVENIO = 0)
and (b.CD_SETOR_ATENDIMENTO = :CD_SETOR_ATENDIMENTO2 or :CD_SETOR_ATENDIMENTO2 = 0)
and :CD_RELATORIO = 1
/*CONVÊNO*/
SELECT
    DISTINCT b.CD_CONVENIO,
    b.DS_CONVENIO,
b.CD_SETOR_ATENDIMENTO CD_SETOR_ATENDIMENTO2
FROM	escala_nrs a, ATENDIMENTO_PACIENTE_v b,DIAGNOSTICO_DOENCA  c
WHERE	
a.NR_ATENDIMENTO = b.NR_ATENDIMENTO
and c.NR_ATENDIMENTO = a.NR_ATENDIMENTO
and b.NR_ATENDIMENTO = b.NR_ATENDIMENTO
and a.DT_LIBERACAO BETWEEN :DT_INICIAL and fim_dia(:DT_FINAL) 
and (b.CD_CONVENIO = :CD_CONVENIO or :CD_CONVENIO = 0)
and (b.CD_SETOR_ATENDIMENTO = :CD_SETOR_ATENDIMENTO1 or :CD_SETOR_ATENDIMENTO1 = 0)
and :CD_RELATORIO = 1
AND a.NR_SEQUENCIA = (select max(nr_sequencia)
                      from escala_nrs y 
                      where y.nr_atendimento = a.nr_atendimento)
and c.DT_DIAGNOSTICO = (select max(DT_DIAGNOSTICO)
                   from DIAGNOSTICO_DOENCA  y
                   where y.NR_ATENDIMENTO = c.NR_ATENDIMENTO
                  and y.IE_SITUACAO = 'A')
@SQL_WHERE
order by 2
group by    a.QT_PONTUACAO, 
            SUBSTR(Obter_Resul_nrs(a.qt_pontuacao),1,255),
            b.CD_CONVENIO, 
            b.CD_SETOR_ATENDIMENTO
    
order by 2
/*-----------------------------------------------------------*/
SELECT	/*RESUMO GERAL*/
    count(a.nr_sequencia)total,
    a.QT_PONTUACAO,
	SUBSTR(Obter_Resul_nrs(a.qt_pontuacao),1,255) ds_pontuacao,
    b.CD_CONVENIO, 
    b.CD_SETOR_ATENDIMENTO CD_SETOR_ATENDIMENTO3
FROM	escala_nrs a, ATENDIMENTO_PACIENTE_v b,DIAGNOSTICO_DOENCA  c
WHERE	
a.NR_ATENDIMENTO = b.NR_ATENDIMENTO
and c.NR_ATENDIMENTO = a.NR_ATENDIMENTO
and b.NR_ATENDIMENTO = b.NR_ATENDIMENTO
and a.DT_LIBERACAO BETWEEN :DT_INICIAL and fim_dia(:DT_FINAL) 
and (b.CD_CONVENIO = :CD_CONVENIO or :CD_CONVENIO = 0)
and (b.CD_SETOR_ATENDIMENTO = :CD_SETOR_ATENDIMENTO2 or :CD_SETOR_ATENDIMENTO2 = 0)
and :CD_RELATORIO = 1
AND a.NR_SEQUENCIA = (select max(nr_sequencia)
                      from escala_nrs y 
                      where y.nr_atendimento = a.nr_atendimento)
and c.DT_DIAGNOSTICO = (select max(DT_DIAGNOSTICO)
                   from DIAGNOSTICO_DOENCA  y
                   where y.NR_ATENDIMENTO = c.NR_ATENDIMENTO
                  and y.IE_SITUACAO = 'A')

group by    a.QT_PONTUACAO, 
            SUBSTR(Obter_Resul_nrs(a.qt_pontuacao),1,255),
            b.CD_CONVENIO, 
            b.CD_SETOR_ATENDIMENTO
order by 2





-- COMO ESTAVA 
SELECT /*RESUMO GERAL DESCRICAO*/
    b.DS_IDADE, 
    b.DS_SEXO,
    b.NR_ATENDIMENTO,
Obter_Clinica_Atendimento(b.NR_ATENDIMENTO) DS_CLINICA,
a.DS_OBSERVACAO
FROM	escala_nrs a, ATENDIMENTO_PACIENTE_v b,DIAGNOSTICO_DOENCA  c
WHERE	
a.NR_ATENDIMENTO = b.NR_ATENDIMENTO
and c.NR_ATENDIMENTO = a.NR_ATENDIMENTO
and b.NR_ATENDIMENTO = b.NR_ATENDIMENTO
and a.DT_LIBERACAO BETWEEN :DT_INICIAL and fim_dia(:DT_FINAL) 
and b.CD_CONVENIO = :CD_CONVENIO
and b.CD_SETOR_ATENDIMENTO = :CD_SETOR_ATENDIMENTO
and :CD_RELATORIO = 1
AND a.QT_PONTUACAO = :QT_PONTUACAO
order by 2

--COMO VAI FICAR
SELECT DISTINCT /*RESUMO GERAL DESCRICAO*/
    b.DS_IDADE, 
    b.DS_SEXO,
    b.NR_ATENDIMENTO,
    Obter_Clinica_Atendimento(b.NR_ATENDIMENTO) DS_CLINICA,
    a.DS_OBSERVACAO,
    SUBSTR(Obter_Desc_CID_Doenca(c.CD_DOENCA),1,100)ds_cid
FROM	escala_nrs a, ATENDIMENTO_PACIENTE_v b,DIAGNOSTICO_DOENCA  c
WHERE	
a.NR_ATENDIMENTO = b.NR_ATENDIMENTO
and c.NR_ATENDIMENTO = a.NR_ATENDIMENTO
and b.NR_ATENDIMENTO = b.NR_ATENDIMENTO
and a.DT_LIBERACAO BETWEEN :DT_INICIAL and fim_dia(:DT_FINAL) 
and (b.CD_CONVENIO = :CD_CONVENIO or :CD_CONVENIO = 0)
and (b.CD_SETOR_ATENDIMENTO = :CD_SETOR_ATENDIMENTO3 or :CD_SETOR_ATENDIMENTO3 = 0)
and :CD_RELATORIO = 1
AND a.QT_PONTUACAO = :QT_PONTUACAO
AND a.NR_SEQUENCIA = (select max(nr_sequencia)
                      from escala_nrs y 
                      where y.nr_atendimento = a.nr_atendimento)
and c.DT_DIAGNOSTICO = (select max(DT_DIAGNOSTICO)
                   from DIAGNOSTICO_DOENCA  y
                   where y.NR_ATENDIMENTO = c.NR_ATENDIMENTO
                  and y.IE_SITUACAO = 'A')
order by 2




/**MODELO DE REGRA DE ATRIBUTO GESTÃO DA QUALIDAD*/
decode(:NR_SEQ_EVENTO,41,'Nome completo do material: 
Marca e modelo/especificações: 
Lote do produto:
Validade do produto:
Descrição da ocorrência:')



/*ASSINATURA QUANDO PRECISARTEM QUE ESTÁ ATRIBUTO NA BANDA DE CIMA PARA PEGAR*/
SELECT
IM_ASSINATURA
FROM PESSOA_FISICA_ASSINATURA
WHERE CD_PESSOA_FISICA = obter_codigo_usuario(:NM_USUARIO)

and :NM_USUARIO_LOGADO NOT IN( 'MARCELEB' , 'ALESSANDRAD')

substr(obter_nome_pf(obter_codigo_usuario(a.NM_USUARIO)),1,60) nm_solicitante,

SELECT *
FROM PESSOA_FISICA_ASSINATURA
WHERE CD_PESSOA_FISICA = :CD_MEDICO
AND IE_TIPO = nvl('C','A')

select 	substr(obter_nome_pf(a.cd_medico_requisitante),1,60) nm_solicitante,
        a.cd_medico_requisitante CD_MEDICO,
        decode(obter_cpf_pessoa_fisica(a.cd_medico_requisitante),'',decode(obter_dados_pf(a.cd_medico_requisitante,'CNS'),'','(     ) CNS                      (     ) CPF','(  X  ) CNS                      (     ) CPF'),'(     ) CNS                      (  X  ) CPF') cns_cpf,
        insere_espaco_entre_campos(elimina_caracteres_especiais( decode(obter_cpf_pessoa_fisica(a.cd_medico_requisitante),'',decode(obter_dados_pf(a.cd_medico_requisitante,'CNS'),'','',obter_dados_pf(a.cd_medico_requisitante,'CNS')),obter_cpf_pessoa_fisica(a.cd_medico_requisitante))),5) nr_cns_cpf,
        a.dt_emissao dt_emissao,
        Obter_Usuario_Ativo() NM_USUARIO_LOGADO
from 	sus_laudo_paciente a
where	a.nr_atendimento	= 1906512
and 	a.nr_seq_interno	= 167623

select * from pessoa_fisica where NM_PESSOA_FISICA = 'EDUARDO ALBERTO SEEFELD' 

SELECT  * from 	sus_laudo_paciente  where NR_ATENDIMENTO = 1906512

NM_USUARIO

SELECT
IM_ASSINATURA
FROM PESSOA_FISICA_ASSINATURA
WHERE CD_PESSOA_FISICA =  289346

SELECT
IM_ASSINATURA
FROM PESSOA_FISICA_ASSINATURA


SELECT
IM_ASSINATURA
FROM PESSOA_FISICA_ASSINATURA
WHERE CD_PESSOA_FISICA = :CD_PROFISSIONAL
AND IE_TIPO = 'A'

SELECT
IM_ASSINATURA
FROM PESSOA_FISICA_ASSINATURA
WHERE CD_PESSOA_FISICA = :CD_USUARIO
AND IE_TIPO = 'A'

SELECT
IM_ASSINATURA
FROM PESSOA_FISICA_ASSINATURA
WHERE CD_PESSOA_FISICA = :CD_MEDICO
AND IE_TIPO = nvl('C','A')

select OBTER_DESC_USUARIO(wheb_usuario_pck.get_nm_usuario) as PRINTER
from dual

SELECT
IM_ASSINATURA
FROM PESSOA_FISICA_ASSINATURA
WHERE CD_PESSOA_FISICA = :CD_MEDICO
AND IE_TIPO = nvl('C','A')
and :NM_USUARIO_LOGADO NOT IN( 'MARCELEB' , 'ALESSANDRAD')


select distinct DS_SQL from BANDA_RELAT_CAMPO



select 	substr(obter_nome_pf(obter_codigo_usuario(a.NM_USUARIO)),1,60) nm_solicitante,
        a.cd_medico_requisitante CD_MEDICO,
        decode(obter_cpf_pessoa_fisica(a.cd_medico_requisitante),'',decode(obter_dados_pf(a.cd_medico_requisitante,'CNS'),'','(     ) CNS                      (     ) CPF','(  X  ) CNS                      (     ) CPF'),'(     ) CNS                      (  X  ) CPF') cns_cpf,
        insere_espaco_entre_campos(elimina_caracteres_especiais( decode(obter_cpf_pessoa_fisica(a.cd_medico_requisitante),'',decode(obter_dados_pf(a.cd_medico_requisitante,'CNS'),'','',obter_dados_pf(a.cd_medico_requisitante,'CNS')),obter_cpf_pessoa_fisica(a.cd_medico_requisitante))),5) nr_cns_cpf,
        a.dt_emissao dt_emissao,
        Obter_Usuario_Ativo() NM_USUARIO_LOGADO,
        NM_USUARIO NM_USUARIO

from 	sus_laudo_paciente a

where	a.nr_atendimento	= 1906512
and 	a.nr_seq_interno	= 167623




1-ALERTA
2-CONFUSO
3-RESPOTA A DOR
4-INCONSCIENTE
-----------------------------------------------
--FUNÇÃO PEGA  ATENDIMENTO TRAS PONTUAÇÃO MEWS
SELECT obter_pontuacao_mews(:nr_atendimento,0,'P') 
FROM DUAL 
--descrição morse
SELECT substr(obter_valor_morse(:nr_atendimento),1,255) FROM DUAL 


SELECT substr(Obter_escala_morse_paciente(:nr_atendimento),1,255) FROM DUAL 


select Obter_pontuacao_morse(:nr_atendimento) from dual


SELECT Obter_escala_morse_paciente(:nr_atendimento) FROM DUAL

--PONTUAÇÃO ECA 
SELECT substr(obter_dados_gca(:nr_atendimento,'P'),1,255) FROM DUAL


--MODELO TRAS NOME 
select substr(obter_pessoa_atendimento(:nr_atendimento,'N'),1,250) from dual

--PEGA CD_DOMINIO,VL_DOMINIO= DS_VALOR_DOMINIO
SELECT Obter_Valor_Dominio(3611,0) from dual

--Escala Mews - Nível de consciencia 
--DOMINIO:3611 
--APLICAÇÃO:TasyPac
0-ALERTA
1-CONFUSO
2-RESPOTA A DOR
3-INCONSCIENTE

--SQL BUSCA APLICAÇÃO E DOMINIO
select  NR_SEQUENCIA,
        NM_MODULO,
        CD_APLICACAO_TASY,
        CD_EXP_MODULO
from modulo_tasy
WHERE NM_MODULO = 'PEP'





AND ( b.cd_setor_atendimento =:cd_setor_atendimento )OR (0 =:cd_setor_atendimento)


-----------------------------------------------------------
/**MODLEO DE PARÂMETRO SÓ APARECE SE VC MARCA CHECK BOX**/
-----------------------------------------------------------
-----------------
/**IE_RODAPE**/
----------------
--Código:IE_RODAPE
--Descrição:Imprime Paciente no Rodapé
--Tipo:Varchar2
--forma Apresentção: Checkbox
--Pârametro: Check Box
--Valor Checado = S , N


----------------------
/**SQL NA BANDA**/
--BANDA FILHA RODAPÉ
---------------------
SELECT 	OBTER_NOME_SETOR(U.CD_SETOR_ATENDIMENTO) DS_SETOR_ATENDIMENTO,
        U.CD_UNIDADE_BASICA || ' ' ||U.CD_UNIDADE_COMPL  CD_UNIDADE,
        'Paciente: ' || OBTER_NOME_PF_PJ(P.CD_PESSOA_FISICA, '') NM_PESSOA_FISICA,
        U.DT_SAIDA_UNIDADE,
        U.DT_ENTRADA_UNIDADE
FROM 	ATEND_PACIENTE_UNIDADE U,
	ATENDIMENTO_PACIENTE P,
	PRESCR_MEDICA A
WHERE  A.NR_PRESCRICAO 	= :NR_PRESCRICAO
AND	A.NR_ATENDIMENTO	= P.NR_ATENDIMENTO
AND	A.NR_ATENDIMENTO	= U.NR_ATENDIMENTO
AND	('S'			=:IE_RODAPE)   <-- aqui tá o malvado
ORDER BY  U.DT_SAIDA_UNIDADE DESC,  U.DT_ENTRADA_UNIDADE DESC

---------------------------------------------------------------------------


--FUNÇÃO QUE PEGA USUÁRIO 
AND ((OBTER_PERFIL_ATIVO = 1854
--MODELO MONTADO NEWS
Select 
A.NR_ATENDIMENTO    ,
A.CD_UNIDADE        ,
A.NM_PACIENTE       ,
A.DS_SEXO           ,
A.DT_ENTRADA_UNIDADE,
A.DT_SAIDA_UNIDADE  ,
A.DS_CONVENIO       ,
A.DESCRISAO         ,
A.NOTA
FROM
(
select
    a.nr_atendimento,
    a.cd_unidade    ,
    a.nm_paciente   , 
    decode(a.ie_sexo,'M','Masculino','F','Feminino','') ds_sexo,
    a.dt_entrada_unidade,
    a.DT_SAIDA_UNIDADE,
    a.ds_convenio,
    --PEGA MAIOR SEQ SELECT CIMA CONVERTE NOTA
    
    /**(SELECT MAX(NR_SEQUENCIA) 
    FROM   ESCALA_MEWS M
    WHERE  M.NR_ATENDIMENTO = A.NR_ATENDIMENTO 
    and IE_SITUACAO  = 'A') NR_SEQ,**/
    
    --FUNÇÃO FORA PEGA NÚMERO CONVERTE NOTA descrição
    --(FUNÇÃO DENTRO PEGA PONTUAÇÃO TRANSFORMA VARCHAR 
    obter_descricao_pont_mews(SUBSTR(obter_pontuacao_mews(A.nr_atendimento,1),1,100))DESCRISAO,
    obter_pontuacao_mews(A.nr_atendimento,1)nota
    --obter_resultado_escala_mews(a.nr_atendimento,1)result_dt

from atendimento_paciente_v a

where   (a.DT_ENTRADA BETWEEN :dt_inicial and :dt_final)
        and (a.cd_setor_atendimento = :cd_setor_atendimento or :cd_setor_atendimento = 0)
        AND obter_pontuacao_mews(A.nr_atendimento,1) mm/yy
--GROUP BY 

)A
WHERE 1 = 1
and :tipo_relatorio = 'P'















--***********************************************************************************************
--MODELO  DE SQL TROCA TÍTULO CONFORME RELATÓRIO
(SELECT 'De: '|| :dt_inicial ||'   Até: '||:dt_final  FROM dual where 1=1 and :tipo_relatorio = 'P')P,
(SELECT 'Ocupação Atual - '||to_char(sysdate,'dd/mm/yyyy hh24:mi:ss' ) FROM dual where 1=1 and :tipo_relatorio = 'O')O
FROM DUAL
*************************************************************************************************

/*************************************************************
CATE 1270 HCB - Total de Parecer por Atendimento Sem Quebra 
MODELO ANALÍTICO E SINTÉTICO
/**********************************************************************/
select * from DOMINIO /*nome e descrição do dominio                   */
select * from VALOR_DOMINIO where CD_DOMINIO = 4  /*valor do dominio  */
/**********************************************************************/
--MODELO QUE BUSCA O DOMINIO/MODULO/DS_DOMINIO-
SELECT  DISTINCT
        --a.NM_DOMINIO,
        A.CD_DOMINIO,
        OBTER_NOME_DOMINIO(A.CD_DOMINIO)NOME_DOMINIO,
        b.VL_DOMINIO,
        b.DS_VALOR_DOMINIO,
        substr(Obter_Desc_Modulo(a.NR_SEQ_MODULO),1,250)modulo,
        B.CD_EXP_VALOR_DOMINIO,
        A.CD_EXP_DOMINIO,
        A.CD_EXP_DESC_DOMINIO
from DOMINIO A , VALOR_DOMINIO B
WHERE  A.CD_DOMINIO = B.CD_DOMINIO
--AND  B.CD_DOMINIO = :CD_DOMINIO                                       --FILTRO PELO CD_DOMINIO
--AND B.DS_VALOR_DOMINIO LIKE ('%SMS%')                                 --FILTRO PELO DS_DOMINIO
AND (substr(OBTER_NOME_DOMINIO(A.CD_DOMINIO),1,250) LIKE '%sms%')     --FILTRO PELO NOME_DOMINIO
--substr(Obter_Desc_Modulo(a.NR_SEQ_MODULO),1.250) LIKE '%Cadastros pessoas%') --FILTRO PELO MODULO
AND IE_SITUACAO = 'A'
ORDER BY 1,4

/**********************************************************************/
select * from RELATORIO_PARAMETRO /*parametros criados em relatório
/**********************************************************************/

/**********************************************************************/
select * from TIPO_LOCALIZAR where NR_SEQUENCIA = 11002 -- SHIFT + F11 = TIPO DE LOCALIZADOR 
select * from TIPO_LOCALIZAR_ATRIBUTO where NR_SEQUENCIA = 11002

select * from TIPO_LOCALIZAR_ATRIBUTO WHERE NM_ATRIBUTO LIKE ('IE_PERM_SMS_EMAIL')
select * from RELATORIO_PARAMETRO WHERE CD_PARAMETRO LIKE ('IE_PERM_SMS_EMAIL')

/**********************************************************************/
select      DISTINCT
            a.NR_SEQUENCIA SEQ_LOCALIZADOR,
            OBTER_DESC_TIPO_LOCALIZADOR (A.nr_sequencia),
            b.NR_SEQ_TIPO_LOCALIZAR SEQ_ATRIBUTOS,
            B.NR_SEQUENCIA,
            b.NM_ATRIBUTO,
            b.DS_ITEM,
            a.DS_LOCALIZADOR,
            a.DS_SQL,
            a.DS_ARVORE,
            a.CD_EXP_LOCALIZADOR
           
from    TIPO_LOCALIZAR A, 
        TIPO_LOCALIZAR_ATRIBUTO B
--WHERE   A.NR_SEQUENCIA = 12737
where  a.DS_LOCALIZADOR like ('%gesta%')


/**********************************************************************/
--CAMPO LOCALIADOR DO TASY
/**********************************************************************/
select      DISTINCT
            B.DS_LOCALIZADOR,
            A.NM_ATRIBUTO,
            DS_ITEM,
            B.DS_SQL
    from    TIPO_LOCALIZAR_ATRIBUTO a,
            TIPO_LOCALIZAR b 
where   a.NR_SEQ_TIPO_LOCALIZAR = B.NR_SEQUENCIA
and DS_LOCALIZADOR like '%laudo SUS%'


select * from TIPO_LOCALIZAR WHERE DS_LOCALIZADOR IN ('%procedimento%')
select * from  TIPO_LOCALIZAR_ATRIBUTO WHERE DS_ITEM ='%lote%'

/**********************************************************************/










-----------------------------------------------
--REGRA POR ATRIBUTO
----------------------------------------------

--SQL MOSTRA AS REGRAS POR ATRIBUTO DO TASY
---------------------------------
SELECT * FROM tabela_atrib_regra
where DS_SCRIPT is not null
---------------------------------------------------------------------------
SELECT NR_SEQUENCIA,DS_SCRIPT,NM_ATRIBUTO,IE_TIPO_SCRIPT,
IE_TABSTOP ||''||IE_ENABLE||''|| IE_OBRIGATORIO ||''||VL_DEFAULT,NM_USUARIO
FROM tabela_atrib_regra
where DS_SCRIPT h24


----------------------------------------------------------------------------
select * 
from QUA_EVENTO_PACIENTE
where :NR_SEQ_EVENTO IN(73,80)

AND :NR_SEQ_TIPO IN (73, 83)

SELECT DECODE(:NR_SEQ_TIPO,74,'73',61,'73',62,'73',75,'73',76,'73',80)
from QUA_EVENTO_PACIENTE

AND :NR_SEQ_TIPO IN (73, 80)

select distinct obter_desc_evento(nr_seq_evento)
from QUA_EVENTO_PACIENTE
where obter_desc_evento(nr_seq_evento) h24

select
DECODE(:NR_SEQ_EVENTO, 3, 1, 19, 1, 38, 1, 31, 1, NULL, '', 2) from QUA_EVENTO_PACIENTE

-----------------------------------------------
--SQL APLICAÇÕES/FUNÇÕES/DOMINIOO
----------------------------------------------
/*MODULOS TASY(APLICAÇÕES)*/
select  NR_SEQUENCIA,
        NM_MODULO,
        CD_APLICACAO_TASY,
        CD_EXP_MODULO
from modulo_tasy
where NR_SEQUENCIA = 221 --modulo manutenção
order by 2
/*MODULO E FUNÇÕES*/
select *
from FUNCAO
where NR_SEQ_MODULO = 221  --modulo manutenção
and IE_VERSAO_USO = ('D')  -- d = delphi

/*MODULO APLICAÇÃO E FUNÇÕES*/
SELECT  a.CD_APLICACAO_TASY APLICACAO,
        A.NR_SEQUENCIA CD_MODULO,
        a.NM_MODULO,
        b.CD_FUNCAO,
        b.DS_FUNCAO,
        (SELECT C.CD_DOMINIO,
        C.NM_DOMINIO 
        FROM DOMINIO C 
        WHERE C.NR_SEQ_MODULO = 221)TESTE  
FROM    modulo_tasy a,
        FUNCAO b
where a.NR_SEQUENCIA = b.NR_SEQ_MODULO
and b.NR_SEQ_MODULO = 221 --modulo manutenção 
and b.IE_VERSAO_USO = ('D') --aplicação delphi


/*MODULO TASY/FUNÇÃO/DOMINIO*/
SELECT Obter_Valor_Dominio(8288,1) FROM DUAL
CD_DOMINIO,VL_DOMINIO
SELECT * FROM DOMINIO where NR_SEQ_MODULO = 221


--------------------------------------------
--MODELO CORRETO CONTA LINHAS--------------- 
--------------------------------------------
SELECT DISTINCT  COUNT (CD_PESSOA_FISICA)
FROM 
(
--RODO SUBSELECT  TRASFORMO EM UMA TABELA
SELECT DISTINCT  Y.CD_PESSOA_FISICA
FROM HD_DIALISE Y
where Y.DT_DIALISE between :dt_inicial and fim_dia(:dt_final)
and Y.dt_cancelamento is null
)

-----------------------------------------------------------
--EXEMPLO SQL PEGA MÊS DO SERVIDOR-------------------------
-----------------------------------------------------------

(Select extract(month from sysdate)from dual) MES_ATUAL
--EXEMPLO PEGA MÊS E O MÊS ANTERIOR
WHERE DAT_REFERENCIA BETWEEN  add_months(trunc(sysdate,'MM'),-1) AND SYSDATE
y.DT_DIALISE <= sysdate


--------------------------------------------------------------
--MODELO AGRUPA CD_PESSOA_FISICA PEGA ATENDIMENTO MAIS ATUAL--
--------------------------------------------------------------
SELECT DISTINCT         SUBSTR(OBTER_NOME_PF(cd_p),1,250)pessoa,
                        dt_ult_atendimento
FROM 
(
SELECT DISTINCT Y.CD_PESSOA_FISICA cd_p,
                MAX(Y.DT_DIALISE)dt_ult_atendimento
FROM HD_DIALISE Y
where Y.DT_DIALISE between :dt_inicial and fim_dia(:dt_final)
and Y.dt_cancelamento is null
group by Y.CD_PESSOA_FISICA 
)
order by 1 

-------------------------------------------------------
-- SQL LOCALIZA ATRIBUTO FUNCIONALIDADE DO CAMPO------- 
-------------------------------------------------------
select  NM_TABELA,
        NM_ATRIBUTO,
        IE_TIPO_ATRIBUTO,
        DS_ATRIBUTO,
        IE_SITUACAO,
        DS_VALORES,
        CD_DOMINIO,
        DS_LABEL,
        DS_LABEL_GRID,
        DS_MASCARA,
        CD_EXP_DESC,
        substr(obter_desc_expressao(cd_exp_desc),1,254)ds_exp_desc
from TABELA_ATRIBUTO
where NM_ATRIBUTO = ('NR_SEQ_TRIAGEM')


----------------------------------
-- MODELO PARA TESTAR AVALIAÇÃO 
--------------------------------
SELECT
HCB_OBTER_AVAL_PA_ATEND_X(:NR_ATENDIMENTO,1119)TORACICA,
HCB_OBTER_AVAL_PA_ATEND_X(:NR_ATENDIMENTO,1120)AVC,
HCB_OBTER_AVAL_PA_ATEND_X(:NR_ATENDIMENTO,1607)SEPSE,
HCB_OBTER_AVAL_PA_ATEND_D(:NR_ATENDIMENTO,837)Q_PRINCIPAL,
HCB_OBTER_AVAL_PA_ATEND_D(:NR_ATENDIMENTO,838)EVOLUCAO,
HCB_OBTER_SINAL_VITAL_ATEND(:NR_ATENDIMENTO,'PAS')PA_MAX,
HCB_OBTER_SINAL_VITAL_ATEND(:NR_ATENDIMENTO,'PAD')PA_MIN,
HCB_OBTER_SINAL_VITAL_ATEND(:NR_ATENDIMENTO,'PAM')PAM,
HCB_OBTER_SINAL_VITAL_ATEND(:NR_ATENDIMENTO,'FRC')FC,
HCB_OBTER_SINAL_VITAL_ATEND(:NR_ATENDIMENTO,'TMP')TEMPERATURA,
HCB_OBTER_SINAL_VITAL_ATEND(:NR_ATENDIMENTO,'SAT')SAT,
HCB_OBTER_SINAL_VITAL_ATEND(:NR_ATENDIMENTO,'FRR')FR,
HCB_OBTER_JUST_AVAL_ATEND(:NR_ATENDIMENTO)DS_JUSTIFICATIVA
FROM DUAL


--------------------------------------------------
--MODELO UTILIZANDO FUNÇÃO QUE CONCATENA  SQL
-----------------------------------------------
select /*40*/
distinct  
(select distinct OBTER_SELECT_CONCATENADO_BV('SELECT substr(nvl(nvl(nvl(nvl(obter_desc_dcb(nr_seq_dcb),
 substr(obter_desc_material(cd_material),1,254)||b.DS_MEDIC_NAO_CAD ),
 substr(obter_desc_classe_mat(cd_classe_mat),1,255)||b.DS_MEDIC_NAO_CAD ),
 obter_desc_ficha_tecnica(nr_seq_ficha_tecnica)||b.DS_MEDIC_NAO_CAD ),
 obter_desc_familia_mat(nr_seq_familia)||b.DS_MEDIC_NAO_CAD),1,255)
 FROM PACIENTE_ALERGIA B 
 WHERE obter_pessoa_atendimento(:NR_ATENDIMENTO,''C'')=obter_pessoa_atendimento(b.NR_ATENDIMENTO,''C'') 
 AND (B.DT_FIM > SYSDATE OR B.DT_FIM IS NULL)
 AND B.DT_INATIVACAO IS NULL
 ORDER BY 1'
 ,'NR_ATENDIMENTO='||(:NR_ATENDIMENTO)||';','; ')
from DUAL
)ALERGIA,
(select distinct
 OBTER_SELECT_CONCATENADO_BV('
 SELECT substr(nvl(nvl(obter_desc_material(cd_material),ds_medicamento),ds_medicamento),1,100) 
 FROM PACIENTE_MEDIC_USO c 
 WHERE obter_pessoa_atendimento(:NR_ATENDIMENTO,''C'')=obter_pessoa_atendimento(c.NR_ATENDIMENTO,''C'') 
 AND (C.DT_FIM > SYSDATE OR C.DT_FIM IS NULL)
 AND C.DT_INATIVACAO IS NULL
 ORDER BY 1'
 ,'nr_atendimento='||(:NR_ATENDIMENTO)||';','; ')
from DUAL) MED_USO,
(select distinct
 OBTER_SELECT_CONCATENADO_BV('
SELECT substr(obter_desc_fator_risco(c.nr_seq_fator_risco),1,255)
 FROM CIH_PAC_FAT_RISCO c 
 WHERE obter_pessoa_atendimento(:NR_ATENDIMENTO,''C'')=obter_pessoa_atendimento(C.NR_ATENDIMENTO,''C'') 
 AND (c.DT_FIM_RISCO > SYSDATE OR C.DT_FIM_RISCO IS NULL)
 AND C.DT_INATIVACAO IS NULL
 ORDER BY 1'
 ,'NR_ATENDIMENTO='||(:NR_ATENDIMENTO)||';','; ')
from DUAL)FATOR_RISCO,
(select distinct OBTER_SELECT_CONCATENADO_BV('
 SELECT B.DS_DOENCA 
 FROM PACIENTE_ANTEC_CLINICO B 
 WHERE obter_pessoa_atendimento(:NR_ATENDIMENTO,''C'')=obter_pessoa_atendimento(b.NR_ATENDIMENTO,''C'') 
 AND (B.DT_FIM > SYSDATE OR B.DT_FIM IS NULL)
 AND B.DT_INATIVACAO IS NULL
 ORDER BY 1'
 ,'NR_ATENDIMENTO='||(:NR_ATENDIMENTO)||';','; ')
from DUAL)DOENCA_PREVIA
from DUAL


SELECT  max(obter_pontuacao_mews(nr_atendimento)),
		max(x.dt_avaliacao)
FROM    ESCALA_MEWS x
	WHERE	x.nr_atendimento = nr_atendimento
	AND 	x.dt_inativacao IS NULL 
	AND	    x.dt_liberacao  hh24
	AND 	x.nr_sequencia = (SELECT MAX(nr_sequencia)
                              FROM escala_mews y
                              WHERE y.nr_atendimento = x.nr_atendimento);



-------------------------------------------
--MODELO CONTA DIALISE 
-----------------------------------------------							  
SELECT DISTINCT  COUNT (CD_PESSOA_FISICA)
FROM 
(
SELECT DISTINCT  Y.CD_PESSOA_FISICA
FROM HD_DIALISE Y
where Y.DT_DIALISE between :dt_inicial and fim_dia(:dt_final)
and Y.dt_cancelamento is null
)		

---------------------
--EXEMPLO MORSE
-------------------
Select 
		A.NR_ATENDIMENTO,
		A.CD_UNIDADE,
		A.NM_PACIENTE,
		A.DS_IDADE,
		A.DS_SEXO,
		A.DT_ENTRADA_UNIDADE,
		A.DS_CONVENIO,
		A.NR_SEQ, 
		QT_PONTUACAO,
		B.DT_LIBERACAO
		(
		Case   when QT_PONTUACAO IS NULL 
        Then 'Risco não calculado'
        ELSE OBTER_DESC_ESCALA_MORSE(QT_PONTUACAO)
		End 
		) DESCRICAO,

from 
(
		select
		a.nr_atendimento,
		a.cd_unidade    ,
		nvl(a.nm_pessoa_fisica, a.nm_paciente_reserva) nm_paciente,
		b.ds_anos_meses_dias    ds_idade,
		decode(a.ie_sexo,'M','Masculino','F','Feminino','') ds_sexo,
		a.dt_entrada_unidade,
		a.ds_convenio,
		(SELECT MAX(NR_SEQUENCIA) 
		FROM   ESCALA_MORSE M 
		WHERE  M.NR_ATENDIMENTO = A.NR_ATENDIMENTO 
        and IE_SITUACAO  = 'A') NR_SEQ
from ocupacao_unidade_v a, atendimento_paciente_v b
where a.nr_atendimento = b.nr_atendimento
and a.cd_setor_atendimento = :cd_setor_atendimento
and 1=1
order by a.nr_seq_apresent, a.cd_unidade
) A 

-------------------------------------
--MODELO RESTRINGIR  WHERE EXISTE
-------------------------------------

--Mostrar todas as cidades que possuem departamento
select *
  from cidade c
 where exists (select 1 from departamento d where d.id_cidade = c.id);
 
select *
  from cidade 
 where id in (select id_cidade
                from departamento);

--Mostrar todas as cidades que não possuem departamento
select *
  from cidade c
 where not exists (select 1 from departamento d where d.id_cidade = c.id);
 
select *
  from cidade 
 where id not in (select id_cidade
                from departamento);
























--SQL SOLTOS 

Erro: {Insufficient memory for this operation.
Table: C:\Tasy\Padrao\Del7827.DB}

/// ---------- SQL original ------------ \\\
SELECT PAGING.*, ROWNUM RecNo FROM ( select  a.* 
 ,SUBSTR(Obter_Desc_Expressao(cd_exp_valor_dominio),1,254) DS_EXP_VALOR_DOMINIO  ,substr(obter_valor_dominio(cd_dominio, vl_dominio), 1, 254) DS_VALOR_DOMINIO_GRID 
 from VALOR_DOMINIO a
Where CD_DOMINIO = :CD_DOMINIO
 and CD_DOMINIO = :CD_DOMINIO  and substr(obter_se_apresenta_dominio(cd_dominio, vl_dominio), 1, 1) = 'S' and nvl(ie_delphi,'A') = 'A'
Order by VL_DOMINIO
) PAGING

/// ---------- SQL substituído ---------- \\\
SELECT PAGING.*, ROWNUM RecNo FROM ( select  a.* 
 ,SUBSTR(Obter_Desc_Expressao(cd_exp_valor_dominio),1,254) DS_EXP_VALOR_DOMINIO  ,substr(obter_valor_dominio(cd_dominio, vl_dominio), 1, 254) DS_VALOR_DOMINIO_GRID 
 from VALOR_DOMINIO a
Where CD_DOMINIO = '8288'
 and CD_DOMINIO = '8288'  and substr(obter_se_apresenta_dominio(cd_dominio, vl_dominio), 1, 1) = 'S' and nvl(ie_delphi,'A') = 'A'
Order by VL_DOMINIO
) PAGING

/// ---------- Parâmetro(s) ------------- \\\

CD_DOMINIO --> '8288'
CD_DOMINIO --> '8288'


 select distinct
	a.nr_sequencia,
	b.nr_lote,
	a.nr_prescricao,
	a.nr_atendimento,
     substr(obter_nome_pf(a.cd_pessoa_fisica),1,255) nm_pessoa_fisica,
	b.nr_sequencia
from   lote_ent_sec_ficha a,
          lote_ent_secretaria b
where  b.nr_sequencia = a.nr_seq_lote_sec	   
order  by 1


/// ---------- SQL substituído ---------- \\\
select  /*+ INDEX(c atepaci_pk) INDEX(a SUSLAPA_ATEPACI_FK_I) INDEX(b SUSLOAU_PK)*/ 
	a.nr_atendimento,
	c.cd_pessoa_fisica,
	substr(obter_nome_pf(c.cd_pessoa_fisica),1,120) nm_paciente,
	obter_prontuario_paciente(c.cd_pessoa_fisica) nr_prontuario,
	a.nr_seq_interno,
	substr(obter_valor_dominio(801, a.ie_tipo_laudo_sus),1,120) ds_tipo_laudo,
	to_char(a.dt_emissao, 'dd/mm/yyyy') dt_emissao,
	substr(obter_valor_dominio(1472, a.ie_tipo_laudo_apac),1,120) ds_tipo_laudo_apac,
	to_char(a.dt_retorno_secr, 'dd/mm/yyyy') dt_retorno_secr,
	a.cd_procedimento_solic,
	a.qt_procedimento_solic,
	substr(obter_descricao_procedimento(a.cd_procedimento_solic, a.ie_origem_proced),1,120) ds_procedimento,
	substr(obter_nome_pf(a.cd_medico_requisitante),1,120) nm_medico_requisitante,
	substr(obter_nome_pf(a.cd_medico_responsavel),1,120) nm_medico_responsavel,
	a.nr_aih,
	a.nr_apac,
   a.nr_bpa,
	a.dt_inicio_val_apac,
	a.dt_fim_val_apac,
	a.nr_interno_conta,
	b.ds_lote,
	a.ie_classificacao,
	trunc(nvl(dt_retorno_secr,sysdate)) - trunc(b.dt_envio) qt_dias_pendentes,
	substr(Obter_ultimo_hist_laudo_sus(a.nr_seq_interno),1,255) ds_ult_hist,
	a.ds_inconsistencia,
	substr(Obter_desc_proced_adic(a.nr_seq_interno),1,255) ds_proced_adic,
	trunc(b.dt_envio) dt_envio,
	substr(obter_valor_dominio(12,c.ie_tipo_atendimento),1,50) ds_tipo_atendimento,
	substr(sus_obter_dados_apac(a.nr_apac,'OC'),1,10) dt_ocorrencia,
	substr(a.ds_sigla_esquema,1,255) ds_sigla_esquema,
   substr(sus_obter_desc_mtv_nexec_laudo(a.nr_seq_motivo_nexec_proc),1,255) ds_motivo,
	substr(a.ds_observacao,1,255) ds_observacao,
                substr(obter_dados_conta_paciente(a.nr_interno_conta, 'P'),1,255) nr_protocolo_conta,
	trunc(a.dt_liberacao) dt_liberacao
from    sus_lote_autor       b,
	sus_laudo_paciente   a,
	atendimento_paciente c,
   atend_paciente_unidade d
where	a.nr_seq_lote        = b.nr_sequencia(+)
and	a.nr_atendimento     = c.nr_atendimento
and	c.nr_atendimento	   = d.nr_atendimento
and	d.nr_seq_interno 	   = Obter_Atepacu_paciente(c.nr_atendimento, 'A')
and	c.cd_estabelecimento = 1
and	a.dt_cancelamento is null
 and trunc(a.dt_emissao) between TO_DATE('01/04/2023','dd/mm/yyyy') and TO_DATE('30/04/2023','dd/mm/yyyy') and a.ie_classificacao in (11,12,13,14) and 1 = 1 and ie_tipo_laudo_apac = 20
order by a.nr_atendimento desc



---------------------------------------------
SELECT  a.NR_ATENDIMENTO,
        substr(obter_nome_pf(a.cd_pessoa_fisica),1,50)obter_nome,
        a.DT_EVENTO,
        substr(obter_nome_setor(a.cd_setor_atendimento),1,50)obter_setor,
        substr(obter_desc_evento_qua(a.nr_seq_evento),1,50)obter_desc_evento,
        a.NM_USUARIO_ORIGEM

FROM
    qua_evento_paciente a
WHERE
    a.dt_evento BETWEEN TO_DATE(:data_inicio,'dd/mm/yyyy hh24:mi:ss')AND 
                                  fim_dia(TO_DATE(:data_fim,'dd/mm/yyyy hh24:mi:ss'))
ORDER BY 2

-----------------------------------------------------------------------------------
SELECT * from qua_evento_paciente

SELECT * from qua_gravidade_evento

substr(obter_desc_expressao(cd_exp_gravidade, ds_gravidade), 1, 255)
        substr(qua_obter_se_gravid_evento_lib(a.NR_SEQ_GRAVIDADE,a.IE_CLASSIFICACAO),1,80)teste,

--parametro pelo tipo evento
select  x.NR_SEQ_TIPO,
        x.DS_EVENTO
from QUA_EVENTO x
order by 2
-----------------------------------------------------------------------------------
--parametro situacao ativo=a/inativo=i/ambos=1á

select  IE_CLASSIFICACAO
from QUA_EVENTO_PACIENTE a

------------------------------------------------------------------------------------
select	nr_sequencia cd,
	substr(obter_desc_expressao(cd_exp_gravidade, ds_gravidade), 1, 255) ds
from	qua_gravidade_evento
where	ie_situacao = 'A'
and	cd_empresa = 1
and	qua_obter_se_gravid_evento_lib(nr_sequencia,'4') = 'S'
union
select	nr_sequencia cd,
	substr(obter_desc_expressao(cd_exp_gravidade, ds_gravidade), 1, 255) ds
from	qua_gravidade_evento
order by 2


SELECT 
    substr(obter_dados_pf(a.cd_pessoa_fisica),1,255)teste,
    a.CD_PESSOA_FISICA
FROM qua_evento_paciente a 

    substr(obter_nome_convenio(a.cd_convenio),1,255) ds_convenio

/// ---------- SQL original ------------ \\\
 select  a.* 
 ,substr(obter_valor_dominio(3502,ie_status),1,255) DS_STATUS  ,substr(obter_desc_usuario(nm_usuario_origem),1,100) DS_USUARI
 O_ORIGEM  ,substr((select obter_desc_expressao (CD_EXP_turno, cd_turno) from regra_turno_evento where nr_sequencia = NR_SEQ_TURNO),1,11) DS_TURNO  ,substr(OBTER_PESSOA_ATENDIMENTO(nr_atendimento, 'N'),1,100) NM_PACIENTE  ,substr(obter_nome_pf(cd_profissional),1,255) DS_PROFISSIONAL  ,substr(obter_nome_setor(CD_SETOR_ATENDIMENTO),1,60) DS_SETOR_ATENDIMENTO  ,(select substr(obter_desc_expressao(x.cd_exp_evento, x.ds_evento),1,255) from qua_evento x where x.nr_sequencia = NR_SEQ_EVENTO) DS_QUA_EVENTO  ,substr(obter_descricao_padrao('QUA_EVENTO_CLASSIF','DS_CLASSIFICACAO',NR_SEQ_CLASSIF_EVENTO),1,100) DS_CLASSIF_EVENTO  ,substr(obter_desc_qua_classif_evento(ie_classificacao, :cd_empresa),1,255) DS_CLASSIFICACAO  ,substr(obter_descricao_padrao('QUA_MOTIVO_CANCEL_EV_PAC','DS_MOTIVO_CANCELAMENTO',nr_seq_motivo_cancel),1,255) DS_MOTIVO_CANCELAMENTO  ,(select substr(obter_desc_expressao(x.cd_exp_gravidade, x.ds_gravidade),1,255) from qua_gravidade_evento x where x.nr_sequencia = nr_seq_gravidade) DS_GRAVIDADE  ,substr(obter_desc_setor_atend(cd_setor_analise),1,100) DS_SETOR_ANALISE  ,substr(qua_is_evento_atrasado(nr_sequencia), 1, 3) IE_ATRASADO  ,OBTER_DATA_ASSINATURA_DIGITAL(nr_seq_assinat_inativacao) DT_ASSINATURA_INATIVACAO  ,OBTER_DATA_ASSINATURA_DIGITAL(nr_seq_assinatura) DT_ASSINATURA  ,count(*) over () QT_TOTAL_REGISTROS  ,substr(qua_obter_dados_nao_conform(qua_obter_nao_conform_evento(nr_sequencia),'ST'),1,20) IE_STATUS_RNC_EVENTO  ,substr(obter_se_nao_conform_atrasada(qua_obter_nao_conform_evento(nr_sequencia)),1,1) IE_ACAO_ATRASADA_RNC_EVENTO  ,substr(Qua_Obter_Se_Novo_Hist(qua_obter_nao_conform_evento(nr_sequencia),:nm_usuario_cor),1,1) IE_NOVO_HIST_RNC_EVENTO 
 from QUA_EVENTO_PACIENTE a
Where 1 = 1
 and 1 = 2 
Order by 1

/// ---------- SQL substituído ---------- \\\
 select  a.* 
 ,substr(obter_valor_dominio(3502,ie_status),1,255) DS_STATUS  ,substr(obter_desc_usuario(nm_usuario_origem),1,100) DS_USUARIO_ORIGEM  ,substr((select obter_desc_expressao (CD_EXP_turno, cd_turno) from regra_turno_evento where nr_sequencia = NR_SEQ_TURNO),1,11) DS_TURNO  ,substr(OBTER_PESSOA_ATENDIMENTO(nr_atendimento, 'N'),1,100) NM_PACIENTE  ,substr(obter_nome_pf(cd_profissional),1,255) DS_PROFISSIONAL  ,substr(obter_nome_setor(CD_SETOR_ATENDIMENTO),1,60) DS_SETOR_ATENDIMENTO  ,(select substr(obter_desc_expressao(x.cd_exp_evento, x.ds_evento),1,255) from qua_evento x where x.nr_sequencia = NR_SEQ_EVENTO) DS_QUA_EVENTO  ,substr(obter_descricao_padrao('QUA_EVENTO_CLASSIF','DS_CLASSIFICACAO',NR_SEQ_CLASSIF_EVENTO),1,100) DS_CLASSIF_EVENTO  ,substr(obter_desc_qua_classif_evento(ie_classificacao, 1),1,255) DS_CLASSIFICACAO  ,substr(obter_descricao_padrao('QUA_MOTIVO_CANCEL_EV_PAC','DS_MOTIVO_CANCELAMENTO',nr_seq_motivo_cancel),1,255) DS_MOTIVO_CANCELAMENTO  ,(select substr(obter_desc_expressao(x.cd_exp_gravidade, x.ds_gravidade),1,255) from qua_gravidade_evento x where x.nr_sequencia = nr_seq_gravidade) DS_GRAVIDADE  ,substr(obter_desc_setor_atend(cd_setor_analise),1,100) DS_SETOR_ANALISE  ,substr(qua_is_evento_atrasado(nr_sequencia), 1, 3) IE_ATRASADO  ,OBTER_DATA_ASSINATURA_DIGITAL(nr_seq_assinat_inativacao) DT_ASSINATURA_INATIVACAO  ,OBTER_DATA_ASSINATURA_DIGITAL(nr_seq_assinatura) DT_ASSINATURA  ,count(*) over () QT_TOTAL_REGISTROS  ,substr(qua_obter_dados_nao_conform(qua_obter_nao_conform_evento(nr_sequencia),'ST'),1,20) IE_STATUS_RNC_EVENTO  ,substr(obter_se_nao_conform_atrasada(qua_obter_nao_conform_evento(nr_sequencia)),1,1) IE_ACAO_ATRASADA_RNC_EVENTO  ,substr(Qua_Obter_Se_Novo_Hist(qua_obter_nao_conform_evento(nr_sequencia),'EDUARDOK'),1,1) IE_NOVO_HIST_RNC_EVENTO 
 from QUA_EVENTO_PACIENTE a
Where 1 = 1
 and 1 = 2 
Order by 1

/// ---------- Parâmetro(s) ------------- \\\

cd_empresa     --> 1
nm_usuario_cor --> 'EDUARDOK'


obter_dados_pf(a.cd_pessoa_fisica)nome

/// ---------- SQL original ------------ \\\
 select  a.* 
 ,substr(obter_valor_dominio(3502,ie_status),1,255) DS_STATUS  ,substr(obter_desc_usuario(nm_usuario_origem),1,100) DS_USUARIO_ORIGEM  ,substr((select obter_desc_expressao (CD_EXP_turno, cd_turno) from regra_turno_evento where nr_sequencia = NR_SEQ_TURNO),1,11) DS_TURNO  ,substr(OBTER_PESSOA_ATENDIMENTO(nr_atendimento, 'N'),1,100) NM_PACIENTE  ,substr(obter_nome_pf(cd_profissional),1,255) DS_PROFISSIONAL  ,substr(obter_nome_setor(CD_SETOR_ATENDIMENTO),1,60) DS_SETOR_ATENDIMENTO  ,(select substr(obter_desc_expressao(x.cd_exp_evento, x.ds_evento),1,255) from qua_evento x where x.nr_sequencia = NR_SEQ_EVENTO) DS_QUA_EVENTO  ,substr(obter_descricao_padrao('QUA_EVENTO_CLASSIF','DS_CLASSIFICACAO',NR_SEQ_CLASSIF_EVENTO),1,100) DS_CLASSIF_EVENTO  ,substr(obter_desc_qua_classif_evento(ie_classificacao, :cd_empresa),1,255) DS_CLASSIFICACAO  ,substr(obter_descricao_padrao('QUA_MOTIVO_CANCEL_EV_PAC','DS_MOTIVO_CANCELAMENTO',nr_seq_motivo_cancel),1,255) DS_MOTIVO_CANCELAMENTO  ,(select substr(obter_desc_expressao(x.cd_exp_gravidade, x.ds_gravidade),1,255) from qua_gravidade_evento x where x.nr_sequencia = nr_seq_gravidade) DS_GRAVIDADE  ,substr(obter_desc_setor_atend(cd_setor_analise),1,100) DS_SETOR_ANALISE  ,substr(qua_is_evento_atrasado(nr_sequencia), 1, 3) IE_ATRASADO  ,OBTER_DATA_ASSINATURA_DIGITAL(nr_seq_assinat_inativacao) DT_ASSINATURA_INATIVACAO  ,OBTER_DATA_ASSINATURA_DIGITAL(nr_seq_assinatura) DT_ASSINATURA  ,count(*) over () QT_TOTAL_REGISTROS  ,substr(qua_obter_dados_nao_conform(qua_obter_nao_conform_evento(nr_sequencia),'ST'),1,20) IE_STATUS_RNC_EVENTO  ,substr(obter_se_nao_conform_atrasada(qua_obter_nao_conform_evento(nr_sequencia)),1,1) IE_ACAO_ATRASADA_RNC_EVENTO  ,substr(Qua_Obter_Se_Novo_Hist(qua_obter_nao_conform_evento(nr_sequencia),:nm_usuario_cor),1,1) IE_NOVO_HIST_RNC_EVENTO 
 from QUA_EVENTO_PACIENTE a
Where 1 = 1
 and 1 = 2 
Order by 1

/// ---------- SQL substituído ---------- \\\
 select  a.* 
 ,substr(obter_valor_dominio(3502,ie_status),1,255) DS_STATUS  ,substr(obter_desc_usuario(nm_usuario_origem),1,100) DS_USUARIO_ORIGEM  ,substr((select obter_desc_expressao (CD_EXP_turno, cd_turno) from regra_turno_evento where nr_sequencia = NR_SEQ_TURNO),1,11) DS_TURNO  ,substr(OBTER_PESSOA_ATENDIMENTO(nr_atendimento, 'N'),1,100) NM_PACIENTE  ,substr(obter_nome_pf(cd_profissional),1,255) DS_PROFISSIONAL  ,substr(obter_nome_setor(CD_SETOR_ATENDIMENTO),1,60) DS_SETOR_ATENDIMENTO  ,(select substr(obter_desc_expressao(x.cd_exp_evento, x.ds_evento),1,255) from qua_evento x where x.nr_sequencia = NR_SEQ_EVENTO) DS_QUA_EVENTO  ,substr(obter_descricao_padrao('QUA_EVENTO_CLASSIF','DS_CLASSIFICACAO',NR_SEQ_CLASSIF_EVENTO),1,100) DS_CLASSIF_EVENTO  ,substr(obter_desc_qua_classif_evento(ie_classificacao, 1),1,255) DS_CLASSIFICACAO  ,substr(obter_descricao_padrao('QUA_MOTIVO_CANCEL_EV_PAC','DS_MOTIVO_CANCELAMENTO',nr_seq_motivo_cancel),1,255) DS_MOTIVO_CANCELAMENTO  ,(select substr(obter_desc_expressao(x.cd_exp_gravidade, x.ds_gravidade),1,255) from qua_gravidade_evento x where x.nr_sequencia = nr_seq_gravidade) DS_GRAVIDADE  ,substr(obter_desc_setor_atend(cd_setor_analise),1,100) DS_SETOR_ANALISE  ,substr(qua_is_evento_atrasado(nr_sequencia), 1, 3) IE_ATRASADO  ,OBTER_DATA_ASSINATURA_DIGITAL(nr_seq_assinat_inativacao) DT_ASSINATURA_INATIVACAO  ,OBTER_DATA_ASSINATURA_DIGITAL(nr_seq_assinatura) DT_ASSINATURA  ,count(*) over () QT_TOTAL_REGISTROS  ,substr(qua_obter_dados_nao_conform(qua_obter_nao_conform_evento(nr_sequencia),'ST'),1,20) IE_STATUS_RNC_EVENTO  ,substr(obter_se_nao_conform_atrasada(qua_obter_nao_conform_evento(nr_sequencia)),1,1) IE_ACAO_ATRASADA_RNC_EVENTO  ,substr(Qua_Obter_Se_Novo_Hist(qua_obter_nao_conform_evento(nr_sequencia),'EDUARDOK'),1,1) IE_NOVO_HIST_RNC_EVENTO 
 from QUA_EVENTO_PACIENTE a
Where 1 = 1
 and 1 = 2 
Order by 1

/// ---------- Parâmetro(s) ------------- \\\

cd_empresa     --> 1
nm_usuario_cor --> 'EDUARDOK'

SELECT  a.NR_ATENDIMENTO,
        substr(obter_nome_pf(a.cd_pessoa_fisica),1,50)obter_nome,
        a.DT_EVENTO,
        substr(obter_nome_setor(a.cd_setor_atendimento),1,50)obter_setor,
        substr(obter_desc_evento_qua(a.nr_seq_evento),1,50)obter_desc_evento,
        a.NM_USUARIO_ORIGEM

FROM
    qua_evento_paciente a
WHERE
    a.dt_evento BETWEEN TO_DATE(:data_inicio,'dd/mm/yyyy hh24:mi:ss')AND 
                                  fim_dia(TO_DATE(:data_fim,'dd/mm/yyyy hh24:mi:ss'))
ORDER BY 2

-----------------------------------------------------------------------------------
SELECT * from qua_evento_paciente

SELECT * from qua_gravidade_evento

substr(obter_desc_expressao(cd_exp_gravidade, ds_gravidade), 1, 255)
        substr(qua_obter_se_gravid_evento_lib(a.NR_SEQ_GRAVIDADE,a.IE_CLASSIFICACAO),1,80)teste,

--parametro pelo tipo evento
select  x.NR_SEQ_TIPO,
        x.DS_EVENTO
from QUA_EVENTO x
order by 2
-----------------------------------------------------------------------------------
--parametro situacao ativo=a/inativo=i/ambos=1á

select  IE_CLASSIFICACAO
from QUA_EVENTO_PACIENTE a

------------------------------------------------------------------------------------
select	nr_sequencia cd,
	substr(obter_desc_expressao(cd_exp_gravidade, ds_gravidade), 1, 255) ds
from	qua_gravidade_evento
where	ie_situacao = 'A'
and	cd_empresa = 1
and	qua_obter_se_gravid_evento_lib(nr_sequencia,'4') = 'S'
union
select	nr_sequencia cd,
	substr(obter_desc_expressao(cd_exp_gravidade, ds_gravidade), 1, 255) ds
from	qua_gravidade_evento
order by 2


SELECT 
    substr(obter_dados_pf(a.cd_pessoa_fisica),1,255)teste,
    a.CD_PESSOA_FISICA
FROM qua_evento_paciente a 

    substr(obter_nome_convenio(a.cd_convenio),1,255) ds_convenio

/// ---------- SQL original ------------ \\\
 select  a.* 
 ,substr(obter_valor_dominio(3502,ie_status),1,255) DS_STATUS  ,substr(obter_desc_usuario(nm_usuario_origem),1,100) DS_USUARIO_ORIGEM  ,substr((select obter_desc_expressao (CD_EXP_turno, cd_turno) from regra_turno_evento where nr_sequencia = NR_SEQ_TURNO),1,11) DS_TURNO  ,substr(OBTER_PESSOA_ATENDIMENTO(nr_atendimento, 'N'),1,100) NM_PACIENTE  ,substr(obter_nome_pf(cd_profissional),1,255) DS_PROFISSIONAL  ,substr(obter_nome_setor(CD_SETOR_ATENDIMENTO),1,60) DS_SETOR_ATENDIMENTO  ,(select substr(obter_desc_expressao(x.cd_exp_evento, x.ds_evento),1,255) from qua_evento x where x.nr_sequencia = NR_SEQ_EVENTO) DS_QUA_EVENTO  ,substr(obter_descricao_padrao('QUA_EVENTO_CLASSIF','DS_CLASSIFICACAO',NR_SEQ_CLASSIF_EVENTO),1,100) DS_CLASSIF_EVENTO  ,substr(obter_desc_qua_classif_evento(ie_classificacao, :cd_empresa),1,255) DS_CLASSIFICACAO  ,substr(obter_descricao_padrao('QUA_MOTIVO_CANCEL_EV_PAC','DS_MOTIVO_CANCELAMENTO',nr_seq_motivo_cancel),1,255) DS_MOTIVO_CANCELAMENTO  ,(select substr(obter_desc_expressao(x.cd_exp_gravidade, x.ds_gravidade),1,255) from qua_gravidade_evento x where x.nr_sequencia = nr_seq_gravidade) DS_GRAVIDADE  ,substr(obter_desc_setor_atend(cd_setor_analise),1,100) DS_SETOR_ANALISE  ,substr(qua_is_evento_atrasado(nr_sequencia), 1, 3) IE_ATRASADO  ,OBTER_DATA_ASSINATURA_DIGITAL(nr_seq_assinat_inativacao) DT_ASSINATURA_INATIVACAO  ,OBTER_DATA_ASSINATURA_DIGITAL(nr_seq_assinatura) DT_ASSINATURA  ,count(*) over () QT_TOTAL_REGISTROS  ,substr(qua_obter_dados_nao_conform(qua_obter_nao_conform_evento(nr_sequencia),'ST'),1,20) IE_STATUS_RNC_EVENTO  ,substr(obter_se_nao_conform_atrasada(qua_obter_nao_conform_evento(nr_sequencia)),1,1) IE_ACAO_ATRASADA_RNC_EVENTO  ,substr(Qua_Obter_Se_Novo_Hist(qua_obter_nao_conform_evento(nr_sequencia),:nm_usuario_cor),1,1) IE_NOVO_HIST_RNC_EVENTO 
 from QUA_EVENTO_PACIENTE a
Where 1 = 1
 and 1 = 2 
Order by 1

/// ---------- SQL substituído ---------- \\\
 select  a.* 
 ,substr(obter_valor_dominio(3502,ie_status),1,255) DS_STATUS  ,substr(obter_desc_usuario(nm_usuario_origem),1,100) DS_USUARIO_ORIGEM  ,substr((select obter_desc_expressao (CD_EXP_turno, cd_turno) from regra_turno_evento where nr_sequencia = NR_SEQ_TURNO),1,11) DS_TURNO  ,substr(OBTER_PESSOA_ATENDIMENTO(nr_atendimento, 'N'),1,100) NM_PACIENTE  ,substr(obter_nome_pf(cd_profissional),1,255) DS_PROFISSIONAL  ,substr(obter_nome_setor(CD_SETOR_ATENDIMENTO),1,60) DS_SETOR_ATENDIMENTO  ,(select substr(obter_desc_expressao(x.cd_exp_evento, x.ds_evento),1,255) from qua_evento x where x.nr_sequencia = NR_SEQ_EVENTO) DS_QUA_EVENTO  ,substr(obter_descricao_padrao('QUA_EVENTO_CLASSIF','DS_CLASSIFICACAO',NR_SEQ_CLASSIF_EVENTO),1,100) DS_CLASSIF_EVENTO  ,substr(obter_desc_qua_classif_evento(ie_classificacao, 1),1,255) DS_CLASSIFICACAO  ,substr(obter_descricao_padrao('QUA_MOTIVO_CANCEL_EV_PAC','DS_MOTIVO_CANCELAMENTO',nr_seq_motivo_cancel),1,255) DS_MOTIVO_CANCELAMENTO  ,(select substr(obter_desc_expressao(x.cd_exp_gravidade, x.ds_gravidade),1,255) from qua_gravidade_evento x where x.nr_sequencia = nr_seq_gravidade) DS_GRAVIDADE  ,substr(obter_desc_setor_atend(cd_setor_analise),1,100) DS_SETOR_ANALISE  ,substr(qua_is_evento_atrasado(nr_sequencia), 1, 3) IE_ATRASADO  ,OBTER_DATA_ASSINATURA_DIGITAL(nr_seq_assinat_inativacao) DT_ASSINATURA_INATIVACAO  ,OBTER_DATA_ASSINATURA_DIGITAL(nr_seq_assinatura) DT_ASSINATURA  ,count(*) over () QT_TOTAL_REGISTROS  ,substr(qua_obter_dados_nao_conform(qua_obter_nao_conform_evento(nr_sequencia),'ST'),1,20) IE_STATUS_RNC_EVENTO  ,substr(obter_se_nao_conform_atrasada(qua_obter_nao_conform_evento(nr_sequencia)),1,1) IE_ACAO_ATRASADA_RNC_EVENTO  ,substr(Qua_Obter_Se_Novo_Hist(qua_obter_nao_conform_evento(nr_sequencia),'EDUARDOK'),1,1) IE_NOVO_HIST_RNC_EVENTO 
 from QUA_EVENTO_PACIENTE a
Where 1 = 1
 and 1 = 2 
Order by 1

/// ---------- Parâmetro(s) ------------- \\\

cd_empresa     --> 1
nm_usuario_cor --> 'EDUARDOK'


obter_dados_pf(a.cd_pessoa_fisica)nome

/// ---------- SQL original ------------ \\\
 select  a.* 
 ,substr(obter_valor_dominio(3502,ie_status),1,255) DS_STATUS  ,substr(obter_desc_usuario(nm_usuario_origem),1,100) DS_USUARIO_ORIGEM  ,substr((select obter_desc_expressao (CD_EXP_turno, cd_turno) from regra_turno_evento where nr_sequencia = NR_SEQ_TURNO),1,11) DS_TURNO  ,substr(OBTER_PESSOA_ATENDIMENTO(nr_atendimento, 'N'),1,100) NM_PACIENTE  ,substr(obter_nome_pf(cd_profissional),1,255) DS_PROFISSIONAL  ,substr(obter_nome_setor(CD_SETOR_ATENDIMENTO),1,60) DS_SETOR_ATENDIMENTO  ,(select substr(obter_desc_expressao(x.cd_exp_evento, x.ds_evento),1,255) from qua_evento x where x.nr_sequencia = NR_SEQ_EVENTO) DS_QUA_EVENTO  ,substr(obter_descricao_padrao('QUA_EVENTO_CLASSIF','DS_CLASSIFICACAO',NR_SEQ_CLASSIF_EVENTO),1,100) DS_CLASSIF_EVENTO  ,substr(obter_desc_qua_classif_evento(ie_classificacao, :cd_empresa),1,255) DS_CLASSIFICACAO  ,substr(obter_descricao_padrao('QUA_MOTIVO_CANCEL_EV_PAC','DS_MOTIVO_CANCELAMENTO',nr_seq_motivo_cancel),1,255) DS_MOTIVO_CANCELAMENTO  ,(select substr(obter_desc_expressao(x.cd_exp_gravidade, x.ds_gravidade),1,255) from qua_gravidade_evento x where x.nr_sequencia = nr_seq_gravidade) DS_GRAVIDADE  ,substr(obter_desc_setor_atend(cd_setor_analise),1,100) DS_SETOR_ANALISE  ,substr(qua_is_evento_atrasado(nr_sequencia), 1, 3) IE_ATRASADO  ,OBTER_DATA_ASSINATURA_DIGITAL(nr_seq_assinat_inativacao) DT_ASSINATURA_INATIVACAO  ,OBTER_DATA_ASSINATURA_DIGITAL(nr_seq_assinatura) DT_ASSINATURA  ,count(*) over () QT_TOTAL_REGISTROS  ,substr(qua_obter_dados_nao_conform(qua_obter_nao_conform_evento(nr_sequencia),'ST'),1,20) IE_STATUS_RNC_EVENTO  ,substr(obter_se_nao_conform_atrasada(qua_obter_nao_conform_evento(nr_sequencia)),1,1) IE_ACAO_ATRASADA_RNC_EVENTO  ,substr(Qua_Obter_Se_Novo_Hist(qua_obter_nao_conform_evento(nr_sequencia),:nm_usuario_cor),1,1) IE_NOVO_HIST_RNC_EVENTO 
 from QUA_EVENTO_PACIENTE a
Where 1 = 1
 and 1 = 2 
Order by 1

/// ---------- SQL substituído ---------- \\\
 select  a.* 
 ,substr(obter_valor_dominio(3502,ie_status),1,255) DS_STATUS  ,substr(obter_desc_usuario(nm_usuario_origem),1,100) DS_USUARIO_ORIGEM  ,substr((select obter_desc_expressao (CD_EXP_turno, cd_turno) from regra_turno_evento where nr_sequencia = NR_SEQ_TURNO),1,11) DS_TURNO  ,substr(OBTER_PESSOA_ATENDIMENTO(nr_atendimento, 'N'),1,100) NM_PACIENTE  ,substr(obter_nome_pf(cd_profissional),1,255) DS_PROFISSIONAL  ,substr(obter_nome_setor(CD_SETOR_ATENDIMENTO),1,60) DS_SETOR_ATENDIMENTO  ,(select substr(obter_desc_expressao(x.cd_exp_evento, x.ds_evento),1,255) from qua_evento x where x.nr_sequencia = NR_SEQ_EVENTO) DS_QUA_EVENTO  ,substr(obter_descricao_padrao('QUA_EVENTO_CLASSIF','DS_CLASSIFICACAO',NR_SEQ_CLASSIF_EVENTO),1,100) DS_CLASSIF_EVENTO  ,substr(obter_desc_qua_classif_evento(ie_classificacao, 1),1,255) DS_CLASSIFICACAO  ,substr(obter_descricao_padrao('QUA_MOTIVO_CANCEL_EV_PAC','DS_MOTIVO_CANCELAMENTO',nr_seq_motivo_cancel),1,255) DS_MOTIVO_CANCELAMENTO  ,(select substr(obter_desc_expressao(x.cd_exp_gravidade, x.ds_gravidade),1,255) from qua_gravidade_evento x where x.nr_sequencia = nr_seq_gravidade) DS_GRAVIDADE  ,substr(obter_desc_setor_atend(cd_setor_analise),1,100) DS_SETOR_ANALISE  ,substr(qua_is_evento_atrasado(nr_sequencia), 1, 3) IE_ATRASADO  ,OBTER_DATA_ASSINATURA_DIGITAL(nr_seq_assinat_inativacao) DT_ASSINATURA_INATIVACAO  ,OBTER_DATA_ASSINATURA_DIGITAL(nr_seq_assinatura) DT_ASSINATURA  ,count(*) over () QT_TOTAL_REGISTROS  ,substr(qua_obter_dados_nao_conform(qua_obter_nao_conform_evento(nr_sequencia),'ST'),1,20) IE_STATUS_RNC_EVENTO  ,substr(obter_se_nao_conform_atrasada(qua_obter_nao_conform_evento(nr_sequencia)),1,1) IE_ACAO_ATRASADA_RNC_EVENTO  ,substr(Qua_Obter_Se_Novo_Hist(qua_obter_nao_conform_evento(nr_sequencia),'EDUARDOK'),1,1) IE_NOVO_HIST_RNC_EVENTO 
 from QUA_EVENTO_PACIENTE a
Where 1 = 1
 and 1 = 2 
Order by 1

/// ---------- Parâmetro(s) ------------- \\\

cd_empresa     --> 1
nm_usuario_cor --> 'EDUARDOK'


SELECT
    substr(obter_valor_dominio(3502,ie_status),1,255)ds_status
    substr(obter_descricao_padrao('MED_TIPO_AVALIACAO','DS_TIPO',nr_seq_tipo_avaliacao),1,40) DS_TIPO_AVALIACAO 
FROM
    qua_evento_paciente a,
    QUA_EVENTO_PAC_AVAL b
WHERE
    a.dt_evento BETWEEN TO_DATE(:data_inicio,'dd/mm/yyyy hh24:mi:ss')AND 
                                  fim_dia(TO_DATE(:data_fim,'dd/mm/yyyy hh24:mi:ss'))
-----------------------------------------------------------------------------------
--parametro pelo tipo evento
select  x.NR_SEQ_TIPO,
        x.DS_EVENTO
from QUA_EVENTO x
order by 2
-----------------------------------------------------------------------------------
--parametro situacao ativo=a/inativo=i/ambos=1á

select  IE_CLASSIFICACAO
from QUA_EVENTO_PACIENTE a

------------------------------------------------------------------------------------



SELECT 
    substr(obter_dados_pf(a.cd_pessoa_fisica),1,255)teste,
    a.CD_PESSOA_FISICA
FROM qua_evento_paciente a 

    substr(obter_nome_convenio(a.cd_convenio),1,255) ds_convenio



obter_dados_pf(a.cd_pessoa_fisica)nome


select	nr_sequencia,
	dt_recebimento,
	substr(obter_nome_pf_pj(null,cd_cgc),1,100) ds_fornecedor,
	cd_material,
	substr(obter_desc_material(cd_material),1,255) ds_material,
	substr(obter_nome_pf_pj(cd_pessoa_responsavel,null),1,100) ds_responsavel,
	nr_ordem_compra,
	to_date(obter_data_ordem_compra(nr_ordem_compra,'O')) dt_ordem_compra,
	campo_mascara_virgula(obter_quantidade_oci(nr_ordem_compra, nr_item_oci)) qt_item_ordem,
	campo_mascara_virgula(obter_valor_unitario_oci(nr_ordem_compra, nr_item_oci)) vl_item_ordem,
	nr_nota_fiscal,
	qt_inspecao,
	vl_unitario_material,
	to_date(obter_data_ordem_compra(nr_ordem_compra,'E')) dt_entrega,
	ds_lote_fornec,
	dt_validade,
	ie_temperatura,
	ie_interno,
	ie_externo,
	ie_laudo,
	substr(obter_valor_dominio(1639,ie_motivo_devolucao),1,100) ds_motivo_dev,
	ds_observacao,
	ds_justificativa
from	inspecao_recebimento
where	dt_recebimento between :dt_inicial and fim_dia(:dt_final)
--and	(cd_cgc			= nvl(:cd_cgc,0) or nvl(:cd_cgc,0) = 0)
--and	(nr_ordem_compra	= nvl(:nr_ordem_compra,0) or nvl(:nr_ordem_compra,0) = 0)
--and	(nr_nota_fiscal	= :nr_nota_fiscal or :nr_nota_fiscal = 0 or :nr_nota_fiscal is null)
--and	((:ie_conforme = 'T') or (:ie_conforme = 'N' and nr_seq_tipo_nao_conf hh24) or (:ie_conforme = 'S' and nr_seq_tipo_nao_conf is null))
--and	((:ie_devolucao = 'T') or (:ie_devolucao = 'N' and ie_motivo_devolucao is null) or (:ie_devolucao = 'S' and ie_motivo_devolucao hh24))
--and	((:ie_urgente = 'T') or
--	((:ie_urgente = 'S') and (obter_dados_ordem_compra(nr_ordem_compra,'U') = 'S')) or
--	((:ie_urgente = 'N') and (obter_dados_ordem_compra(nr_ordem_compra,'U') = 'N')))
order by 	decode(:ie_ordem,'D',substr(to_char(dt_recebimento,'yyyy/mm/dd'),1,100),
		'F',substr(obter_nome_pf_pj(null,cd_cgc),1,100),
		'M',substr(obter_desc_material(cd_material),1,100)),
	decode(:ie_ordem,
		'D',substr(obter_nome_pf_pj(null,cd_cgc),1,100),
		'F',substr(obter_desc_material(cd_material),1,100),
		'M',substr(obter_nome_pf_pj(null,cd_cgc),1,100)),
	decode(:ie_ordem,
		'D',substr(obter_desc_material(cd_material),1,100),
		'F',substr(to_char(dt_recebimento,'yyyy/mm/dd'),1,100),
		'M',substr(to_char(dt_recebimento,'yyyy/mm/dd'),1,100))
        
        
        ORDER BY decode(:ie_ordem,
		'D',TO_CHAR(dt_entrada_unidade),
		'N',TO_CHAR(nm_paciente),
		'P',TO_CHAR(QT_PONTUACAO))
		
		
		
select COUNT(a.CD_CGC) from INSPECAO_RECEBIMENTO a

select * from INSPECAO_RECEBIMENTO

select DISTINCT 
       substr(obter_nome_pf_pj(null,a.cd_cgc),1,100) ds_fornecedor,
       COUNT(a.CD_CGC),
       a.NR_SEQUENCIA,
       A.NR_ORDEM_COMPRA,
       a.nr_ordem_compra,
       a.DT_RECEBIMENTO,
       obter_desc_tipo_divergencia(b.nr_sequencia),
       b.IE_MOTIVO_ACEITE,
       b.IE_GERACAO,
       b.CD_PESSOA_RESP_JUSTIF
from INSPECAO_RECEBIMENTO a,
     INSPECAO_DIVERGENCIA b
where	dt_recebimento between :dt_inicial and fim_dia(:dt_final) 
and a.CD_MATERIAL = b.CD_MATERIAL
order by 1

SELECT 
       A.*,
       B.DS_CATEGORIA_CID,
       C.CD_ESPECIALIDADE_CID,
       C.DS_ESPECIALIDADE_CID
FROM   CID_ESPECIALIDADE C,
       CID_CATEGORIA B,
       CID_DOENCA A
WHERE A.CD_CATEGORIA_CID = B.CD_CATEGORIA_CID
  AND B.CD_ESPECIALIDADE = C.CD_ESPECIALIDADE_CID(+)
  AND NVL(A.IE_SITUACAO,'A') = 'A'
  and nvl(b.ie_situacao,'A') = 'A'
  and nvl(c.ie_situacao,'A') = 'A'
  --AND (upper(A.CD_DOENCA_CID) like '%B06%') 
  AND IN (B06)

ORDER BY A.DS_DOENCA_CID

SELECT 
        distinct(a.NR_ATENDIMENTO),
        c.cd_setor_atendimento,
        a.CD_DOENCA,
        a.CD_MEDICO,
        a.DT_DIAGNOSTICO,
        a.IE_TIPO_DIAGNOSTICO,
        obter_ds

FROM
    diagnostico_doenca a,  --vincula atendimento       
    ATENDIMENTO_PACIENTE b,  --vincula código pessoa com tabela pessoa  e atendi                 
    ATEND_PACIENTE_UNIDADE c,
    PESSOA_FISICA d
where b.dt_entrada BETWEEN TO_DATE(:data_inicio,'dd/mm/yyyy hh24:mi:ss')
AND                fim_dia(TO_DATE(:data_fim,'dd/mm/yyyy hh24:mi:ss'))
AND cd_doenca = any('B05','B06','P350','R50','R21')
and a.NR_ATENDIMENTO = b.NR_ATENDIMENTO
and d.cd_pessoa_fisica = b.cd_pessoa_fisica



select * from ATENDIMENTO_PACIENTE;
select * from diagnostico_doenca;



select	count(*) qt_atendimentos,
	substr(obter_descricao_padrao('SUS_MUNICIPIO','DS_MUNICIPIO',b.cd_municipio_ibge),1,254) ds_municipio,
	b.ds_bairro,
	s.ds_setor_atendimento
from	compl_pessoa_fisica b,
	setor_atendimento s,
	atend_paciente_unidade c,
	atendimento_paciente a
where	trunc(a.dt_entrada, 'dd') between :dt_inicial and :dt_final
and	a.cd_pessoa_fisica 		= b.cd_pessoa_fisica
and	s.cd_setor_atendimento	= c.cd_setor_atendimento
and	b.ie_tipo_complemento 	= 1
and	a.nr_atendimento 		= c.nr_atendimento
group by 	substr(obter_descricao_padrao('SUS_MUNICIPIO','DS_MUNICIPIO',b.cd_municipio_ibge),1,254),
	b.ds_bairro,
	s.ds_setor_atendimento
order by	ds_municipio, ds_bairro, ds_setor_atendimento


select	
substr(nvl(upper(obter_compl_pf(a.cd_pessoa_fisica, 1, 'UF')),'Não Informado'),1,50) ie_estado,	
	substr(nvl(obter_compl_pf(a.cd_pessoa_fisica, 1, 'DM'),'Não Informado'),1,50) ds_municipio, 
	decode(upper(obter_compl_pf(a.cd_pessoa_fisica, 1, 'UF')),null,'B','A') ds_ordem1,
	decode(obter_compl_pf(a.cd_pessoa_fisica, 1, 'DM'),null,'B','A') ds_ordem2,
	count(distinct a.nr_atendimento) qt_atend_municipio,
	count(distinct a.cd_pessoa_fisica) qt_pac_municipio
from	atendimento_paciente a 
where	a.dt_entrada between :dt_inicial and fim_dia(:dt_final) 
and	(a.cd_estabelecimento = :cd_estabelecimento_p or :cd_estabelecimento_p = 0)
group by
	obter_compl_pf(a.cd_pessoa_fisica, 1, 'DM'),
	upper(obter_compl_pf(a.cd_pessoa_fisica, 1, 'UF'))
order by
	ds_ordem1,
	ie_estado,
	ds_ordem2,
	ds_municipio
    
SELECT
    COUNT(DISTINCT cd_pessoa_fisica) pessoas_atendidas,
    COUNT(DISTINCT nr_atendimento)   numero_atendimentos,
    to_char(dt_entrada,'yyyy')ano,
    ie_tipo_atendimento,
    ie_tipo_convenio
FROM
    atendimento_paciente
WHERE
    dt_entrada BETWEEN TO_DATE(:data_inicio,'dd/mm/yyyy hh24:mi:ss')AND fim_dia(TO_DATE(:data_fim,'dd/mm/yyyy hh24:mi:ss'))
group by ie_tipo_atendimento

select * from diagnostico_doenca where cd_doenca = any('B05','B06','P350','R50','R21')
select * from ATENDIMENTO_PACIENTE
--select * from cid_doenca where  cd_doenca_cid = any('B05','BO6','P350','R50','R21')
select * from ATEND_PACIENTE_UNIDADE;

SELECT distinct(a.NR_ATENDIMENTO),
        a.CD_DOENCA,
        a.CD_MEDICO,
        a.DT_DIAGNOSTICO,
        a.IE_TIPO_DIAGNOSTICO,
            b.IE_TIPO_ATENDIMENTO,
            b.CD_MEDICO_RESP,
                d.CD_SETOR_ATENDIMENTO,
                d.DT_ENTRADA_UNIDADE,
                d.DT_SAIDA_UNIDADE,
                substr(obter_nome_setor(d.cd_setor_atendimento),1,254) ds_setor_atendimento
FROM
    diagnostico_doenca a,  --vincula atendimento       
    ATENDIMENTO_PACIENTE b,                    
    ATEND_PACIENTE_UNIDADE c

where b.dt_entrada BETWEEN TO_DATE(:data_inicio,'dd/mm/yyyy hh24:mi:ss')AND fim_dia(TO_DATE(:data_fim,'dd/mm/yyyy hh24:mi:ss'))
and	a.cd_pessoa_fisica 		= b.cd_pessoa_fisica
and a.cd_doenca = any('B05','B06','P350','R50','R21')
and a.NR_ATENDIMENTO = b.NR_ATENDIMENTO
and a.NR_ATENDIMENTO = d.NR_ATENDIMENTO
and b.NR_ATENDIMENTO = d.NR_ATENDIMENTO

/*Solicito criar uma opção de relatorio para monitorar o protocolo de proteção renal, 
conforme Chimene havia conversado com Edson na elaboração do mesmo, seria: Nº de exames 
contrastados INTERNADOS mensalmente X relatório das EVoluções.*/ 1694

select *
from EVOLUCAO_PACIENTE;

SELECT * FROM TIPO_EVOLUCAO

select *
from EVOLUCAO_PACIENTE;
--EVOLUÇÃO 
----------------------------------------
select 
DISTINCT NR_ATENDIMENTO,
OBTER_NOME_PF(CD_PESSOA_FISICA) nm_paciente,
DT_EVOLUCAO,
NM_USUARIO
CD_MEDICO,
IE_TIPO_EVOLUCAO,
IE_EVOLUCAO_CLINICA
from EVOLUCAO_PACIENTE
where DT_EVOLUCAO between :dt_inicial and fim_dia(:dt_final)
AND IE_EVOLUCAO_CLINICA LIKE ('REN')
AND IE_SITUACAO = 'A'
ORDER BY 2, 3

select DISTINCT NR_ATENDIMENTO,
OBTER_NOME_PF(CD_PESSOA_FISICA) nm_paciente
from EVOLUCAO_PACIENTE
where DT_EVOLUCAO between :dt_inicial and fim_dia(:dt_final)
AND IE_EVOLUCAO_CLINICA LIKE ('REN')
AND IE_SITUACAO = 'A'
order by 1


DS_TIPO_ATEND

--SELEÇÃO TIPO EVOLUÇÃO
select * from cih_tipo_evolucao

--SELEÇÃO TIPO DESCRIÇÃO CLINICA
select * from  cih_clinica


SELECT DISTINCT(a.nr_ficha_ocorrencia),
       ('<b>Reg. Hospital: </b>' || a.nr_atendimento)  nr_atendimento,
       a.ds_diagnostico_int,
       a.dt_entrada,
       a.dt_alta,
      ('<b>(' || ROUND(a.dt_alta - a.dt_entrada) || ') dias </b>')  nr_dias,
       OBTER_NOME_PF(b.CD_PESSOA_FISICA)  nm_medico,
       OBTER_NOME_PF(d.CD_PESSOA_FISICA) nm_paciente,
       d.ie_sexo,
       d.dt_nascimento,
       c.ds_tipo_evolucao
FROM cih_tipo_evolucao c,
        pessoa_fisica b,
        pessoa_fisica d,
        cih_local_infeccao z,
        cih_ficha_ocorrencia_v a,
        cih_clinica e,
         cih_topografia m
WHERE z.nr_ficha_ocorrencia = a.nr_ficha_ocorrencia
AND  a.cd_medico           = b.cd_pessoa_fisica
AND   a.cd_pessoa_fisica    = d.cd_pessoa_fisica
AND   a.cd_tipo_evolucao    = c.cd_tipo_evolucao
--AND   z.cd_caso_infeccao    = 1
--AND   DECODE(:tp_data, 'A', a.dt_alta, 'R', a.dt_ficha, 'I' , z.dt_infeccao) BETWEEN TRUNC(:dt_inicial) AND fim_dia(:dt_final)
--AND   ((:cd_medico = a.cd_medico) OR (:cd_medico = 0))
--AND  ((:cd_estabelecimento = a.cd_estabelecimento) OR (:cd_estabelecimento = 0))
--AND  ((:cd_clinica = a.cd_clinica) OR (:cd_clinica = 0))
ORDER BY nm_paciente



select * from Gestao_exame_WCP
CREATE OR REPLACE
FORCE VIEW "TASY"."EIS_CENSO_DIARIO_V2" ("DS_FAIXA_ETARIA",
                                         "DS_IDADE",
                                         "CD_IDADE",
                                         "CD_CONVENIO",
                                         "CD_ESTABELECIMENTO",
                                         "IE_PERIODO",
                                         "CD_TIPO_ACOMODACAO",
                                         "CD_SETOR_ATENDIMENTO",
                                         "IE_CLINICA",
                                         "DT_REFERENCIA",
                                         "CD_MEDICO",
                                         "NM_PESSOA_FISICA",
                                         "NM_PACIENTE",
                                         "IE_SITUACAO",
                                         "CD_PROCEDENCIA",
                                         "IE_TIPO_ATENDIMENTO",
                                         "QT_HORA_ALTA",
                                         "IE_CLINICA_ALTA",
                                         "NR_SEQ_ORIGEM",
                                         "IE_SEXO",
                                         "CD_CID_PRINCIPAL",
                                         "CD_CATEGORIA_CID",
                                         "DS_CID_PRINCIPAL",
                                         "DS_CATEGORIA_CID",
                                         "DS_REFERENCIA",
                                         "CD_DIA",
                                         "NR_PACIENTES",
                                         "NR_PAC_DIA",
                                         "QT_TEMP",
                                         "NR_ADMISSOES",
                                         "NR_ALTAS",
                                         "NR_OBITOS",
                                         "NR_TRANSF_ENTRADA",
                                         "NR_TRANSF_SAIDA",
                                         "NR_TRANSF_ENT_INT",
                                         "NR_TRANSF_ENT_EXT",
                                         "NR_TRANSF_SAIDA_INT",
                                         "NR_TRANSF_SAIDA_EXT",
                                         "QT_ADMITIDO_ALTA_DIA",
                                         "HR_ALTA",
                                         "IE_TIPO_CONVENIO",
                                         "CD_ESPECIALIDADE",
                                         "QT_LEITO_LIVRE",
                                         "CD_PROCEDIMENTO",
                                         "DS_PROCEDIMENTO",
                                         "DS_ESTABELECIMENTO",
                                         "DS_MOTIVO_ALTA",
                                         "CD_MOTIVO_ALTA",
                                         "CD_EMPRESA",
                                         "CD_CLASSIF_ETARIA",
                                         "DS_CLASSIF_ETARIA",
                                         "CD_ESTABELECIMENTO_BASE",
                                         "CD_MUNICIPIO_IBGE",
                                         "NR_SEQ_QUEIXA",
                                         "DS_QUEIXA",
                                         "CD_CATEGORIA",
                                         "DS_CATEGORIA",
                                         "NR_SEQ_FORMA_CHEGADA",
                                         "DS_FORMA_CHEGADA",
                                         "NR_HORARIO",
                                         "CD_CONVENIO_GLOSA",
                                         "CD_CATEGORIA_GLOSA",
                                         "DS_CONVENIO_GLOSA",
                                         "DS_CATEGORIA_GLOSA",
                                         "DS_INDICACAO",
                                         "NR_SEQ_INDICACAO",
                                         "CD_PESSOA_FISICA",
                                         "IE_CARATER_INTER_SUS",
                                         "DS_CARATER_ATEND",
                                         "CD_EMPRESA_CONV",
                                         "DS_EMPRESA_CONV",
                                         "DS_AGRUPAMENTO",
                                         "NR_SEQ_AGRUPAMENTO",
                                         "NR_SEQ_CLASSIFICACAO",
                                         "DS_GRUPO",
                                         "DS_SUBGRUPO",
                                         "DS_FORMA_ORGANIZACAO",
                                         "DS_GRUPO_PROC",
                                         "DS_AREA_PROC",
                                         "DS_ESPECIALIDADE_PROC",
                                         "CD_GRUPO",
                                         "CD_SUBGRUPO",
                                         "CD_FORMA_ORGANIZACAO",
                                         "CD_GRUPO_PROC",
                                         "CD_AREA_PROC",
                                         "CD_ESPECIALIDADE_PROC",
                                         "CD_PROCED_PRINCIPAL",
                                         "DS_PROCED_PRINCIPAL",
                                         "DS_CLASSIF_ATEND",
                                         "DS_ESTADO_CIVIL",
                                         "NR_CONTROL",
                                         "DT_ENTRADA",
                                         "DT_ALTA") AS


SELECT --substr(obter_idade(b.dt_nascimento, sysdate, 'E'),1,50) ds_faixa_etaria, (Dalcastagne 25/10/06 - Substitui pela linha abaixo )
 substr(eis_obter_faixa_etaria(TO_NUMBER(obter_idade_pf(a.cd_pessoa_fisica, sysdate, 'A'))), 1, 50) ds_faixa_etaria,
 substr(lpad(obter_idade_pf(a.cd_pessoa_fisica, sysdate, 'A'), 3, '0'), 1, 50) ds_idade,
 TO_NUMBER(obter_idade_pf(a.cd_pessoa_fisica, sysdate, 'A')) cd_idade,
 a.cd_convenio,
 a.cd_estabelecimento,
 a.ie_periodo,
 a.cd_tipo_acomodacao,
 a.cd_setor_atendimento,
 a.ie_clinica,
 a.dt_referencia,
 nvl(a.cd_medico, '0') cd_medico,
 obter_nome_pf(a.cd_medico) nm_pessoa_fisica,
 obter_nome_pf(a.cd_pessoa_fisica) nm_paciente,
 a.ie_situacao,
 a.cd_procedencia,
 a.ie_tipo_atendimento,
 TO_NUMBER(to_char(a.hr_alta, '00')) qt_hora_alta,
 a.ie_clinica_alta,
 a.nr_seq_origem,
 obter_sexo_pf(a.cd_pessoa_fisica, 'C') ie_sexo,
 a.cd_cid_principal,
 obter_categoria_cid(a.cd_cid_principal) cd_categoria_cid,
 decode(a.cd_cid_principal, NULL, 
 obter_texto_tasy(1098949, NULL), '(' || cd_cid_principal || ')' || ' - ' || substr(obter_desc_cid(a.cd_cid_principal), 1, 200)) ds_cid_principal,
 substr(obter_desc_categoria_cid(obter_categoria_cid(a.cd_cid_principal)), 1, 255) ds_categoria_cid,
 to_char(a.dt_referencia, 'dd/mm/yyyy') ds_referencia,
 TO_NUMBER(to_char(a.dt_referencia, 'd')) cd_dia,
 SUM(decode(a.ie_periodo, 'D', nr_pacientes, 0)) nr_pacientes,
 SUM(decode(obter_se_unidade_temp(a.cd_setor_atendimento, a.dt_referencia, a.cd_unidade_basica, a.cd_unidade_compl), 'N', (decode(a.ie_situacao, 'P', nr_pacientes, 0)), (decode(a.cd_pessoa_fisica, NULL, 0, nr_pacientes)))) nr_pac_dia, -- Era assim : (decode(a.cd_pessoa_fisica, null, 0, 1)))) OS 90712
 SUM(decode(obter_se_unidade_temp(a.cd_setor_atendimento, a.dt_referencia, a.cd_unidade_basica, a.cd_unidade_compl), 'S', 1, 0)) qt_temp,
 SUM(nr_admissoes) nr_admissoes,
 SUM(nr_altas) nr_altas,
 SUM(nr_obitos) nr_obitos,
 SUM(nr_transf_entrada) nr_transf_entrada,
 SUM(nr_transf_saida) nr_transf_saida,
 SUM(nr_transf_ent_interna) nr_transf_ent_int,
 SUM(nr_transf_ent_externa) nr_transf_ent_ext,
 SUM(nr_transf_saida_interna) nr_transf_saida_int,
 SUM(nr_transf_saida_externa) nr_transf_saida_ext,
 SUM(qt_admitido_alta_dia) qt_admitido_alta_dia,
 a.hr_alta,
 obter_tipo_convenio(a.cd_convenio) ie_tipo_convenio,
 obter_especialidade_medico(a.cd_medico, 'C') cd_especialidade,
 SUM(qt_leito_livre) qt_leito_livre,
 cd_procedimento,
 substr(obter_descricao_procedimento(cd_procedimento, ie_origem_proced), 1, 100) ds_procedimento,
 substr(obter_nome_estabelecimento(a.cd_estabelecimento), 1, 80) ds_estabelecimento,
 substr(obter_desc_motivo_alta(a.cd_motivo_alta), 1, 255) ds_motivo_alta,
 a.cd_motivo_alta,
 a.cd_empresa,
 obter_classif_etaria(a.cd_estabelecimento, a.cd_pessoa_fisica, 'C') cd_classif_etaria,
 obter_valor_dominio(1698, obter_classif_etaria(a.cd_estabelecimento, a.cd_pessoa_fisica, 'C')) ds_classif_etaria,
 c.cd_estabelecimento_base,
 substr(nvl(obter_compl_pf(a.cd_pessoa_fisica, 1, 'CDM'), NULL), 1, 100) cd_municipio_ibge,
 a.nr_seq_queixa,
 substr(nvl(obter_desc_queixa(a.nr_seq_queixa), obter_texto_tasy(1098949, NULL)), 1, 255) ds_queixa,
 a.cd_categoria,
 substr(obter_nome_convenio(a.cd_convenio) || ' - ' || obter_categoria_convenio(a.cd_convenio, a.cd_categoria), 1, 200) ds_categoria,
 a.nr_seq_forma_chegada,
 substr(nvl(obter_desc_forma_chegada(a.nr_seq_forma_chegada), obter_texto_tasy(1098949, NULL)), 1, 255) ds_forma_chegada,
 TO_NUMBER(to_char(a.dt_entrada, 'hh24')) nr_horario,
 nvl(a.cd_convenio_glosa, 0) cd_convenio_glosa,
 a.cd_categoria_glosa,
 substr(nvl(obter_nome_convenio(a.cd_convenio_glosa), obter_texto_tasy(1098949, NULL)), 1, 100) ds_convenio_glosa,
 substr(nvl(obter_categoria_convenio(a.cd_convenio_glosa, a.cd_categoria_glosa), obter_texto_tasy(1098949, NULL)), 1, 200) ds_categoria_glosa,
 substr(nvl(obter_desc_indicacao(a.nr_seq_indicacao), obter_texto_tasy(1098949, NULL)), 1, 100) ds_indicacao,
 a.nr_seq_indicacao,
 a.cd_pessoa_fisica,
 a.ie_carater_inter_sus,
 substr(nvl(sus_obter_desc_carater_atend(a.ie_carater_inter_sus), obter_texto_tasy(1098949, NULL)), 1, 100) ds_carater_atend,
 a.cd_empresa_conv,
 substr(nvl(obter_nome_emp_ref(a.cd_empresa_conv), obter_texto_tasy(1098949, NULL)), 1, 100) ds_empresa_conv,
 decode(c.nr_seq_agrupamento, '', obter_texto_tasy(793289, NULL), substr(obter_desc_agrup_setor(c.nr_seq_agrupamento), 1, 50)) ds_agrupamento,
 nvl(c.nr_seq_agrupamento, 0) nr_seq_agrupamento,
 a.nr_seq_classificacao,
 substr(sus_obter_desc_grupo(a.cd_grupo), 1, 40) ds_grupo,
 substr(sus_obter_desc_subgrupo(a.cd_subgrupo), 1, 40) ds_subgrupo,
 substr(sus_obter_desc_forma_org(a.cd_forma_organizacao), 1, 40) ds_forma_organizacao,
 substr(obter_desc_grupo_proc(a.cd_grupo_proc), 1, 40) ds_grupo_proc,
 substr(obter_desc_area_procedimento(a.cd_area_proc), 1, 40) ds_area_proc,
 substr(obter_desc_especialidade_proc(a.cd_especialidade_proc), 1, 40) ds_especialidade_proc,
 a.cd_grupo,
 a.cd_subgrupo,
 a.cd_forma_organizacao,
 a.cd_grupo_proc,
 a.cd_area_proc,
 a.cd_especialidade_proc,
 a.cd_proced_principal,
 substr(obter_descricao_procedimento(a.cd_proced_principal, a.ie_origem_proced_princ), 1, 100) ds_proced_principal,
 substr(obter_desc_classif_atend(a.nr_seq_classificacao), 1, 255) ds_classif_atend,
 substr(obter_valor_dominio(5, obter_dados_pf(a.cd_pessoa_fisica, 'EC')), 1, 15) ds_estado_civil,
 substr(obter_dados_sus_municipio(x.cd_municipio_ibge, 'NC'), 1, 255) nr_control,
 a.dt_entrada,
 a.dt_alta
FROM setor_atendimento c,
     eis_ocupacao_hospitalar a,
     compl_pessoa_fisica x
WHERE a.cd_setor_atendimento = c.cd_setor_atendimento
  AND a.cd_pessoa_fisica = x.cd_pessoa_fisica (+)
  AND x.ie_tipo_complemento (+) = 1
GROUP BY 
         substr(eis_obter_faixa_etaria(TO_NUMBER(obter_idade_pf(a.cd_pessoa_fisica, sysdate, 'A'))), 1, 50),
         substr(lpad(obter_idade_pf(a.cd_pessoa_fisica, sysdate, 'A'), 3, '0'), 1, 50),
         TO_NUMBER(obter_idade_pf(a.cd_pessoa_fisica, sysdate, 'A')),
         a.cd_convenio,
         a.cd_pessoa_fisica,
         a.cd_estabelecimento,
         a.ie_periodo,
         a.cd_tipo_acomodacao,
         a.cd_setor_atendimento,
         to_char(a.dt_referencia, 'dd/mm/yyyy'),
         a.ie_clinica,
         a.cd_cid_principal,
         obter_categoria_cid(a.cd_cid_principal),
         substr(obter_desc_cid(a.cd_cid_principal), 1, 200) || ' - ' || '(' || cd_cid_principal || ')',
         substr(obter_desc_categoria_cid(obter_categoria_cid(a.cd_cid_principal)), 1, 255),
         TO_NUMBER(to_char(a.dt_referencia, 'd')),
         a.dt_referencia,
         nvl(a.cd_medico, '0'),
         a.ie_situacao,
         a.cd_procedencia,
         a.ie_tipo_atendimento,
         TO_NUMBER(to_char(a.hr_alta, '00')),
         a.nr_seq_origem,
         obter_sexo_pf(a.cd_pessoa_fisica, 'C'),
         a.ie_clinica_alta,
         a.hr_alta,
         obter_tipo_convenio(a.cd_convenio),
         obter_especialidade_medico(a.cd_medico, 'C'),
         obter_nome_pf(a.cd_medico),
         cd_procedimento,
         substr(obter_descricao_procedimento(cd_procedimento, ie_origem_proced), 1, 100),
         substr(obter_nome_estabelecimento(a.cd_estabelecimento), 1, 80),
         substr(obter_desc_motivo_alta(a.cd_motivo_alta), 1, 255),
         a.cd_motivo_alta,
         a.cd_empresa,
         obter_classif_etaria(a.cd_estabelecimento, a.cd_pessoa_fisica, 'C'),
         obter_valor_dominio(1698, obter_classif_etaria(a.cd_estabelecimento, a.cd_pessoa_fisica, 'C')),
         c.cd_estabelecimento_base,
         substr(nvl(obter_compl_pf(a.cd_pessoa_fisica, 1, 'CDM'), NULL), 1, 100),
         a.nr_seq_queixa,
         substr(nvl(obter_desc_queixa(a.nr_seq_queixa), obter_texto_tasy(1098949, NULL)), 1, 255),
         a.cd_categoria,
         substr(obter_nome_convenio(a.cd_convenio) || ' - ' || obter_categoria_convenio(a.cd_convenio, a.cd_categoria), 1, 200),
         a.nr_seq_forma_chegada,
         substr(nvl(obter_desc_forma_chegada(a.nr_seq_forma_chegada), obter_texto_tasy(1098949, NULL)), 1, 255),
         TO_NUMBER(to_char(a.dt_entrada, 'hh24')),
         nvl(a.cd_convenio_glosa, 0),
         a.cd_categoria_glosa,
         substr(nvl(obter_nome_convenio(a.cd_convenio_glosa), obter_texto_tasy(1098949, NULL)), 1, 100),
         substr(nvl(obter_categoria_convenio(a.cd_convenio_glosa, a.cd_categoria_glosa), obter_texto_tasy(1098949, NULL)), 1, 200),
         substr(nvl(obter_desc_indicacao(a.nr_seq_indicacao), obter_texto_tasy(1098949, NULL)), 1, 100),
         a.nr_seq_indicacao,
         a.cd_pessoa_fisica,
         a.ie_carater_inter_sus,
         substr(nvl(sus_obter_desc_carater_atend(a.ie_carater_inter_sus), obter_texto_tasy(1098949, NULL)), 1, 100),
         a.cd_empresa_conv, --substr(nvl(obter_nome_empresa(a.cd_empresa_conv),obter_texto_tasy(1098949,null)),1,100),
         decode(c.nr_seq_agrupamento, '', obter_texto_tasy(793289, NULL), 
         substr(obter_desc_agrup_setor(c.nr_seq_agrupamento), 1, 50)),nvl(c.nr_seq_agrupamento, 0),
         a.nr_seq_classificacao,
         substr(sus_obter_desc_grupo(a.cd_grupo), 1, 40),
         substr(sus_obter_desc_subgrupo(a.cd_subgrupo), 1, 40),
         substr(sus_obter_desc_forma_org(a.cd_forma_organizacao), 1, 40),
         substr(obter_desc_grupo_proc(a.cd_grupo_proc), 1, 40),
         substr(obter_desc_area_procedimento(a.cd_area_proc), 1, 40),
         substr(obter_desc_especialidade_proc(a.cd_especialidade_proc), 1, 40),
         a.cd_grupo,
         a.cd_subgrupo,
         a.cd_forma_organizacao,
         a.cd_grupo_proc,
         a.cd_area_proc,
         a.cd_especialidade_proc,
         a.cd_proced_principal,
         substr(obter_descricao_procedimento(a.cd_proced_principal, a.ie_origem_proced_princ), 1, 100),
         substr(obter_valor_dominio(5, obter_dados_pf(a.cd_pessoa_fisica, 'EC')), 1, 15),
         substr(obter_dados_sus_municipio(x.cd_municipio_ibge, 'NC'), 1, 255),
         a.dt_entrada,
         a.dt_alta
UNION
SELECT substr(eis_obter_faixa_etaria(TO_NUMBER(obter_idade_pf(a.cd_pessoa_fisica, sysdate, 'A'))), 1, 50),
       substr(lpad(obter_idade_pf(a.cd_pessoa_fisica, sysdate, 'A'), 3, '0'), 1, 50),
       TO_NUMBER(obter_idade_pf(a.cd_pessoa_fisica, sysdate, 'A')),
       a.cd_convenio,
       a.cd_estabelecimento,
       'M',
       a.cd_tipo_acomodacao,
       a.cd_setor_atendimento,
       a.ie_clinica,
       a.dt_referencia,
       nvl(a.cd_medico, '0') cd_medico,
       obter_nome_pf(a.cd_medico) nm_pessoa_fisica,
       obter_nome_pf(a.cd_pessoa_fisica) nm_paciente,
       a.ie_situacao,
       a.cd_procedencia,
       a.ie_tipo_atendimento,
       TO_NUMBER(to_char(a.hr_alta, '00')),
       a.ie_clinica_alta,
       a.nr_seq_origem,
       obter_sexo_pf(a.cd_pessoa_fisica, 'C') ie_sexo,
       a.cd_cid_principal,
       obter_categoria_cid(a.cd_cid_principal) cd_categoria_cid,
       decode(a.cd_cid_principal, NULL, obter_texto_tasy(1098949, NULL), '(' || cd_cid_principal || ')' || ' - ' || substr(obter_desc_cid(a.cd_cid_principal), 1, 200)) ds_cid_principal,
       substr(obter_desc_categoria_cid(obter_categoria_cid(a.cd_cid_principal)), 1, 255) ds_categoria_cid,
       to_char(a.dt_referencia, 'dd/mm/yyyy'),
       TO_NUMBER(to_char(a.dt_referencia, 'd')) cd_dia,
       SUM(decode(greatest(last_day(a.dt_referencia), trunc(sysdate, 'dd')), trunc(sysdate, 'dd'), decode(trunc(a.dt_referencia, 'mm'), a.dt_referencia, 
       decode(a.ie_periodo, 'M', nr_pacientes, 0), 0), decode(greatest(trunc(a.dt_referencia, 'dd'), trunc(sysdate, 'dd') - 1), trunc(sysdate, 'dd') - 1, decode(a.ie_periodo, 'D', nr_pacientes, 0), 0))) nr_pacientes, /* Com Elemar em 04/03/2008 , corrigido por spkoth em 17/11/2015 - OS958276*/ 0 nr_pac_dia,
       
       SUM(decode(obter_se_unidade_temp(a.cd_setor_atendimento, a.dt_referencia, a.cd_unidade_basica, a.cd_unidade_compl), 'S', 1, 0)) qt_temp,
       a.dt_alta
FROM setor_atendimento c,
     eis_ocupacao_hospitalar a,
     compl_pessoa_fisica x
WHERE a.cd_setor_atendimento = c.cd_setor_atendimento
  AND a.cd_pessoa_fisica = x.cd_pessoa_fisica (+)
  AND x.ie_tipo_complemento (+) = 1
GROUP BY substr(eis_obter_faixa_etaria(TO_NUMBER(obter_idade_pf(a.cd_pessoa_fisica, sysdate, 'A'))), 1, 50),
         substr(lpad(obter_idade_pf(a.cd_pessoa_fisica, sysdate, 'A'), 3, '0'), 1, 50),
         TO_NUMBER(obter_idade_pf(a.cd_pessoa_fisica, sysdate, 'A')),
         a.cd_convenio,
         a.cd_pessoa_fisica,
         a.cd_estabelecimento,
         obter_sexo_pf(a.cd_pessoa_fisica, 'C'),
         a.ie_periodo,
         a.cd_tipo_acomodacao,
         a.cd_setor_atendimento,
         a.cd_cid_principal,
         a.ie_clinica,
         substr(obter_desc_cid(a.cd_cid_principal), 1, 200) || ' - ' || '(' || cd_cid_principal || ')',
         obter_categoria_cid(a.cd_cid_principal),
         substr(obter_desc_categoria_cid(obter_categoria_cid(a.cd_cid_principal)), 1, 255),
         a.dt_referencia,
         nvl(a.cd_medico, '0'),
         to_char(a.dt_referencia, 'dd/mm/yyyy'),
         TO_NUMBER(to_char(a.dt_referencia, 'd')),
         a.ie_situacao,
         a.cd_procedencia,
         a.ie_tipo_atendimento,
         TO_NUMBER(to_char(a.hr_alta, '00')),
         a.nr_seq_origem,
         a.ie_clinica_alta,
         a.hr_alta,
         obter_tipo_convenio(a.cd_convenio),
         obter_especialidade_medico(a.cd_medico, 'C'),
         obter_nome_pf(a.cd_medico),
         cd_procedimento,
         substr(obter_descricao_procedimento(cd_procedimento, ie_origem_proced), 1, 100),
         substr(obter_nome_estabelecimento(a.cd_estabelecimento), 1, 80),
         substr(obter_desc_motivo_alta(a.cd_motivo_alta), 1, 255),
         a.cd_motivo_alta,
         a.cd_empresa,
         obter_classif_etaria(a.cd_estabelecimento, a.cd_pessoa_fisica, 'C'),
         obter_valor_dominio(1698, obter_classif_etaria(a.cd_estabelecimento, a.cd_pessoa_fisica, 'C')),
         c.cd_estabelecimento_base,
         substr(nvl(obter_compl_pf(a.cd_pessoa_fisica, 1, 'CDM'), NULL), 1, 100),
         a.nr_seq_queixa,
         substr(nvl(obter_desc_queixa(a.nr_seq_queixa), obter_texto_tasy(1098949, NULL)), 1, 255),
         a.cd_categoria,
         substr(obter_nome_convenio(a.cd_convenio) || ' - ' || obter_categoria_convenio(a.cd_convenio, a.cd_categoria), 1, 200),
         a.nr_seq_forma_chegada,
         substr(nvl(obter_desc_forma_chegada(a.nr_seq_forma_chegada), obter_texto_tasy(1098949, NULL)), 1, 255),
         TO_NUMBER(to_char(a.dt_entrada, 'hh24')),
         a.cd_convenio_glosa,
         a.cd_categoria_glosa,
         substr(nvl(obter_nome_convenio(a.cd_convenio_glosa), obter_texto_tasy(1098949, NULL)), 1, 100),
         substr(nvl(obter_categoria_convenio(a.cd_convenio_glosa, a.cd_categoria_glosa), obter_texto_tasy(1098949, NULL)), 1, 200),
         substr(nvl(obter_desc_indicacao(a.nr_seq_indicacao), obter_texto_tasy(1098949, NULL)), 1, 100),
         a.nr_seq_indicacao,
         a.cd_pessoa_fisica,
         a.ie_carater_inter_sus,
         substr(nvl(sus_obter_desc_carater_atend(a.ie_carater_inter_sus), obter_texto_tasy(1098949, NULL)), 1, 100),
         a.cd_empresa_conv, --substr(nvl(obter_nome_empresa(a.cd_empresa_conv),obter_texto_tasy(1098949,null)),1,100),
 decode(c.nr_seq_agrupamento, '', obter_texto_tasy(793289, NULL), substr(obter_desc_agrup_setor(c.nr_seq_agrupamento), 1, 50)),
 nvl(c.nr_seq_agrupamento, 0),
 a.nr_seq_classificacao,
 substr(sus_obter_desc_grupo(a.cd_grupo), 1, 40),
 substr(sus_obter_desc_subgrupo(a.cd_subgrupo), 1, 40),
 substr(sus_obter_desc_forma_org(a.cd_forma_organizacao), 1, 40),
 substr(obter_desc_grupo_proc(a.cd_grupo_proc), 1, 40),
 substr(obter_desc_area_procedimento(a.cd_area_proc), 1, 40),
 substr(obter_desc_especialidade_proc(a.cd_especialidade_proc), 1, 40),
 a.cd_grupo,
 a.cd_subgrupo,
 a.cd_forma_organizacao,
 a.cd_grupo_proc,
 a.cd_area_proc,
 a.cd_especialidade_proc,
 a.cd_proced_principal,
 substr(obter_descricao_procedimento(a.cd_proced_principal, a.ie_origem_proced_princ), 1, 100),
 substr(obter_desc_classif_atend(a.nr_seq_classificacao), 1, 255),
 substr(obter_valor_dominio(5, obter_dados_pf(a.cd_pessoa_fisica, 'EC')), 1, 15),
 substr(obter_dados_sus_municipio(x.cd_municipio_ibge, 'NC'), 1, 255),
 a.dt_entrada,
 a.dt_alta;

GRANT
SELECT ON "TASY"."EIS_CENSO_DIARIO_V2" TO "HORUS";


SELECT DISTINCT
        a.nr_atendimento,
        p.nm_pessoa_fisica nm_paciente,
        TO_CHAR (d.dt_diagnostico,'dd/mm/yyyy')dt_diagostico,

        (select	max(Y.CD_SETOR_ATENDIMENTO)
        from	atend_paciente_unidade X, setor_atendimento Y 
        where	X.nr_seq_interno = (
        select Obter_Atepacu_paciente(A.nr_atendimento, 'A')
        from dual)
        and X.cd_setor_atendimento = Y.cd_setor_atendimento)cd_setor,

        substr(Obter_Desc_Setor_Atendimento(a.nr_atendimento),1,12)ds_setor,
        obter_valor_dominio(12,a.ie_tipo_atendimento) ds_tipo_atendimento,
        substr(t.cd_doenca_cid|| '  ' || t.ds_doenca_cid,1,20)ds_doenca_cid,
        t.CD_CATEGORIA_CID,
        TO_CHAR(a.dt_entrada,'dd/mm/yyyy')entrada,
        TO_CHAR(a.dt_alta,'dd/mm/yyyy')alta,
        ROUND(nvl(a.dt_alta,sysdate)- a.dt_entrada)permanencia,             
        ROUND((sysdate - p.dt_nascimento)/ 365) idade,                 
        p.ie_sexo,
        p.nr_prontuario,
        p.dt_nascimento            
FROM
medico               m,
pessoa_fisica        p,
cid_doenca           t,
diagnostico_medico   g,
atendimento_paciente a,
diagnostico_doenca   d
WHERE
    d.dt_diagnostico BETWEEN :dt_inicial and :dt_final
    AND d.nr_atendimento = g.nr_atendimento
    AND d.dt_diagnostico = g.dt_diagnostico
    AND d.nr_atendimento = a.nr_atendimento
    AND d.cd_doenca = t.cd_doenca_cid
    AND g.cd_medico = m.cd_pessoa_fisica
    AND a.cd_pessoa_fisica = p.cd_pessoa_fisica
    AND UPPER(t.CD_CATEGORIA_CID) IN ('B05','B06','P35','R50','B08','R50','R21')
  --AND t.cd_doenca_cid = :cd_doenca_cid
  --AND cd_setor = :cd_setor
ORDER BY
    a.nr_atendimento,
    ds_doenca_cid,  
    p.nm_pessoa_fisica
	
	
	SELECT DISTINCT
        a.nr_atendimento,
        p.nm_pessoa_fisica nm_paciente,
        TO_CHAR (d.dt_diagnostico,'dd/mm/yyyy')dt_diagostico,
        a.cd_setor_atendimento,
        substr(Obter_Desc_Setor_Atendimento(a.nr_atendimento),1,12)ds_setor,
        obter_valor_dominio(12,a.ie_tipo_atendimento) ds_tipo_atendimento,
        substr(t.cd_doenca_cid|| '  ' || t.ds_doenca_cid,1,20)ds_doenca_cid,
        t.CD_CATEGORIA_CID,
        TO_CHAR(a.dt_entrada,'dd/mm/yyyy')entrada,
        TO_CHAR(a.dt_alta,'dd/mm/yyyy')alta,
        ROUND(nvl(a.dt_alta,sysdate)- a.dt_entrada)permanencia,             
        obter_idade_paciente(a.nr_atendimento) idade,                
        p.ie_sexo,
        p.nr_prontuario,
        p.dt_nascimento            
FROM
pessoa_fisica        p,
cid_doenca           t,
diagnostico_medico   g,
atendimento_paciente_V a ,
diagnostico_doenca   d
WHERE
    d.dt_diagnostico BETWEEN :dt_inicial and :dt_final
    AND d.nr_atendimento = g.nr_atendimento
    AND d.dt_diagnostico = g.dt_diagnostico
    AND d.nr_atendimento = a.nr_atendimento
    AND d.cd_doenca = t.cd_doenca_cid
    AND a.cd_pessoa_fisica = p.cd_pessoa_fisica  --ok
    AND UPPER(t.CD_CATEGORIA_CID) IN ('B05','B06','P35','R50','B08','R50','R21')
  --AND t.cd_doenca_cid = :cd_doenca_cid
  --AND cd_setor = :cd_setor
ORDER BY
    a.nr_atendimento,
    ds_doenca_cid,  
    p.nm_pessoa_fisica
    
	
	SELECT DISTINCT
        a.nr_atendimento,
        p.nm_pessoa_fisica nm_paciente,
        TO_CHAR (d.dt_diagnostico,'dd/mm/yyyy')dt_diagostico,
        a.cd_setor_atendimento,
        substr(Obter_Desc_Setor_Atendimento(a.nr_atendimento),1,12)ds_setor,
        obter_valor_dominio(12,a.ie_tipo_atendimento) ds_tipo_atendimento,
        substr(t.cd_doenca_cid|| '  ' || t.ds_doenca_cid,1,20)ds_doenca_cid,
        t.CD_CATEGORIA_CID,
        TO_CHAR(a.dt_entrada,'dd/mm/yyyy')entrada,
        TO_CHAR(a.dt_alta,'dd/mm/yyyy')alta,
        ROUND(nvl(a.dt_alta,sysdate)- a.dt_entrada)permanencia,             
        obter_idade_paciente(a.nr_atendimento) idade,                
        p.ie_sexo,
        p.nr_prontuario,
        p.dt_nascimento            
FROM
pessoa_fisica        p,
cid_doenca           t,
diagnostico_medico   g,
atendimento_paciente_V a ,
diagnostico_doenca   d
WHERE
    d.dt_diagnostico BETWEEN :dt_inicial and :dt_final
    AND d.nr_atendimento = g.nr_atendimento
    AND d.dt_diagnostico = g.dt_diagnostico
    AND d.nr_atendimento = a.nr_atendimento
    AND d.cd_doenca = t.cd_doenca_cid
    AND a.cd_pessoa_fisica = p.cd_pessoa_fisica  --ok
    AND UPPER(t.CD_CATEGORIA_CID) IN ('B05','B06','P35','R50','B08','R50','R21')
  --AND t.cd_doenca_cid = :cd_doenca_cid
  --AND cd_setor = :cd_setor
ORDER BY
    a.nr_atendimento,
    ds_doenca_cid,  
    p.nm_pessoa_fisica

--------------------------------
-- SQL PEGA 
--------------------------------

select  a.IE_AIDS_POSITIVO,
        a.IE_SIFILIS_POSITIVO,
        OBTER_DADOS_ATENDIMENTO(A.NR_ATENDIMENTO, 'NP') NM_PESSOA_FISICA
from PARTO a
where OBTER_DADOS_ATENDIMENTO(A.NR_ATENDIMENTO, 'NP') = 'ANA CAROLINE PINTO ZINN'


	to_date(nvl(decode(:dt_inicio,'  /  /    ', null, :dt_inicio), '01/01/1900'), 'dd/mm/yyyy') and
	to_date(nvl(decode(:dt_final,'  /  /    ', null, :dt_final), '01/01/2900'), 'dd/mm/yyyy')
	
	
	
	
	
	select 
	X.NR_ATENDIMENTO NR_ATENDIMENTO,
	X.tipo_evolucao,
	X.vl_totaL,
	obter_desc_setor_atend(x.cd_setor_atendimento) cd_setor
from
(
select distinct	
			nvl(SUBSTR(a.NR_ATENDIMENTO,1,255),'Pront:'||Obter_Prontuario_Paciente(A.CD_PESSOA_FISICA))	NR_ATENDIMENTO,
			a.IE_EVOLUCAO_CLINICA AS CD_EVOLUCAO_CLINICA,********
			Obter_Convenio_Atendimento(a.NR_ATENDIMENTO) AS cd_convenio,*******
			b.DS_TIPO_EVOLUCAO AS tipo_evolucao,*******
			count(a.IE_EVOLUCAO_CLINICA) AS vl_totaL,
			a.CD_SETOR_ATENDIMENTO AS *******

from TIPO_EVOLUCAO b, evolucao_paciente_lib_v a
		
		where b.CD_TIPO_EVOLUCAO = a.IE_EVOLUCAO_CLINICA
		AND A.IE_SITUACAO = 'A'
		and a.DT_LIBERACAO  between  :DT_INICIAL and FIM_DIA(:DT_FINAL) 
	
	group by 
	nvl(SUBSTR(a.NR_ATENDIMENTO,1,255),'Pront:'||Obter_Prontuario_Paciente(A.CD_PESSOA_FISICA)),
	a.IE_EVOLUCAO_CLINICA, 
	Obter_Convenio_Atendimento(a.NR_ATENDIMENTO),
	b.DS_TIPO_EVOLUCAO, 
	a.CD_SETOR_ATENDIMENTO 
) x
where 1 = 1
and :tipo_relatorio = 'S'
@SQL_WHERE


Select 
A.NR_ATENDIMENTO,
A.CD_UNIDADE,
A.NM_PACIENTE,
A.DS_SEXO ,
A.DT_ENTRADA_UNIDADE,
A.DT_SAIDA_UNIDADE ,
A.DS_CONVENIO,
A.DESCRISAO,
A.NOTA
FROM
(
select
    a.nr_atendimento,
    a.cd_unidade    ,
    a.nm_paciente   , 
    decode(a.ie_sexo,'M','Masculino','F','Feminino','') ds_sexo,
    a.dt_entrada_unidade,
    a.DT_SAIDA_UNIDADE,
    a.ds_convenio,
    SUBSTR(obter_descricao_pont_mews(SUBSTR(obter_pontuacao_mews(A.nr_atendimento,1),1,100)),1,250)DESCRISAO,
    obter_pontuacao_mews(A.nr_atendimento,1)nota
from atendimento_paciente_v a
where   (a.DT_ENTRADA BETWEEN :dt_inicial and :dt_final)
        and (a.cd_setor_atendimento = :cd_setor_atendimento or :cd_setor_atendimento = 0)
        AND obter_pontuacao_mews(A.nr_atendimento,1) hh24
)A
WHERE 1 = 1
and :tipo_relatorio = 'P'
@SQL_WHERE


------------------------------------------------------------------
--SQL TRÁS BANDA TÍTULO UM COM HORA SERVIDOR OUTRO PELO PERÍODO
------------------------------------------------------------
SELECT
(SELECT 'De: '|| :dt_inicial ||'   Até: '||:dt_final  FROM dual where 1=1 and :tipo_relatorio = 'P')P,
(SELECT 'Ocupação Atual - '||to_char(sysdate,'dd/mm/yyyy hh24:mi:ss' ) FROM dual where 1=1 and :tipo_relatorio = 'O')O
FROM DUAL

295

select 1 from dual 
where 1=1 
---------------------------------------------------------------
--modelo sql busca pela competência mês
---------------------------------------------------
select   distinct 
  obter_nome_medico(d.CD_MEDICO_RESPONSAVEL,'n') NM_MEDICO,
 d.CD_MEDICO_RESPONSAVEL MED
from     SUS_APAC_UNIF        d,
             atendimento_paciente b, 
             ATEND_PACIENTE_UNIDADE a        
where    b.nr_atendimento     = d.nr_atendimento
and      d.DT_FIM_VALIDADE between :dt_inicio and :dt_final
and b.nr_atendimento = a.nr_atendimento
and d.dt_ocorrencia is null
and	to_char(d.dt_competencia,'mm/yyyy')	= :dt_competencia
@SQL_WHERE
order by d.CD_MEDICO_RESPONSAVEL



----------------------------------------
--PARAMETRO BUSCA MÉDICO 
--------------------------------------
--  CD_MEDICO_RESPONSAVEL
--- NUMBER
Select  a.CD_PESSOA_FISICA CD,
        a.NM_GUERRA DS
from MEDICO a 
where a.IE_SITUACAO = 'A'
order by NM_GUERRA 

------------------------------------------

nvl(a.ie_suspenso,'N')	<> 'S'
    AND (( b.cd_setor_atendimento =:cd_setor_atendimento )OR ( 0 =:cd_setor_atendimento ))
	
	
	
	WHERE
1 = 1
AND :IE_TIPO_REL = 'A'
@SQL_WHERE
ORDER BY 2
----------------------------------------------------------
select substr(obter_tipo_atendimento_prescr(54211),1,100) --tipo 7 
from dual
where
substr(obter_tipo_atendimento_prescr(54211),1,100) = '3' AND (NVL(A.IE_IMP_ORIENTACAO,'S')='N')


select  NM_TABELA,
        NM_ATRIBUTO,
        IE_TIPO_ATRIBUTO,
        DS_ATRIBUTO,
        IE_SITUACAO,
        DS_VALORES,
        CD_DOMINIO,
        DS_LABEL,
        DS_LABEL_GRID,
        DS_MASCARA,
        CD_EXP_DESC,
        substr(obter_desc_expressao(cd_exp_desc),1,254)ds_exp_desc
from TABELA_ATRIBUTO
WHERE NM_TABELA = ('MAN_ORDEM_SERVICO')
AND  NM_ATRIBUTO = ('IE_SOLICITANTE')


select   vl_dominio cd,
         ds_expressao ds
from     valor_dominio_v
where    cd_dominio = 12

------------
with atendimento_setor as (
SELECT nr_atendimento
   -- MIN(DT_ENTRADA_UNIDADE)
FROM
    atend_paciente_unidade
WHERE
    obter_tipo_unidade_atend(nr_atendimento,nr_seq_interno,ie_passagem_setor) = 'N' 
    AND DT_ENTRADA_UNIDADE BETWEEN :DT_INICIAL AND FIM_DIA(:DT_FINAL)
    AND CD_SETOR_ATENDIMENTO = :cd_setor_atendimento
/*group by nr_atendimento*/ )

select 
    x.nr_atendimento,
    x.dt_entrada,
    x.ds_setor,
    x.leito
from 
atendimento_setor y,
(SELECT
    a.nr_atendimento,
    a.nr_sequencia,
    a.cd_setor_atendimento,
    obter_desc_setor_atend(a.cd_setor_atendimento) ds_setor,
    a.dt_entrada_unidade,
    TO_CHAR(a.dt_entrada_unidade,'dd/mm/yyyy hh24:mi:ss') dt_entrada,
    a.cd_unidade_basica || a.cd_unidade_compl leito,
    lag(a.cd_setor_atendimento) over (partition by a.nr_atendimento order by a.dt_entrada_unidade asc) lag,
    (case when lag(a.cd_setor_atendimento) over (order by a.dt_entrada_unidade asc) = cd_setor_atendimento 
    then 0
    when a.cd_setor_atendimento = :cd_setor_atendimento 
    then 1 
    else 0 end) cont
FROM
    atend_paciente_unidade a 

WHERE
   
     obter_tipo_unidade_atend(a.nr_atendimento,a.nr_seq_interno,a.ie_passagem_setor) in ('N','A')) x
where
y.nr_atendimento = x.nr_atendimento
  and   x.cont = 1
    and x.dt_entrada_unidade <> (SELECT
                            MIN(dt_entrada_unidade)
                        FROM
                            atend_paciente_unidade
                         WHERE
                            cd_setor_atendimento = x.cd_setor_atendimento
                            AND nr_atendimento = x.nr_atendimento)



SELECT /*05-Quebra especialidade*/
distinct t.cd_especialidade CD_ESPECIALIDADE2,
t.ds_especialidade
FROM
(
SELECT
distinct obter_especialidade_medico(a.cd_medico_cirurgiao,'C')CD_ESPECIALIDADE,
obter_especialidade_medico(a.cd_medico_cirurgiao,'D')DS_ESPECIALIDADE,
a.CD_TIPO_CIRURGIA,
a.IE_PORTE
FROM
    cirurgia a, HCB_CIRURGIA_SEGURA_V b, PROCEDIMENTO C
WHERE      
a.dt_inicio_real  between  :DT_INICIAL and FIM_DIA(:DT_FINAL) 
and c.CD_PROCEDIMENTO = a.CD_PROCEDIMENTO_PRINC
and a.nr_cirurgia = b.nr_cirurgia
AND a.CD_SETOR_ATENDIMENTO = :CD_SETOR_ATENDIMENTO 
and a.dt_termino mm/yy
and   a.ie_status_cirurgia in(2) 
and b.DS_ANTIB_SIM_AIC mm/yy
and :CD_ANTIBIOTICO = 1
and :CD_PADRAO = 0
union
SELECT
distinct obter_especialidade_medico(a.cd_medico_cirurgiao,'C')CD_ESPECIALIDADE,
obter_especialidade_medico(a.cd_medico_cirurgiao,'D')DS_ESPECIALIDADE,
a.CD_TIPO_CIRURGIA,
a.IE_PORTE
FROM
    cirurgia a, HCB_CIRURGIA_SEGURA_V b, PROCEDIMENTO C
WHERE      
a.dt_inicio_real  between  :DT_INICIAL and FIM_DIA(:DT_FINAL) 
and c.CD_PROCEDIMENTO = a.CD_PROCEDIMENTO_PRINC
and a.nr_cirurgia = b.nr_cirurgia
AND a.CD_SETOR_ATENDIMENTO = :CD_SETOR_ATENDIMENTO 
and a.dt_termino mm/yy
and   a.ie_status_cirurgia in(2) 
and b.DS_ANTIB_SIM_AIC is null
and :CD_ANTIBIOTICO = 0
and :CD_PADRAO = 0
union
SELECT
distinct obter_especialidade_medico(a.cd_medico_cirurgiao,'C')CD_ESPECIALIDADE,
obter_especialidade_medico(a.cd_medico_cirurgiao,'D')DS_ESPECIALIDADE,
a.CD_TIPO_CIRURGIA,
a.IE_PORTE
FROM
    cirurgia a, HCB_CIRURGIA_SEGURA_V b ,PROCEDIMENTO C
WHERE      
a.dt_inicio_real  between  :DT_INICIAL and FIM_DIA(:DT_FINAL) 
and c.CD_PROCEDIMENTO = a.CD_PROCEDIMENTO_PRINC
and a.nr_cirurgia = b.nr_cirurgia
AND a.CD_SETOR_ATENDIMENTO = :CD_SETOR_ATENDIMENTO 
and a.dt_termino mm/yy
and   a.ie_status_cirurgia in(2) 
and :CD_ANTIBIOTICO = 2
and :CD_PADRAO = 0
) T
where
1=1 
@SQL_WHERE
order by 2




--MASCARAS
###,###,###,##0.00
###,##0.0
###,###,##0
###,###.####
PASSWORD
@###,###,###,###0.00
@###,###,##0.0000
dd/mm/yyyy hh24:mi:ss
#0.0
##0
#,###,###,##0
##,####,####,##0.00
NR_SEQ_EXAME
##,###,###,##0.00
+###0.00
###0.00
###,####0.0000
NR_SEQUENCIA
##:##:##
########0.00
###0.0000
##.##0.00
###,###,###,###0.00
!99/9999
##,###,###0.0000
##,###000.00
NR_SEQ_GUIA_PLANO
até que seja lançado o valor total de     
999.999.999/999-99
CD_PROCEDIMENTO_LOC
currency(maxFrac:4, minFrac:4)
130
alphanumeric(mask:"0000")
date(dateShort)
##,###,###,##0
###,###.##
###,###,##0.0000
UPPER
##,####0.00
##0.00
CD_FUNCAO
@###,###,##0.00
###,##0
###.00
@#,00.000
###0
###,###.0
##,###,###,##,0.000
###,###,###
@##,0.0000
HH:mm
#.0
##
###,###0.0000
upper
######0.00
CD_CONTATO_ADM
00.00
###,###,###0,00
NR_NUMBER
##,#
IE_TIPO_INTERNADO
IE_FORMA_REGISTRO
###,###,###,###,##0.00
DD/MM
###,###,###,###,###0.00
date(shortMonth)
NR_SEQ_FATOR_PROG
###,###,##0.00
hh:mm:ss
###,##0.000
##0.0000
##,###,###,###.0000
00:00
###,###.00000
00000
###,###,##.00
####0
dd/MM/yyyy
dd/mm hh:mm:ss
IE_POSICAO
DD/MM/YYYY HH:MM
0000
###,###,###,#0.0000
###,###,###,#0.00
hh:mi:ss
#,##0.0000
dd/mm/yyyy HH:mm:ss
CD_PROCEDIMENTO;IE_ORIGEM_PROCED
hh:mi
###,###,###,###,##0.0000
dd/mm/yyyy hh:nn:ss
dd/mm/yyyy hh:MM:ss
###
#0.0000
date(year)
NR_SEQ_MODULO
###,###0.00
HH:MM
###,###,##0.000000
###,###,####0.0000
##0.000000
###.000
#####0.00
###,###,###,##0.0
###,###,###,0.0000
##,0.0
#,##0.00
date(short)
YYYY
###,###,###.0,0000
NR_SEQ_ATA
###,##
date(shortDate)
@###,###,###,###.##
#########0.0000
00.000.000.0000-00
date(timestamp)
9.99.9999
NR_SEQ_TOPOGRAFIA
number(maxFrac:4, minFrac:4)
0,0
NR_SEQ_ALERTA
NR_SEQ_DIAG
###,###,###0.00
dd/mm/yyyy hh24:mm:ss
##0.000
dd/mm/yyyy hh:mi:ss
hh24:mi:ss
99.999.999/9999-99;0
##.###-###
###.0
##0.0
###.##
###,###,###,##0
###,####,##0.00
###,###,###,0.00
dd/mm/yyyy 24hh:mm:s
@###,###,###,##0.00
##,##0.00
@##,###,###,##0.0000
dd/mm/yyy hh:mm:ss
IE_ORIGEM_PROCED
###########0.0000
(##) ####-####
__/__
@#,###,###,#0.0000
##,###,###,###,##0.0000
number(minFrac:2,maxFrac:2)
NR_SEQ_CONGENERE
#,###,###0.00
CD_PESSOA_FISICA
NM_ID_JOB
HH:MM:SS
currency(maxFrac:2, minFrac:2)
alphanumeric(mask:"00:00")
date(yyyy)
CD_MAT_RED
dd/mm/yyyy
hh:mm
dd/mm/yyyy hh:mm:ss
dd/mm/yyyyy
###,##0.0000
###,###,###,###
###,###,##0.0
##,###,##0
####,###,##0.00
##.0
##0,00
#|999
yyyy
###.###.###-##
NR_SEQ_LOC_TNM
###,###,##0.00000
###,#0.00
#,###,##0.0000
hh24:mi
dd/MM/yyyy hh:mm:ss
@###,###,##0.000
NR_SEQ_OCORR_MOTIVO
#,##0.000
###,###0.000
IE_REGRA_QTDE
nr_sequencia
duration()
###,###,##00.0
NR_ATENDIMENTO
clinical()
NR_SEQ_CAN_ESTADIO
###,###,###,##0.0000
@#,###,0.0000
dd/mm/yyyy hh:mm
dd/mm hh:mm
###,###,###.0000
##,###,###,##0.0000
##,##0.0000
###,##0.00
#,###,###,###,##0.00
###,###,##
##.##.##.##.##-##
###,###,##0.000
#0.000
!99999999;1;_
00.0
#00.00
NR_SEQ_AGENDA
dd/mm
##,###,###,##.0000
dd/mm/yyyy 
###,###,###0.0000
NR_SEQ_GRUPO
password
NR_SEQ_PERGUNTA
-###0.00
###.###.##0,00
@###,###,###,##0.0000
NR_SEQ_TUSS_MAT_ITEM
Valor
HH24:MI:SS
##,####,###0.00
#0
CD_MAT_DIL
###,###,#0.00
dd/mm/yy
CD_BANCO
IE_MEDIC_SOLUCAO
number(maxFrac:2, minFrac:2)
alphanumeric(mask:"00/0000")
date(shorDate)
DD/MM/YYYY
#0.00
#0.00000
@#,###,00.000
mm/yyyy
dd/MM/yyyy hh:nn:ss
#,###,###,##0.00
##,###,###,##.00
hh24:mm
##0.00##
##,###,###,###0.0000
 
dd/mm/yyyy hh:m:ss
dd/mm/yyyy hh:mm.ss
##00.0
NM_TABELA
ie_tipo_internado
dd/MM/yyyy HH:mm:ss
dd/mm/yyyy hh:24:mi:ss
date(shortTime)
dd//mm/yyyy
clinical




DOENÇAS PRÉVIAS E ATUAIS