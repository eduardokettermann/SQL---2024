---------------------
/** PARAMATROS **/
--------------------
-DATA
-TIPO SINTÉTICO
-TIPO ANALÍTICO
-PODERIA UTILIZAR FUNÇÃO 
-OBTER_DESC_SETOR_ATENDIMENTO(A.NR_ATENDIMENTO)
-FILTROS @SQLWHERE



---------------------
/** CD_CONVENIO **/
--------------------
--tipo:cd_conveio
--nome:convenio
--tipo:number
--apresentção: Multiseleção
--sqlwhere
{
Select cd_convenio cd, ds_convenio ds
from convenio
order by ds_convenio
}
---------------------------
/** CD_SETOR_ATENDIMENTO**/
--------------------------
--tipo:CD_SETOR_ATENDIMENTO
--nome:setor
--tipo:number
--apresentção: Multiseleção
--sqlwhere
{
select 
cd_setor_atendimento cd,
ds_setor_atendimento ds
from setor_atendimento 
where ie_situacao = 'A'
order by 2
}
--------------------------------





---------------------
/** SQL ANALÍTICO **/
--------------------
select  DISTINCT 
        X.NR_ATENDIMENTO NR_ATENDIMENTO,
        X.tipo_evolucao,
        X.vl_totaL,
        X.NM_PACIENTE,
        X.ds_convenio,
        obter_desc_setor_atend(X.cd_setor_atendimento) cd_setor
from
(
select distinct
nvl(SUBSTR(a.NR_ATENDIMENTO,1,255),'Pront:'||Obter_Prontuario_Paciente(A.CD_PESSOA_FISICA))NR_ATENDIMENTO,
max(A.DT_LIBERACAO),
a.IE_EVOLUCAO_CLINICA CD_EVOLUCAO_CLINICA,
OBTER_NOME_PESSOA_FISICA(a.CD_PESSOA_FISICA, null)NM_PACIENTE,
Obter_Convenio_Atendimento(a.NR_ATENDIMENTO)cd_convenio,
Obter_Nome_Convenio(Obter_Convenio_Atendimento(a.NR_ATENDIMENTO))ds_convenio,
b.DS_TIPO_EVOLUCAO tipo_evolucao,
count(a.IE_EVOLUCAO_CLINICA) vl_totaL,
a.CD_SETOR_ATENDIMENTO

from TIPO_EVOLUCAO b, evolucao_paciente_lib_v a
where 
b.CD_TIPO_EVOLUCAO = a.IE_EVOLUCAO_CLINICA
AND A.IE_SITUACAO = 'A'
and a.DT_LIBERACAO  between  :DT_INICIAL and FIM_DIA(:DT_FINAL) 
and (select distinct
    min(DT_LIBERACAO)
    from evolucao_paciente_lib_v
    where   DT_LIBERACAO between :DT_INICIAL and FIM_DIA(:DT_FINAL)
            and IE_EVOLUCAO_CLINICA = a.IE_EVOLUCAO_CLINICA 
            and Nr_Atendimento = a.nr_atendimento) = a.DT_LIBERACAO

group by 
a.IE_EVOLUCAO_CLINICA, 
OBTER_NOME_PESSOA_FISICA(a.CD_PESSOA_FISICA, null), 
Obter_Convenio_Atendimento(a.NR_ATENDIMENTO), 
Obter_Nome_Convenio(Obter_Convenio_Atendimento(a.NR_ATENDIMENTO)), 
nvl(SUBSTR(a.NR_ATENDIMENTO,1,255),'Pront:'||Obter_Prontuario_Paciente(A.CD_PESSOA_FISICA)), 
b.DS_TIPO_EVOLUCAO,
a.CD_SETOR_ATENDIMENTO
) x
where 1 = 1
@SQL_WHERE
and :tipo_relatorio = 'A'
ORDER BY X.NR_ATENDIMENTO




---------------------
/** SQL SINTÉTICO **/
--------------------
select 
X.NR_ATENDIMENTO NR_ATENDIMENTO,
X.tipo_evolucao,
X.vl_totaL,
obter_desc_setor_atend(x.cd_setor_atendimento) cd_setor
from
(
select
distinct nvl(SUBSTR(a.NR_ATENDIMENTO,1,255),'Pront:'||Obter_Prontuario_Paciente(A.CD_PESSOA_FISICA))NR_ATENDIMENTO,
a.IE_EVOLUCAO_CLINICA CD_EVOLUCAO_CLINICA,
Obter_Convenio_Atendimento(a.NR_ATENDIMENTO)cd_convenio,
b.DS_TIPO_EVOLUCAO tipo_evolucao,
count(a.IE_EVOLUCAO_CLINICA) vl_totaL,
a.CD_SETOR_ATENDIMENTO
from TIPO_EVOLUCAO b, evolucao_paciente_lib_v a
where 
b.CD_TIPO_EVOLUCAO = a.IE_EVOLUCAO_CLINICA
AND A.IE_SITUACAO = 'A'
and a.DT_LIBERACAO  between  :DT_INICIAL and FIM_DIA(:DT_FINAL) 
group by nvl(SUBSTR(a.NR_ATENDIMENTO,1,255),'Pront:'||Obter_Prontuario_Paciente(A.CD_PESSOA_FISICA)),
a.IE_EVOLUCAO_CLINICA, 
Obter_Convenio_Atendimento(a.NR_ATENDIMENTO),
b.DS_TIPO_EVOLUCAO, a.CD_SETOR_ATENDIMENTO 
) x
where 1 = 1
and :tipo_relatorio = 'S'
@SQL_WHERE