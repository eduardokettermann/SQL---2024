-----------------------Registro de inspeção-------------------------
select  NR_SEQUENCIA,
        substr(obter_nome_pf_pj(null,cd_cnpj),1,100) ds_fornecedor,
        CD_CNPJ,
        DT_ATUALIZACAO,
        NM_USUARIO_NREC,
        DT_LIBERACAO
from 	inspecao_registro
where  CD_CNPJ in('44734671000151')
order by CD_CNPJ

-----------------registro recebimento e divergencia-----------------------
select a.nr_sequencia,
       b.nr_seq_registro,
       b.CD_CGC,
       substr(obter_desc_material(b.cd_material),1,255) ds_material,
       b.CD_MATERIAL,
       b.DT_RECEBIMENTO,
       b.DT_ENTREGA_REAL,
       obter_desc_tipo_divergencia(a.nr_sequencia)ds_diver
from inspecao_recebimento b,
        inspecao_registro a
where	a.nr_sequencia = b.nr_seq_registro

---------------------SQL RELATÓRIO ORIGINAL INSERIR NR_SEQUENCIA---------

select	b.nr_sequencia,
        b.dt_recebimento,
        substr(obter_nome_pf_pj(null,b.cd_cgc),1,100) ds_fornecedor,
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
from	inspecao_recebimento b
where	b.dt_recebimento between :dt_inicial and fim_dia(:dt_final)

----------------------------------------------------------------------------------------
select  b.nr_sequencia,
        b.dt_recebimento,
        substr(obter_nome_pf_pj(null,b.cd_cgc),1,100) ds_fornecedor,
        obter_desc_tipo_divergencia(a.nr_sequencia)ds_diver,
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
inspecao_recebimento b,
inspecao_registro a
    where	b.dt_recebimento between :dt_inicial and fim_dia(:dt_final)
    and	a.nr_sequencia = b.nr_seq_registro
    
--------RELATÓRIO SINTÉTICO--SQL VIEW--------------------
select	a.cd_cnpj,
	substr(obter_nome_pf_pj(null,cd_cnpj),1,255) ds_razao_social,
	a.qt_entregue,
	a.qt_sem_inspecao,
	a.qt_nao_conformidade,
	a.qt_devolucao,
	a.qt_data_superior_oc,
	a.qt_quantidade_maior_oc
from	w_aval_fornec_inspecao a
--where	a.nm_usuario = :nm_usuario_cor
where CD_CNPJ IN(15131757000191)
order by	ds_razao_social

--SQL LISTA TODOS FORNECEDORES PERÍODO NF FISCAIS E INSPECIONADAS---
select	a.cd_fornecedor, 
	substr(obter_nome_pf_pj(null,a.cd_fornecedor),1,100) ds_fornecedor,
	a.dt_mesano_referencia,
	substr(obter_valor_dominio(1640,a.ie_conceito_geral),1,80) ds_conceito_geral,
	a.qt_real_entrega,
	a.qt_real_inspecao,
	a.qt_pontualidade_entrega,
	substr(obter_valor_dominio(1640,a.ie_pontualidade_entrega),1,80) ds_pontualidade_entrega,
	a.qt_eficiencia_atendimento,
	substr(obter_valor_dominio(1640,a.ie_eficiencia_atendimento),1,80) ds_eficiencia_atendimento,
	a.qt_integridade_produto,
	substr(obter_valor_dominio(1640,a.ie_integridade_produto),1,80) ds_integridade_produto
from	avaliacao_fornecedor a,
	pessoa_juridica b
where	a.cd_fornecedor = b.cd_cgc
and	a.dt_mesano_referencia between 
	to_date(nvl(decode(:dt_inicio,'  /  /    ', null, :dt_inicio), '01/01/1900'), 'dd/mm/yyyy') and
	to_date(nvl(decode(:dt_final,'  /  /    ', null, :dt_final), '01/01/2900'), 'dd/mm/yyyy')
order by	ds_fornecedor,
	dt_mesano_referencia desc

--SQL COM TODAS COLUNAS E FUNÇÕES PARA MELHOR ENTENDIMENTO
SELECT  
a.NR_SEQUENCIA,
a.cd_fornecedor, 
substr(obter_nome_pf_pj(null,a.cd_fornecedor),1,100) ds_fornecedor,
a.DT_ATUALIZACAO,
a.CD_FORNECEDOR,
a.DT_MESANO_REFERENCIA,
a.QT_REAL_ENTREGA NF,
a.QT_REAL_INSPECAO INSPEÇÕES,
substr(obter_valor_dominio(1640,a.ie_pontualidade_entrega),1,80)) ds_pontualidade_entrega,
a.QT_EFICIENCIA_ATENDIMENTO,
CONCAT(a.QT_CONCEITO_GERAL||'  ',substr(obter_valor_dominio(1640,a.ie_conceito_geral),1,80)) ds_conceito_geral,
a.QT_DEVOLUCAO

from	avaliacao_fornecedor a,
        pessoa_juridica b
where	a.cd_fornecedor = b.cd_cgc
and	a.dt_mesano_referencia between 
	to_date(nvl(decode(:dt_inicio,'  /  /   ', null, :dt_inicio), '01/01/1900'), 'dd/mm/yyyy') and
	to_date(nvl(decode(:dt_final, ' /  /    ', null, :dt_final), '01/01/2900' ), 'dd/mm/yyyy')
order by	ds_fornecedor,
	dt_mesano_referencia desc