SELECT * FROM MED_TIPO_AVALIACAO;       --TABELA COM AS AVALIÇÕES 
SELECT * FROM MED_AVALIACAO_PACIENTE;   --TABELA COM TODAS AVALIAÇÕES


SELECT * 
FROM MED_AVALIACAO_PACIENTE
WHERE NR_SEQ_TIPO_AVALIACAO = 61 


select
Obter_Pf_Usuario(a.NM_USUARIO_NREC,'C') cd_medico,
hcb_obter_nome_pf_enf(Obter_Pf_Usuario(a.NM_USUARIO_NREC,'C')) nm_usuario,
substr(hcb_obter_ds_cod_prof(Obter_Pf_Usuario(a.NM_USUARIO_NREC,'C')),1,100) ds_codigo_prof,
SUBSTR(AVAL(NR_SEQUENCIA,1595),1,255) DS_CID,
SUBSTR(AVAL(NR_SEQUENCIA,1596),1,3000) DS_INVESTIGACAO,
SUBSTR(AVAL(NR_SEQUENCIA,1597),1,3000) DS_INDICACAO,
SUBSTR(AVAL(NR_SEQUENCIA,1598),1,3000) DS_CONTRA_REFERENCIA
from MED_AVALIACAO_PACIENTE a
where a.NR_SEQUENCIA = :nr_seq_avaliacao


SELECT
IM_ASSINATURA
FROM PESSOA_FISICA_ASSINATURA
WHERE CD_PESSOA_FISICA = :CD_MEDICO
AND IE_TIPO = 'A'



select
Obter_Pf_Usuario(a.NM_USUARIO_NREC,'C') cd_pessoa,
hcb_obter_nome_pf_enf(Obter_Pf_Usuario(a.NM_USUARIO_NREC,'C')) nm_usuario,
DT_AVALIACAO,
SUBSTR(AVAL(NR_SEQUENCIA,1668),1,255) DS_1667,
SUBSTR(AVAL(NR_SEQUENCIA,1669),1,255) DS_1669,
SUBSTR(AVAL(NR_SEQUENCIA,1670),1,255) DS_1670,
SUBSTR(AVAL(NR_SEQUENCIA,1671),1,255) DS_1671,
SUBSTR(AVAL(NR_SEQUENCIA,1697),1,255) DS_1697,
SUBSTR(AVAL(NR_SEQUENCIA,1673),1,255) DS_1673,
SUBSTR(AVAL(NR_SEQUENCIA,1675),1,255) DS_1675,
SUBSTR(AVAL(NR_SEQUENCIA,1675),1,255) DS_1677
from MED_AVALIACAO_PACIENTE a
where a.NR_SEQUENCIA = :nr_seq_avaliacao





--------------------------------SQL OS CME------------------------------------
SELECT
'Conjunto: '||SUBSTR(DECODE(A.NM_CONJUNTO_AUX,NULL,CME_OBTER_NOME_CONJUNTO(A.NR_SEQ_CONJUNTO),A.NM_CONJUNTO_AUX),1,200) DS_CONJUNTO,
A.NR_SEQUENCIA nr_seq_lote_barras,
'Data Preparo: '||TO_CHAR(A.DT_ORIGEM,'DD/MM/YYYY HH24:MI:SS') DT_ORIGEM,
'Embalagem: '||SUBSTR(DECODE(A.DS_EMBALAGEM_AUX,NULL,CME_OBTER_CLASSIF_EMBALAGEM(A.NR_SEQ_EMBALAGEM),A.DS_EMBALAGEM_AUX),1,50) DS_EMBALAGEM,
'N° Pecas: '||(SELECT SUM(QT_ITEM)FROM CM_ITEM_CONT WHERE NR_SEQ_CONJUNTO = A.NR_SEQUENCIA) QT_PECAS,
'Observacao: '||A.DS_OBSERVACAO DS_OBSERVACAO,
'Responsavel: '||SUBSTR(DECODE(A.NM_PESSOA_RESP_AUX,NULL,OBTER_NOME_PF(A.CD_PESSOA_RESP),A.NM_PESSOA_RESP_AUX),1,60) NM_PESSOA
FROM CM_CONJUNTO_CONT A
WHERE A.NR_SEQUENCIA = :NR_SEQUENCIA
AND A.IE_STATUS_CONJUNTO = 1


--NUM PEÇAS FALTANTES
--NOME PEÇA FALTANTE
SELECT * FROM CM_CONJUNTO_CONT A WHERE NR_SEQ_CONJUNTO = 203




--------------------------OS EDSON--------------------
/*
Solicito ajuste em relatório HCB - Ficha de Internaçã e Alta CATE 0437 
de forma que quando existir uma reserva para o paciente apareça no 
campo Observação do relatório as informações da reserva " 
Paciente possui reserva de leito no setor ........ no leito........". 
Essa alteração deverá ser realizada para todos os perfis que realizam 
internação SUS e Convênios, 
pode existir mais de um relatório.

GESTÃO DE VAGAS

CATE HCB 00437 - Ficha de Internação e Alta

PERFIS
-----------------------------------
Consulta Entrada Única de Pacientes
Notificação de Eventos
Retorno Conv
Rec Internação SUS
Faturamento
Rec Internacões Convênios
Contas a Receber

DS_OBSERVACAO

GESTÃO DE ELITO

EX - 1845270
*/



