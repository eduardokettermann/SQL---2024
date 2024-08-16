/*INPUT
IE_TIPO_ITEM
NR_ATENDIMENTO
NR_SEQ_HORARIO


não foi possivel imprimir etiqueta do tipo procedimento
devido limitação do sistema tasy que permite exclusivamente 
impressão de medicamento não possibilitando impressão outros tipos 
de prescrições



*/

-- Seleciona dados da tabela HCB_ADEP_MATERIAIS2
SELECT  
    '' AS MED1,
    '' AS MED2,
    '' AS MED3,
    '' AS MED4,
    '' AS MED5,
    '' AS DOSE1,
    '' AS DOSE2,
    '' AS DOSE3,
    '' AS DOSE4,
    '' AS DOSE5,
    TO_CHAR(A.DT_HORARIO, 'DD/MM/YYYY HH24:MI') AS DS_HORARIO,
    A.DT_HORARIO,
    TO_CHAR(SUBSTR(PLT_OBTER_DADOS_HOR_ITEM(:NR_SEQ_HORARIO, :IE_TIPO_ITEM, 'H'), 1, 10)) AS DT,
    TO_CHAR(TO_DATE(SUBSTR(PLT_OBTER_DADOS_HOR_ITEM(:NR_SEQ_HORARIO, :IE_TIPO_ITEM, 'H'), 1, 10), 'DD/MM/YYYY') + 1, 'DD/MM/YYYY') AS DT2,
    A.NM_PESSOA2,
    A.DS_MATERIAL,
    A.NR_HORARIO,
    A.DS_LEITO,
    A.DS_DOSE,
    DECODE(A.DS_VIA, 'Via: Inalatória', 'Via: Inalatoria', A.DS_VIA) AS DS_VIA,
    A.DS_DIL1,
    A.DS_DIL2,
    A.DS_DIL3,
    A.DS_DIL4,
    A.DS_DIL5,
    A.DS_DIL6,
    A.DS_DIL7,
    A.DS_OBSERVACAO,
    A.IE_TIPO_ITEM
FROM 
    HCB_ADEP_MATERIAIS2 A
WHERE 
    A.NR_ATENDIMENTO = :NR_ATENDIMENTO
    AND (
        (HCB_OBTER_SE_SN_ADEP(:NR_SEQ_HORARIO) = 'S' AND A.IE_SE_NECESSARIO = 'S')
        OR (
            HCB_OBTER_SE_SN_ADEP(:NR_SEQ_HORARIO) = 'N' 
            AND A.IE_SE_NECESSARIO = 'N' 
            AND (
                (SUBSTR(PLT_OBTER_DADOS_HOR_ITEM(:NR_SEQ_HORARIO, :IE_TIPO_ITEM, 'H'), 12, 2) IN ('19', '20', '21', '22', '23')
                 AND TO_CHAR(TO_DATE(SUBSTR(PLT_OBTER_DADOS_HOR_ITEM(:NR_SEQ_HORARIO, :IE_TIPO_ITEM, 'H'), 1, 10), 'DD/MM/YYYY') + 1, 'DD/MM/YYYY') = TO_CHAR(A.DT_HORARIO, 'DD/MM/YYYY'))
                OR (TO_CHAR(SUBSTR(PLT_OBTER_DADOS_HOR_ITEM(:NR_SEQ_HORARIO, :IE_TIPO_ITEM, 'H'), 1, 10)) = TO_CHAR(A.DT_HORARIO, 'DD/MM/YYYY'))
            )
            AND (
                (SUBSTR(PLT_OBTER_DADOS_HOR_ITEM(:NR_SEQ_HORARIO, :IE_TIPO_ITEM, 'H'), 12, 2) IN ('07', '08', '09', '10', '11', '12')
                 AND TO_CHAR(A.DT_HORARIO, 'HH24') IN ('07', '08', '09', '10', '11', '12'))
                OR (SUBSTR(PLT_OBTER_DADOS_HOR_ITEM(:NR_SEQ_HORARIO, :IE_TIPO_ITEM, 'H'), 12, 2) IN ('13', '14', '15', '16', '17', '18')
                    AND TO_CHAR(A.DT_HORARIO, 'HH24') IN ('13', '14', '15', '16', '17', '18'))
                OR (SUBSTR(PLT_OBTER_DADOS_HOR_ITEM(:NR_SEQ_HORARIO, :IE_TIPO_ITEM, 'H'), 12, 2) IN ('19', '20', '21', '22', '23', '00', '01', '02', '03', '04', '05', '06')
                    AND TO_CHAR(A.DT_HORARIO, 'HH24') IN ('19', '20', '21', '22', '23', '00', '01', '02', '03', '04', '05', '06'))
            )
        )
    )

