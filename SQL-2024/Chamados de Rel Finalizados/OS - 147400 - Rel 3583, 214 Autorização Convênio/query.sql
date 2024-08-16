select  cd_setor_atendimento cd_setor_p,
        substr(obter_nome_setor(cd_setor_atendimento), 1, 150) ds_setor
from qua_evento_paciente
where (
        (nr_seq_evento = :nr_seq_evento) --Ou é sequencia que o usuário passar ou é tudo
        or (nvl(:nr_seq_evento, 0) = 0)
    )
    and 
    (
        (cd_setor_atendimento = :cd_setor)
        or (nvl(:cd_setor, 0) = 0)
    )
    --FILTRO DATA 
    and (
        nvl(:dt_inicial, '  /  /    ') = '  /  /    '
        or dt_evento >= to_date(:dt_inicial, 'dd/mm/yyyy')
    )
    and (
        nvl(:dt_final, '  /  /    ') = '  /  /    '
        or dt_evento <= to_date(:dt_final, 'dd/mm/yyyy')
    )
    and 
    --FILTRO ANÁLISE
    (
        (
            (dt_analise is not null)
            and (:ie_analise = 'S')
        )
        or (
            (dt_analise is null)
            and (:ie_analise = 'N')
        )
        or (:ie_analise = 'T')
    )

    and 
    --FILTRO LIBERAÇÃO
    (
        (
            (dt_liberacao is not null)
            and (:ie_liberacao = 'S')
        )
        or (
            (dt_liberacao is null)
            and (:ie_liberacao = 'N')
        )
        or (:ie_liberacao = 'T')
    )
group by cd_setor_atendimento
































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
