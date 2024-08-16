--         Média Permanência UTI Neonatal
-- (Total paciente  dia periodo) / total saidos periodo.

--SQL MODIFICADO MOSTRANDO RESULTADOS--
select 
SUM(NR_PAC_DIA)permanencia,
SUM(NR_ALTAS+NR_TRANSF_SAIDA+NR_OBITOS)saídasdosetor,
dividir(SUM(NR_PAC_DIA),SUM(NR_ALTAS+NR_TRANSF_SAIDA+NR_OBITOS))media
from EIS_CENSO_DIARIO_V2 a
where 1 = 1 
and CD_ESTABELECIMENTO = 1
AND CD_EMPRESA = a.CD_EMPRESA
and substr(obter_nome_setor(a.cd_setor_atendimento),1,200) is not null 
And Ie_Periodo = 'M'
And Dt_Referencia Between :Dt_Inicial  And :Dt_Final 
And A.Cd_Setor_Atendimento In (44)

--SQL ORIGINAL
select 
dividir(SUM(NR_PAC_DIA),SUM(NR_ALTAS+NR_TRANSF_SAIDA+NR_OBITOS)) nr_acum 
from EIS_CENSO_DIARIO_V2 a
where 1 = 1 
and CD_ESTABELECIMENTO = 1
AND CD_EMPRESA = a.CD_EMPRESA
and substr(obter_nome_setor(a.cd_setor_atendimento),1,200) is not null 
And Ie_Periodo = 'M'
And Dt_Referencia Between :Dt_Inicial  And :Dt_Final 
And A.Cd_Setor_Atendimento In (44)

--SQL MOSTRA DA ONDE SAI RESULTADO 
select DISTINCT (a.nm_paciente),
a.NR_PAC_DIA,
a.NR_ALTAS,
a.NR_TRANSF_SAIDA,
a.NR_OBITOs,
to_date(a.DT_ENTRADA, 'dd/mm/yyyy hh24:mi:ss')teste, 
a.DT_ALTA,
Obter_Hora_Entre_Datas(A.Dt_Entrada,A.Dt_Alta)média,
a.Dt_Referencia,
a.DT_ENTRADA - a.DT_ALTA resultado
from EIS_CENSO_DIARIO_V2 a
where 1 = 1 
and CD_ESTABELECIMENTO = 1
AND CD_EMPRESA = a.CD_EMPRESA
and substr(obter_nome_setor(a.cd_setor_atendimento),1,200) is not null 
And Ie_Periodo = 'M'
And DT_REFERENCIA Between :Dt_Inicial  And :Dt_Final 
And A.Cd_Setor_Atendimento In (44)
ORDER BY 2,3 desc
------------------------------------------------------------------
SELECT * FROM EIS_CENSO_DIARIO_V2 where Dt_entrada Between :Dt_Inicial  And :Dt_Final And Cd_Setor_Atendimento In (44)

SELECT DISTINCT
NM_PACIENTE,
DT_REFERENCIA,
CD_DIA,
DT_ENTRADA,
NR_PAC_DIA,
DT_ALTA,
NR_ALTAS,
NR_TRANSF_SAIDA,
NR_OBITOS
from EIS_CENSO_DIARIO_V2
where 1 = 1 
and CD_ESTABELECIMENTO = 1
AND CD_EMPRESA = CD_EMPRESA
and substr(obter_nome_setor(cd_setor_atendimento),1,200) is not null 
And Ie_Periodo = 'M'
And DT_REFERENCIA Between :Dt_Inicial  And :Dt_Final 
And Cd_Setor_Atendimento In (44) 
ORDER BY 5 DESC


----------teste-------
select 
DIVIDIR(SUM(NR_PAC_DIA),SUM(NR_ALTAS+NR_TRANSF_SAIDA+NR_OBITOS))
from EIS_CENSO_DIARIO_V3 a
where substr(obter_nome_setor(a.cd_setor_atendimento),1,200) is not null 
and ie_periodo = 'M'
and DT_REFERENCIA between :dt_inicial and fim_dia(:dt_final)
and cd_setor_atendimento = 44

select sum(nr_leitos_ocupados)*100/sum((nr_leitos_ocupados+nr_leitos_livres) - nr_unidades_interditadas)qt_ocupacao
from eis_ocupacao_setor_v a
where dt_referencia between :dt_inicial and fim_dia(:dt_final)
and ie_periodo='D'
and cd_estabelecimento= 1
and cd_setor_atendimento = 8
and ie_ocup_hospitalar='S'
having (avg(31)>0)
and  (sum((nr_leitos_ocupados+nr_leitos_livres) - nr_unidades_interditadas)>0)
union
select sum(nr_leitos_ocupados)*100/sum((nr_leitos_ocupados+nr_leitos_livres) - nr_unidades_interditadas)qt_ocupacao
from eis_ocupacao_setor_v a
where dt_referencia between :dt_inicial and fim_dia(:dt_final)
and ie_periodo= 'D'
and a.cd_setor_atendimento = 8
and cd_estabelecimento =1
and ie_ocup_hospitalar='S'
having (avg(31)>0)
and (sum((nr_leitos_ocupados+nr_leitos_livres)-nr_unidades_interditadas)>0)


---------SELECT TOTALIZADORES----------------------

select 
DIVIDIR(SUM(NR_PAC_DIA - qt_temp),SUM(NR_ALTAS+NR_TRANSF_SAIDA+NR_OBITOS)) total,
SUM(NR_PAC_DIA - qt_temp),
SUM(NR_ALTAS+NR_TRANSF_SAIDA+NR_OBITOS)
from EIS_CENSO_DIARIO_V2 a
where 1 = 1 
AND CD_ESTABELECIMENTO = 1
AND CD_EMPRESA = a.CD_EMPRESA
and SUBSTR(OBTER_NOME_CONVENIO(A.CD_CONVENIO),1,200) is not null 
and ie_periodo = 'M'
and DT_REFERENCIA between :dt_inicial and fim_dia(:dt_final)
and a.cd_setor_Atendimento in (44)

----------------------------------------select D = DIA

SELECT
    nm_paciente,
    TO_CHAR(dt_entrada,'dd/mm/yyyy hh24:mi:ss') entrada,
    TO_CHAR(dt_referencia,'dd/mm/yyyy hh24:mi:ss') referencia,
    TO_CHAR(dt_alta,'dd/mm/yyyy hh24:mi:ss') alta,
    a.NR_PAC_DIA, 
    a.NR_TRANSF_SAIDA,
    a.NR_OBITOS, 
    a.Ie_Periodo,
    A.NR_ALTAS
FROM
    eis_censo_diario_v2 a
WHERE
    a.DT_REFERENCIA BETWEEN :dt_inicial AND :dt_final
    AND cd_setor_atendimento IN ( 39 )
--    and nm_paciente = 'SOPHIA STREB'
    and a.Ie_Periodo = 'D'
    order by 1,3
    
    
 select DIVIDIR(SUM(NR_PAC_DIA),SUM(NR_ALTAS+NR_TRANSF_SAIDA+NR_OBITOS)) Med_perm 
from EIS_CENSO_DIARIO_V2 a
where a.DT_REFERENCIA BETWEEN :dt_inicial AND :dt_final 
and 1 = 1
and a.CD_SETOR_ATENDIMENTO  In (39)