UNION ALL
-- Seleciona dados da tabela HCB_ADEP_PROCEDIMENTOS2
SELECT 
    A.MED1,
    A.MED2,
    A.MED3,
    A.MED4,
    A.MED5,
    A.DOSE1,
    A.DOSE2,
    A.DOSE3,
    A.DOSE4,
    A.DOSE5,
    TO_CHAR(A.DT_HORARIO, 'DD/MM/YYYY HH24:MI') AS DS_HORARIO,
    A.DT_HORARIO,
    TO_CHAR(SUBSTR(PLT_OBTER_DADOS_HOR_ITEM(:NR_SEQ_HORARIO, :IE_TIPO_ITEM, 'H'), 1, 10)) AS DT,
    TO_CHAR(TO_DATE(SUBSTR(PLT_OBTER_DADOS_HOR_ITEM(:NR_SEQ_HORARIO, :IE_TIPO_ITEM, 'H'), 1, 10), 'DD/MM/YYYY') + 1, 'DD/MM/YYYY') AS DT2,
    A.NM_PESSOA2,
    A.DS_MATERIAL,
    A.NR_HORARIO,
    A.DS_LEITO,
    A.DS_DOSE,
    ' ' AS DS_VIA,
    A.DS_DIL1,
    A.DS_DIL2,
    A.DS_DIL3,
    A.DS_DIL4,
    A.DS_DIL5,
    A.DS_DIL6,
    A.DS_DIL7,
    A.DS_OBSERVACAO,
    DECODE(A.IE_TIPO_ITEM, 'G', 'P', 'P') AS IE_TIPO_ITEM
FROM 
    HCB_ADEP_PROCEDIMENTOS2 A
WHERE 
    A.NR_ATENDIMENTO = :NR_ATENDIMENTO
    AND (
        (HCB_OBTER_SE_SN_ADEP(:NR_SEQ_HORARIO) = 'S' AND A.IE_SE_NECESSARIO = 'S')
        OR (
            HCB_OBTER_SE_SN_ADEP(:NR_SEQ_HORARIO) = 'N' 
            AND A.IE_SE_NECESSARIO = 'N' 
            AND (
                (SUBSTR(PLT_OBTER_DADOS_HOR_ITEM(:NR_SEQ_HORARIO, :IE_TIPO_ITEM, 'H'), 12, 2) IN ('19', '20', '21', '22', '23')
                 AND TO_CHAR(TO_DATE(SUBSTR(PLT_OBTER_DADOS_HOR_ITEM(:NR_SEQ_HORARIO, :IE_TIPO_ITEM, 'H'), 1, 10), 'DD/MM/YYYY') + 1, 'DD/MM/YYYY') = TO_CHAR(A.DT_HORARIO, 'DD/MM/YYYY'))
                OR (TO_CHAR(SUBSTR(PLT_OBTER_DADOS_HOR_ITEM(:NR_SEQ_HORARIO, :IE_TIPO_ITEM, 'H'), 1, 10)) = TO_CHAR(A.DT_HORARIO, 'DD/MM/YYYY'))
            )
            AND (
                (SUBSTR(PLT_OBTER_DADOS_HOR_ITEM(:NR_SEQ_HORARIO, :IE_TIPO_ITEM, 'H'), 12, 2) IN ('07', '08', '09', '10', '11', '12')
                 AND SUBSTR(TO_CHAR(A.DT_HORARIO, 'DD/MM/YYYY HH24:MI:SS'), 12, 2) IN ('07', '08', '09', '10', '11', '12'))
                OR (SUBSTR(PLT_OBTER_DADOS_HOR_ITEM(:NR_SEQ_HORARIO, :IE_TIPO_ITEM, 'H'), 12, 2) IN ('13', '14', '15', '16', '17', '18')
                    AND SUBSTR(TO_CHAR(A.DT_HORARIO, 'DD/MM/YYYY HH24:MI:SS'), 12, 2) IN ('13', '14', '15', '16', '17', '18'))
                OR (SUBSTR(PLT_OBTER_DADOS_HOR_ITEM(:NR_SEQ_HORARIO, :IE_TIPO_ITEM, 'H'), 12, 2) IN ('19', '20', '21', '22', '23', '00', '01', '02', '03', '04', '05', '06')
                    AND SUBSTR(TO_CHAR(A.DT_HORARIO, 'DD/MM/YYYY HH24:MI:SS'), 12, 2) IN ('19', '20', '21', '22', '23', '00', '01', '02', '03', '04', '05', '06'))
            )
        )
    )
