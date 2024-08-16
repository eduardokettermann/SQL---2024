/*RELATÓRIO 1270*/
--poderia utilizar função 
--Obter_Desc_Setor_Atendimento(a.nr_atendimento)
--Filtros @sqlwhere
----------------------------
--Dados Evolução  Sintético-
----------------------------
select  X.NR_ATENDIMENTO NR_ATENDIMENTO,
        X.tipo_evolucao,
        X.vl_totaL,
        obter_desc_setor_atend(x.cd_setor_atendimento) cd_setor
from
(
select distinct nvl(SUBSTR(a.NR_ATENDIMENTO,1,255),'Pront:'||Obter_Prontuario_Paciente(A.CD_PESSOA_FISICA))NR_ATENDIMENTO,
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

-----------------------------
--Dados Evolução  Analítico--
-----------------------------
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
and :tipo_relatorio = 'S'
@SQL_WHERE
ORDER BY X.NR_ATENDIMENTO