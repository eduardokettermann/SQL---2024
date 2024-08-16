/**Relatório Analítico Cód 1696 : Acrescentar as divergências**/
select  a.nr_sequencia,
        b.nr_sequencia,
        b.dt_recebimento,
        substr(obter_nome_pf_pj(null,b.cd_cgc),1,100) ds_fornecedor,
        substr(obter_desc_tipo_divergencia(c.NR_SEQ_TIPO),1,200)ds_diver,
        b.cd_material,
        substr(obter_desc_material(b.cd_material),1,255) ds_material,
        substr(obter_nome_pf_pj(b.cd_pessoa_responsavel,null),1,100) ds_responsavel,
        nr_ordem_compra,
        to_date(obter_data_ordem_compra(b.nr_ordem_compra,'O')) dt_ordem_compra,
        campo_mascara_virgula(obter_quantidade_oci(b.nr_ordem_compra, nr_item_oci)) qt_item_ordem,
        campo_mascara_virgula(obter_valor_unitario_oci(b.nr_ordem_compra, nr_item_oci)) vl_item_ordem,
        b.nr_nota_fiscal,
        b.qt_inspecao,
        b.vl_unitario_material,
        to_date(obter_data_ordem_compra(b.nr_ordem_compra,'E')) dt_entrega,
        b.ds_lote_fornec,
        b.dt_validade,
        b.ie_temperatura,
        b.ie_interno,
        b.ie_externo,
        b.ie_laudo,
        substr(obter_valor_dominio(1639,b.ie_motivo_devolucao),1,100) ds_motivo_dev,
        b.ds_observacao,
        b.ds_justificativa
from	
inspecao_registro a,    --registro // fornecedor
inspecao_recebimento b, --inspeção //  a.nr_sequencia = b.nr_seq_registro
inspecao_divergencia c  --divergencia

where	b.dt_recebimento between :dt_inicial and fim_dia(:dt_final)
and	a.nr_sequencia = b.nr_seq_registro
and b.nr_sequencia = C.NR_SEQ_INSPECAO
and B.CD_MATERIAL = C.CD_MATERIAL
and	(cd_cgc			= :cd_cgc or :cd_cgc = 0)
and	(nr_ordem_compra	= :nr_ordem_compra or :nr_ordem_compra = 0)
and	(nr_nota_fiscal	= :nr_nota_fiscal or :nr_nota_fiscal = 0)


-- A
SELECT * 
FROM inspecao_registro   
where	DT_REGISTRO between :dt_inicial and fim_dia(:dt_final) 
and CD_CNPJ = 94516671000153
--B
--------------------------------        
 SELECT * 
 FROM inspecao_recebimento 
 where	dt_recebimento between :dt_inicial and fim_dia(:dt_final) 
and CD_CGC = 94516671000153
--C
--------------------------------   
SELECT * 
FROM inspecao_divergencia 

--A U B
-----------------------------------
SELECT  a.nr_sequencia,
        b.nr_sequencia,
        b.dt_recebimento,
        substr(obter_nome_pf_pj(null,b.cd_cgc),1,100) ds_fornecedor,
--        substr(obter_desc_tipo_divergencia(c.NR_SEQ_TIPO),1,200)ds_diver,
        b.cd_material,
        substr(obter_desc_material(b.cd_material),1,255) ds_material,
        substr(obter_nome_pf_pj(b.cd_pessoa_responsavel,null),1,100) ds_responsavel,
        nr_ordem_compra,
        to_date(obter_data_ordem_compra(b.nr_ordem_compra,'O')) dt_ordem_compra,
        campo_mascara_virgula(obter_quantidade_oci(b.nr_ordem_compra, nr_item_oci)) qt_item_ordem,
        campo_mascara_virgula(obter_valor_unitario_oci(b.nr_ordem_compra, nr_item_oci)) vl_item_ordem,
        b.nr_nota_fiscal,
        b.qt_inspecao,
        b.vl_unitario_material,
        to_date(obter_data_ordem_compra(b.nr_ordem_compra,'E')) dt_entrega,
        b.ds_lote_fornec,
        b.dt_validade,
        b.ie_temperatura,
        b.ie_interno,
        b.ie_externo,
        b.ie_laudo,
        substr(obter_valor_dominio(1639,b.ie_motivo_devolucao),1,100) ds_motivo_dev,
        b.ds_observacao,
        b.ds_justificativa 
FROM    inspecao_registro a,
        inspecao_recebimento b,
        inspecao_divergencia c
where	b.DT_RECEBIMENTO between :dt_inicial and fim_dia(:dt_final) 
and a.CD_CNPJ = b.CD_CGC 
and a.NR_SEQUENCIA = 3206
and a.CD_CNPJ = 94516671000153
--and b.nr_sequencia = C.NR_SEQ_INSPECAO --traz somente os com divergencia

--tabela tipos 
select *
from inspecao_tipo_divergencia
--
select *
from INSPECAO_DIVERGENCIA

        
SELECT * FROM inspecao_registro a        
SELECT * FROM inspecao_recebimento b
SELECT * FROM inspecao_divergencia c