ORDER BY 
    DS_HORARIO,
    IE_TIPO_ITEM,
    DS_MATERIAL;
















---------------------------------------------------------------------------------------------------
-- backup da view HCB_ADEP_PROCEDIMENTOS2
---------------------------------------------------------------------------------------------------


  CREATE OR REPLACE FORCE EDITIONABLE VIEW "TASY"."HCB_ADEP_PROCEDIMENTOS2" ("cd_sequencia", "MED1", "MED2", "MED3", "MED4", "MED5", "DOSE1", "DOSE2", "DOSE3", "DOSE4", "DOSE5", "NR_SEQ_GASOTERAPIA", "DT_HORARIO", "NR_PRESCRICAO", "NM_PESSOA", "NM_PESSOA2", "DS_MATERIAL", "NR_HORARIO", "DS_LEITO", "DS_DOSE", "DS_DIL1", "DS_DIL2", "DS_DIL3", "DS_DIL4", "DS_DIL5", "DS_DIL6", "DS_DIL7", "IE_SE_NECESSARIO", "NR_SEQ_HORARIO", "IE_TIPO_ITEM", "NR_ATENDIMENTO", "NR_SEQ_PROC_INTERNO", "DS_OBSERVACAO") AS 
  select
'1' cd_sequencia,
TRANSLATE(HCB_OBTER_ITENS_GASO(A.NR_PRESCRICAO,c.nr_seq_gasoterapia, SUBSTR(to_char(c.dt_horario,'dd/mm/yyyy hh24:mi:ss'),12,2),1,1),'âàãáÁÂÀÃéêÉÊíÍóôõÓÔÕüúÜÚÇç','aaaaAAAAeeEEiIoooOOOuuUUCc') med1,
TRANSLATE(HCB_OBTER_ITENS_GASO(A.NR_PRESCRICAO,c.nr_seq_gasoterapia, SUBSTR(to_char(c.dt_horario,'dd/mm/yyyy hh24:mi:ss'),12,2),2,1),'âàãáÁÂÀÃéêÉÊíÍóôõÓÔÕüúÜÚÇç','aaaaAAAAeeEEiIoooOOOuuUUCc') med2,
TRANSLATE(HCB_OBTER_ITENS_GASO(A.NR_PRESCRICAO,c.nr_seq_gasoterapia, SUBSTR(to_char(c.dt_horario,'dd/mm/yyyy hh24:mi:ss'),12,2),3,1),'âàãáÁÂÀÃéêÉÊíÍóôõÓÔÕüúÜÚÇç','aaaaAAAAeeEEiIoooOOOuuUUCc') med3,
TRANSLATE(HCB_OBTER_ITENS_GASO(A.NR_PRESCRICAO,c.nr_seq_gasoterapia, SUBSTR(to_char(c.dt_horario,'dd/mm/yyyy hh24:mi:ss'),12,2),4,1),'âàãáÁÂÀÃéêÉÊíÍóôõÓÔÕüúÜÚÇç','aaaaAAAAeeEEiIoooOOOuuUUCc') med4,
TRANSLATE(HCB_OBTER_ITENS_GASO(A.NR_PRESCRICAO,c.nr_seq_gasoterapia, SUBSTR(to_char(c.dt_horario,'dd/mm/yyyy hh24:mi:ss'),12,2),5,1),'âàãáÁÂÀÃéêÉÊíÍóôõÓÔÕüúÜÚÇç','aaaaAAAAeeEEiIoooOOOuuUUCc') med5,
TRANSLATE(HCB_OBTER_ITENS_GASO(A.NR_PRESCRICAO,c.nr_seq_gasoterapia, SUBSTR(to_char(c.dt_horario,'dd/mm/yyyy hh24:mi:ss'),12,2),1,2),'âàãáÁÂÀÃéêÉÊíÍóôõÓÔÕüúÜÚÇç','aaaaAAAAeeEEiIoooOOOuuUUCc') DOSE1,
TRANSLATE(HCB_OBTER_ITENS_GASO(A.NR_PRESCRICAO,c.nr_seq_gasoterapia, SUBSTR(to_char(c.dt_horario,'dd/mm/yyyy hh24:mi:ss'),12,2),2,2),'âàãáÁÂÀÃéêÉÊíÍóôõÓÔÕüúÜÚÇç','aaaaAAAAeeEEiIoooOOOuuUUCc') DOSE2,
TRANSLATE(HCB_OBTER_ITENS_GASO(A.NR_PRESCRICAO,c.nr_seq_gasoterapia, SUBSTR(to_char(c.dt_horario,'dd/mm/yyyy hh24:mi:ss'),12,2),3,2),'âàãáÁÂÀÃéêÉÊíÍóôõÓÔÕüúÜÚÇç','aaaaAAAAeeEEiIoooOOOuuUUCc') DOSE3,
TRANSLATE(HCB_OBTER_ITENS_GASO(A.NR_PRESCRICAO,c.nr_seq_gasoterapia, SUBSTR(to_char(c.dt_horario,'dd/mm/yyyy hh24:mi:ss'),12,2),4,2),'âàãáÁÂÀÃéêÉÊíÍóôõÓÔÕüúÜÚÇç','aaaaAAAAeeEEiIoooOOOuuUUCc') DOSE4,
TRANSLATE(HCB_OBTER_ITENS_GASO(A.NR_PRESCRICAO,c.nr_seq_gasoterapia, SUBSTR(to_char(c.dt_horario,'dd/mm/yyyy hh24:mi:ss'),12,2),5,2),'âàãáÁÂÀÃéêÉÊíÍóôõÓÔÕüúÜÚÇç','aaaaAAAAeeEEiIoooOOOuuUUCc') DOSE5,
c.nr_seq_gasoterapia,
c.dt_horario,
a.NR_PRESCRICAO,
OBTER_NOME_PF(OBTER_PESSOA_ATENDIMENTO(A.NR_ATENDIMENTO,'C')) NM_PESSOA,
OBTER_NOME_SOCIAL_PF(OBTER_PESSOA_ATENDIMENTO(A.NR_ATENDIMENTO,'C')) NM_PESSOA2,
substr(obter_desc_gas(b.nr_seq_gas),1,180) DS_MATERIAL,
SUBSTR(to_char(c.dt_horario,'dd/mm/yyyy hh24:mi:ss'),12,2)nr_horario,
'DN: '||obter_dados_pf_dt(OBTER_PESSOA_ATENDIMENTO(A.NR_ATENDIMENTO,'C'),'DN')||' L: '||Obter_Unidade_Atendimento(A.NR_ATENDIMENTO,'A','U') DS_LEITO,
'Qtd: 1'||'  '|| obter_valor_dominio(2569,b.ie_inicio) DS_DOSE,
'' DS_DIL1,
'' DS_DIL2,
'' DS_DIL3,
'' DS_DIL4,
'' DS_DIL5,
'' DS_DIL6,
'' DS_DIL7,
'N' IE_SE_NECESSARIO,
c.nr_sequencia nr_seq_horario,
'O' ie_tipo_item,
A.NR_ATENDIMENTO,
'' NR_SEQ_PROC_INTERNO,
b.DS_OBSERVACAO
from	prescr_gasoterapia_hor c,
		prescr_gasoterapia b,
		prescr_medica a
