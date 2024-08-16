/*RELATÓRIO EVOLUÇÕES E DESCRISSÕES*/

select
a.cd_evolucao cd_evolucao_v2,
a.dt_evolucao,
a.cd_medico cd_pessoa_fisica,
SUBSTR(obter_nome_pessoa_fisica(a.cd_medico,''),1,60) nm_usuario,
substr(hcb_obter_ds_cod_prof(a.cd_medico),1,100) ds_codigo_prof,
substr(obter_ds_cod_prof(a.cd_medico),1,100) ds_codigo_prof2,
SUBSTR(obter_valor_dominio(72, a.ie_tipo_evolucao),1,60) ds_tipo_evolucao,
substr(obter_desc_tipo_evolucao(a.ie_evolucao_clinica),1,80) ds_evolucao_clinica,
SUBSTR(obter_desc_espec_medica(a.cd_especialidade),1,40) ds_especialidade,
a.dt_liberacao,
a.ie_evolucao_clinica
from evolucao_paciente a, PRONTUARIO_EMISSAO B
where a.nr_atendimento = B.nr_atendimento
AND b.nr_sequencia = :nr_sequencia
and a.cd_evolucao = :cd_evolucao_v
and a.dt_evolucao between b.DT_INICIAL and b.DT_FINAL
and a.ie_situacao = 'A'
--and a.ie_tipo_evolucao not in (1)
AND A.IE_EVOLUCAO_CLINICA NOT IN('ADE') --AJUSTE REALIZADO 05/03/2024
order by a.dt_evolucao


EX:
NR_SEQUENCIA=6597

ADE: ADEP - Medicamento