SELECT *
FROM OCUPACAO_UNIDADE_V 
WHERE NR_ATENDIMENTO = 1842787

 
select Obter_Dados_Atendimento(1845271, 'OBS')DADOS 
FROM DUAL


select distinct 	
    o.DS_OBSERVACAO,
    substr(obter_filiacao(a.cd_pessoa_fisica, 'P'),1,80) nm_pai,
    substr(obter_filiacao(a.cd_pessoa_fisica, 'M'),1,80) nm_mae,
	c.ds_endereco||'  '||c.nr_endereco  ds_endereco,
	c.ds_bairro,
	c.cd_cep nr_cep,
	c.ds_municipio||' - '||c.sg_estado  ds_cidade,
	obter_telefone_pf(c.cd_pessoa_fisica,12)||'/'||obter_telefone_pf(c.cd_pessoa_fisica,13)||'/'||obter_telefone_pf(536,2)||'/'||obter_telefone_pf(c.cd_pessoa_fisica,10) nr_telefone,
	c.ds_complemento,
	substr(obter_nome_medico(a.cd_medico_resp,'N'),1,254)||'  '||
	substr(obter_nome_medico(a.cd_medico_resp,'D'),1,40)  nm_medico,
	substr(conteudo_campo_valido( a.cd_motivo_alta,4,'X'),1,1) ie_alta_hosp,
	substr(conteudo_campo_valido( a.cd_motivo_alta,2,'X'),1,1) ie_alta_adm,
	substr(conteudo_campo_valido( a.cd_motivo_alta,7,'X'),1,1) ie_alta_obito,
	(select      b.ds_carater_internacao
	from   	sus_carater_internacao b,
		atendimento_paciente c
	where  	b.cd_carater_internacao = c.ie_carater_inter_sus
	and 	c.nr_atendimento = a.nr_atendimento) DS_CARATER_ATEND,
	p.ds_procedencia,
	substr(OBTER_CLINICA_ATENDIMENTO(a.nr_atendimento),1,100) DS_CLINICA,
	substr(OBTER_NOME_TIPO_ATEND(OBTER_TIPO_ATENDIMENTO(a.nr_atendimento)),1,100) DS_TIPO_ATENDIMENTO,
	a.dt_alta,
	substr(OBTER_CRM_MEDICO(a.cd_medico_resp),1,20) nr_crm,
	(select 	substr(obter_desc_cid_doenca(w.cd_doenca),1,160) nm
	from 	diagnostico_doenca w
	where	nr_atendimento = :nr_atendimento
	and 	w.dt_diagnostico	= 	(select max(doe.dt_diagnostico)
				   	 from   diagnostico_medico b,
					 diagnostico_doenca doe
				   	 where  b.nr_atendimento	= doe.nr_atendimento
					 and      doe.dt_diagnostico = b.dt_diagnostico
				   	 and      b.ie_tipo_diagnostico = 1
					 and      b.nr_atendimento = w.nr_atendimento)) DS_DIAGNOSTICO,
	(select 	substr(obter_desc_cid_doenca(w.cd_doenca),1,160) nm
	from 	diagnostico_doenca w
	where	nr_atendimento = :nr_atendimento
	and 	w.dt_diagnostico	= 	(select max(doe.dt_diagnostico)
				   	 from   diagnostico_medico b,
					 diagnostico_doenca doe
				   	 where  b.nr_atendimento	= doe.nr_atendimento
					 and      doe.dt_diagnostico = b.dt_diagnostico
				   	 and      b.ie_tipo_diagnostico = 2
					 and      b.nr_atendimento = w.nr_atendimento)) DS_DIAGNOSTICO_DEF,
	HCBCS_obter_observacao_atend(a.nr_atendimento) ds_obs_eup, t.NR_ACOMPANHANTE	 
from 	procedencia p,
        compl_pessoa_fisica c,
        pessoa_fisica b,
        atendimento_paciente a, 
        ATEND_CATEGORIA_CONVENIO t,
        OCUPACAO_UNIDADE_V o
        
where 	a.nr_atendimento 		= :nr_atendimento
and 	a.nr_atendimento 		= t.nr_atendimento
and 	a.cd_pessoa_fisica 		= b.cd_pessoa_fisica
and 	a.cd_pessoa_fisica 		= c.cd_pessoa_fisica(+)
and 	a.nr_atendimento 		= o.nr_atendimento
and 	a.cd_pessoa_fisica 		= o.cd_pessoa_fisica
and 	1			= c.ie_tipo_complemento(+)
and	p.cd_procedencia		= a.cd_procedencia