where	c.nr_seq_gasoterapia = b.nr_sequencia
and		c.nr_prescricao = b.nr_prescricao
and		b.nr_prescricao = a.nr_prescricao
and		a.cd_prescritor is not null
and		coalesce(c.dt_fim_horario,c.dt_suspensao) is null
and		nvl(c.ie_horario_especial,'N') = 'N'
--and		nvl(substr(Obter_Status_Gasoterapia(b.nr_sequencia, 'C'),1,80),'N') = 'N' /*AJUSTADO 05/10/2023 - NÃO ESTAVA APARECENDO AS GASOTERAPIAS PENDENTES DE CHECAGEM NO ADEP*/
and		Obter_Status_Gasoterapia_n(b.nr_sequencia) = 'N'
and		nvl(a.ie_adep,'S') = 'S'
and		c.dt_lib_horario is not null
union
  SELECT 
'2' cd_sequencia,
'' med1,
'' med2,
'' med3,
'' med4,
'' med5,
'' DOSE1,
'' DOSE2,
'' DOSE3,
'' DOSE4,
'' DOSE5,
null NR_SEQ_GASOTERAPIA,
A.DT_HORARIO,
B.NR_PRESCRICAO,
--OBTER_PESSOA_ATENDIMENTO(A.NR_ATENDIMENTO,'N') NM_PESSOA,
OBTER_NOME_PF(OBTER_PESSOA_ATENDIMENTO(A.NR_ATENDIMENTO,'C')) NM_PESSOA,
OBTER_NOME_SOCIAL_PF(OBTER_PESSOA_ATENDIMENTO(A.NR_ATENDIMENTO,'C')) NM_PESSOA2,
TRANSLATE((OBTER_DESC_PRESCR_PROC(B.CD_PROCEDIMENTO, B.IE_ORIGEM_PROCED, B.NR_SEQ_PROC_INTERNO)),'âàãáÁÂÀÃéêÉÊíÍóôõÓÔÕüúÜÚÇç','aaaaAAAAeeEEiIoooOOOuuUUCc') DS_MATERIAL,
SUBSTR(plt_obter_dados_hor_item(a.nr_seq_horario,a.ie_tipo_item,'H'),12,2)nr_horario,
'DN: '||obter_dados_pf_dt(OBTER_PESSOA_ATENDIMENTO(A.NR_ATENDIMENTO,'C'),'DN')||' L: '||Obter_Unidade_Atendimento(A.NR_ATENDIMENTO,'A','U') DS_LEITO,
'Qtd: '||B.QT_PROCEDIMENTO||'  '||NVL(OBTER_DESC_INTERVALO_PRESCR(B.CD_INTERVALO), OBTER_DESC_INTERVALO(B.CD_INTERVALO))||'  '|| DECODE(B.IE_SE_NECESSARIO, 'S', 'SN', '') DS_DOSE,
'' DS_DIL1,
'' DS_DIL2,
'' DS_DIL3,
'' DS_DIL4,
'' DS_DIL5,
'' DS_DIL6,
'' DS_DIL7,
B.IE_SE_NECESSARIO,
a.nr_seq_horario,
a.ie_tipo_item,
A.NR_ATENDIMENTO,
to_char(B.NR_SEQ_PROC_INTERNO) NR_SEQ_PROC_INTERNO,
b.DS_OBSERVACAO
FROM ADEP_HOR_ITEM_V A, PRESCR_PROCEDIMENTO B
WHERE A.NR_PRESCRICAO = B.NR_PRESCRICAO
AND A.CD_ITEM = B.CD_PROCEDIMENTO
AND B.Dt_Suspensao IS NULL
AND A.IE_TIPO_ITEM in ('P','G')
AND A.IE_STATUS in ('N','E')
AND B.NR_SEQ_PROC_INTERNO IN (203,155,219,3684,3685,202);


  GRANT DELETE ON "TASY"."HCB_ADEP_PROCEDIMENTOS2" TO "JOSEO";
  GRANT INSERT ON "TASY"."HCB_ADEP_PROCEDIMENTOS2" TO "JOSEO";
  GRANT SELECT ON "TASY"."HCB_ADEP_PROCEDIMENTOS2" TO "JOSEO";
  GRANT UPDATE ON "TASY"."HCB_ADEP_PROCEDIMENTOS2" TO "JOSEO";
  GRANT REFERENCES ON "TASY"."HCB_ADEP_PROCEDIMENTOS2" TO "JOSEO";
  GRANT ON COMMIT REFRESH ON "TASY"."HCB_ADEP_PROCEDIMENTOS2" TO "JOSEO";
  GRANT QUERY REWRITE ON "TASY"."HCB_ADEP_PROCEDIMENTOS2" TO "JOSEO";
  GRANT DEBUG ON "TASY"."HCB_ADEP_PROCEDIMENTOS2" TO "JOSEO";
  GRANT FLASHBACK ON "TASY"."HCB_ADEP_PROCEDIMENTOS2" TO "JOSEO";
  GRANT MERGE VIEW ON "TASY"."HCB_ADEP_PROCEDIMENTOS2" TO "JOSEO";





// / ---------- SQL original ------------ \\\
SELECT PAGING.*,
    ROWNUM RecNo
FROM (
        select a.*,
            to_char(dt_alteracao, 'dd/mm/yyyy hh24:mi:ss') DT_ALTERACAO_GRID,
            substr(obter_valor_dominio(1620, ie_alteracao), 1, 100) DS_ALTERACAO,
            substr(obter_nome_pf(cd_pessoa_fisica), 1, 60) NM_PESSOA_FISICA,
            substr(ds_observacao, 1, 255) DS_OBSERVACAO_GRID,
            decode(
                nr_seq_item_sae,
                null,
                obter_data_inicio_prescr(nr_prescricao),
                to_date(
                    obter_dados_prescr_enf(nr_prescricao, 'I'),
                    'dd/mm/yyyy hh24:mi:ss'
                )
            ) DT_INICIO_PRESCR,
            decode(
                nr_seq_item_sae,
                null,
                obter_data_validade_prescr(nr_prescricao),
                to_date(
                    obter_dados_prescr_enf(nr_prescricao, 'T'),
                    'dd/mm/yyyy hh24:mi:ss'
                )
            ) DT_VALIDADE_PRESCR,
            substr(
                subst_ponto_virgula_adic_zero(obter_qt_dose_comp(nr_sequencia, qt_dose_adm)),
                1,
                20
            ) QT_DOSE_GRID,
            substr(
                obter_desc_qualidade_refeicao(nr_seq_qualidade),
                1,
                255
            ) DS_QUALIDADE,
            substr(obter_nome_pf(cd_medico_solic), 1, 255) DS_PESSOA_FISICA,
(
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
            and nr_atendimento = :nr_atendimento
            and ie_tipo_item = 'P'
            and (
                (cd_item = '94010046')
                or (
                    (ie_tipo_item = 'R')
                    and nvl(
                        replace(
                            replace(cd_item, chr(10), '#@#10#@'),
                            chr(13),
                            '#@#13#@'
                        ),
                        'XPTO'
                    ) = nvl('94010046', 'XPTO')
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
                                and b.cd_intervalo = '2/2'
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
            and nvl(nr_seq_proc_interno, 0) = 219
            and (
                (CD_UM_DOSE_ADM is null)
                or (ie_alteracao = 3)
                or (CD_UM_DOSE_ADM = CD_UM_DOSE_ADM)
            )
            and (nvl(nr_agrupamento, 0) = 0)
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
                        and b.cd_intervalo = '2/2'
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
        Order by NR_SEQUENCIA desc,
            DT_ATUALIZACAO_NREC desc
    ) PAGING // / ---------- SQL substituído ---------- \\\
SELECT PAGING.*,
    ROWNUM RecNo
FROM (
        select a.*,
            to_char(dt_alteracao, 'dd/mm/yyyy hh24:mi:ss') DT_ALTERACAO_GRID,
            substr(obter_valor_dominio(1620, ie_alteracao), 1, 100) DS_ALTERACAO,
            substr(obter_nome_pf(cd_pessoa_fisica), 1, 60) NM_PESSOA_FISICA,
            substr(ds_observacao, 1, 255) DS_OBSERVACAO_GRID,
            decode(
                nr_seq_item_sae,
                null,
                obter_data_inicio_prescr(nr_prescricao),
                to_date(
                    obter_dados_prescr_enf(nr_prescricao, 'I'),
                    'dd/mm/yyyy hh24:mi:ss'
                )
            ) DT_INICIO_PRESCR,
            decode(
                nr_seq_item_sae,
                null,
                obter_data_validade_prescr(nr_prescricao),
                to_date(
                    obter_dados_prescr_enf(nr_prescricao, 'T'),
                    'dd/mm/yyyy hh24:mi:ss'
                )
            ) DT_VALIDADE_PRESCR,
            substr(
                subst_ponto_virgula_adic_zero(obter_qt_dose_comp(nr_sequencia, qt_dose_adm)),
                1,
                20
            ) QT_DOSE_GRID,
            substr(
                obter_desc_qualidade_refeicao(nr_seq_qualidade),
                1,
                255
            ) DS_QUALIDADE,
            substr(obter_nome_pf(cd_medico_solic), 1, 255) DS_PESSOA_FISICA,
(
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
            and ie_tipo_item = 'P'
            and (
                (cd_item = '94010046')
                or (
                    (ie_tipo_item = 'R')
                    and nvl(
                        replace(
                            replace(cd_item, chr(10), '#@#10#@'),
                            chr(13),
                            '#@#13#@'
                        ),
                        'XPTO'
                    ) = nvl('94010046', 'XPTO')
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
                                and b.cd_intervalo = '2/2'
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
            and nvl(nr_seq_proc_interno, 0) = 219
            and (
                (CD_UM_DOSE_ADM is null)
                or (ie_alteracao = 3)
                or (CD_UM_DOSE_ADM = CD_UM_DOSE_ADM)
            )
            and (nvl(nr_agrupamento, 0) = 0)
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
                        and b.cd_intervalo = '2/2'
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
        Order by NR_SEQUENCIA desc,
            DT_ATUALIZACAO_NREC desc
    ) PAGING // / ---------- Parâmetro(s) ------------- \\\
    nr_atendimento --> '2043387'