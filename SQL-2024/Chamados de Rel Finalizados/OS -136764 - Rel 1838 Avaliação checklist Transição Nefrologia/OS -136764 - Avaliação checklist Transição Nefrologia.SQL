/*COD CHECK LIST: 101 - Transição do cuidado para Unidades de internação e UTIs*/
/*COD CHECK LIST: 117 -Transição do cuidado para Nefrologia*/

/*Não possui registros em produção*/
select * FROM med_avaliacao_paciente a where  a.nr_seq_tipo_avaliacao = 117
/********Banda dados do paciente (detalhe*******/
SELECT
    substr(obter_nome_pf(a.cd_pessoa_fisica),1,100) nm_paciente,
    DECODE(substr(obter_dados_pf(a.cd_pessoa_fisica,'SE'),1,100),'M','Masculino','F','Feminino','') sexo,
    substr(obter_dados_pf(a.cd_pessoa_fisica,'DN'),1,100) dt_nascimento,
    substr(obter_dados_pf(a.cd_pessoa_fisica,'I'),1,100)
    || ' Anos' idade,
    substr(obter_dados_pf(a.cd_pessoa_fisica,'NP'),1,100) prontuario,
    a.dt_avaliacao,
    substr(DECODE(a.nr_atendimento,'','Não possui atendimento.',a.nr_atendimento),1,100) nr_atendimento,
    a.nr_prescricao,
    substr(decode(a.dt_liberacao,'','Avaliação não liberada.',a.dt_liberacao),1,150) dt_liberacao,
    a.nm_usuario_nrec,
    a.nr_sequencia nr_seq_avaliacao_p
FROM
    med_avaliacao_paciente a
WHERE
    a.nr_sequencia = 505523--:nr_seq_avaliacao
    and a.nr_seq_tipo_avaliacao = 117
    and a.dt_liberacao is not null


/********Banda Avaliação(subdetalhe)************/    
    select  
    ' ' || SUBSTR(AVAL(NR_SEQUENCIA,3065),1,255) ORIGEM,
    ' ' || SUBSTR(AVAL(NR_SEQUENCIA,3066),1,255) DESTINO,
    ' ' || SUBSTR(AVAL(NR_SEQUENCIA,3068),1,255) MOTIVO_INT,
    /*Riscos*/
    SUBSTR(AVAL(NR_SEQUENCIA,3109),1,255) MORSE,
    DECODE(AVAL(NR_SEQUENCIA,3074),'S','X','') NAO_APLICA_MORSE,
    DECODE(AVAL(NR_SEQUENCIA,3069),'S','X','') ALERGIA_NAO,
    DECODE(AVAL(NR_SEQUENCIA,3075),'S','X','') ALERGIA_SIM,
    ' ' || SUBSTR(AVAL(NR_SEQUENCIA,3076),1,255) ALERGIA_QUAL,
    DECODE(AVAL(NR_SEQUENCIA,3079),'S','X','') BRONCO_SIM,
    DECODE(AVAL(NR_SEQUENCIA,3080),'S','X','') BRONCO_NAO,
    /*Isolamento*/
    DECODE(AVAL(NR_SEQUENCIA,3085),'S','X','') ISOLAMENTO_NAO,
    DECODE(AVAL(NR_SEQUENCIA,3086),'S','X','') ISOLAMENTO_SIM,
    ' ' || SUBSTR(AVAL(NR_SEQUENCIA,3087),1,255) ISOLAMENTO_QUAL,
    /*Escalas*/
    ' ' || SUBSTR(AVAL(NR_SEQUENCIA,3089),1,255) ECA,
    DECODE(AVAL(NR_SEQUENCIA,3090),'S','X','') ECA_NAO_APLICA,
    ' ' || SUBSTR(AVAL(NR_SEQUENCIA,3070),1,255) MEWS,
    DECODE(AVAL(NR_SEQUENCIA,3077),'S','X','') MEWS_NAO_APLICA,
    ' ' || SUBSTR(AVAL(NR_SEQUENCIA,3081),1,255) PEWS,
    DECODE(AVAL(NR_SEQUENCIA,3082),'S','X','') PEWS_NAO_APLICA,
    /*Sinais Vitais*/
    SUBSTR(AVAL(NR_SEQUENCIA,3113),1,255) || ' mm/Hg' PA,
    SUBSTR(AVAL(NR_SEQUENCIA,3114),1,255) || ' bpm' FC,
    SUBSTR(AVAL(NR_SEQUENCIA,3112),1,255) || ' %' SAT_O2,
    SUBSTR(AVAL(NR_SEQUENCIA,3111),1,255) || ' ipm' FR,
    SUBSTR(AVAL(NR_SEQUENCIA,3083),1,255) || ' C°' TEMPERATURA,
     /*Oxigenação*/
    DECODE(AVAL(NR_SEQUENCIA,3116),'S','X','') AA,
    DECODE(AVAL(NR_SEQUENCIA,3117),'S','X','') O2_ATRAVES,
    ' ' || SUBSTR(AVAL(NR_SEQUENCIA,3118),1,255) DS_O2_ATRAVES,
    DECODE(AVAL(NR_SEQUENCIA,3120),'S','X','') TQT_SIM,
    DECODE(AVAL(NR_SEQUENCIA,3121),'S','X','') TQT_NAO,
    /*Dietas*/
    DECODE(AVAL(NR_SEQUENCIA,3123),'S','X','') VO,
    DECODE(AVAL(NR_SEQUENCIA,3124),'S','X','') SNE_SNG,
    DECODE(AVAL(NR_SEQUENCIA,3125),'S','X','') DIETAS_OUTRO,
    ' ' || SUBSTR(AVAL(NR_SEQUENCIA,3126),1,255) DS_DIETAS_OUTRO,
    /*Acessos*/
    DECODE(AVAL(NR_SEQUENCIA,3128),'S','X','') AVP,
    ' ' || SUBSTR(AVAL(NR_SEQUENCIA,3129),1,255) AVP_LOCAL,
    DECODE(AVAL(NR_SEQUENCIA,3130),'S','X','') AVC,
    ' ' || SUBSTR(AVAL(NR_SEQUENCIA,3131),1,255) AVC_LOCAL,
    DECODE(AVAL(NR_SEQUENCIA,3060),'S','X','') FAV,
    ' ' || SUBSTR(AVAL(NR_SEQUENCIA,3061),1,255) FAV_LOCAL,
    /*Curativos*/
    DECODE(AVAL(NR_SEQUENCIA,3096),'S','X','') CURATIVO_NAO,
    DECODE(AVAL(NR_SEQUENCIA,3097),'S','X','') CURATIVO_SIM,
    ' ' || SUBSTR(AVAL(NR_SEQUENCIA,3098),1,255) CURATIVO_LOCAL,
    /*Drenos*/
    DECODE(AVAL(NR_SEQUENCIA,3092),'S','X','') DRENOS_NAO,
    DECODE(AVAL(NR_SEQUENCIA,3093),'S','X','') DRENOS_SIM,
    ' ' || SUBSTR(AVAL(NR_SEQUENCIA,3094),1,255) DRENOS_QUAL,
    /*Eliminação*/
    DECODE(AVAL(NR_SEQUENCIA,3133),'S','X','') ESPONTANEA,
    DECODE(AVAL(NR_SEQUENCIA,3134),'S','X','') SVD,
    DECODE(AVAL(NR_SEQUENCIA,3135),'S','X','') ELIM_OUTRO,
    ' ' || SUBSTR(AVAL(NR_SEQUENCIA,3136),1,255) DS_ELIM_OUTRO,
    /*Prescrição*/
    DECODE(AVAL(NR_SEQUENCIA,3100),'S','X','') VIGENTE_SIM,
    DECODE(AVAL(NR_SEQUENCIA,3101),'S','X','') VIGENTE_NAO,
    DECODE(AVAL(NR_SEQUENCIA,3139),'S','X','') LIBERADA_SIM,
    DECODE(AVAL(NR_SEQUENCIA,3140),'S','X','') LIBERADA_NAO,
    DECODE(AVAL(NR_SEQUENCIA,3142),'S','X','') MEDICACAO_SIM,
    DECODE(AVAL(NR_SEQUENCIA,3143),'S','X','') MEDICACAO_NAO,
    /*Pendências*/
    DECODE(AVAL(NR_SEQUENCIA,3103),'S','X','') PENDENCIA_NAO,
    DECODE(AVAL(NR_SEQUENCIA,3104),'S','X','') PENDENCIA_SIM,
    ' ' || SUBSTR(AVAL(NR_SEQUENCIA,3105),1,255) PENDENCIA_QUAL,
    /*Acompanhante*/
    DECODE(AVAL(NR_SEQUENCIA,3145),'S','X','') ACOMPANHANTE_SIM,
    DECODE(AVAL(NR_SEQUENCIA,3146),'S','X','') ACOMPANHANTE_NAO,
    
    ' ' || SUBSTR(AVAL(NR_SEQUENCIA,3106),1,255) OBSERVACAO,
    ' ' || SUBSTR(AVAL(NR_SEQUENCIA,3107),1,255) NM_ORIGEM,
    ' ' || SUBSTR(AVAL(NR_SEQUENCIA,3108),1,255) NM_DESTINO,
    /*Retorno*/
    ' ' || SUBSTR(AVAL(NR_SEQUENCIA,3151),1,255) RETORNO,
    ' ' || SUBSTR(AVAL(NR_SEQUENCIA,3152),1,255) TECNICO_ORIGEM,
    ' ' || SUBSTR(AVAL(NR_SEQUENCIA,3153),1,255) TECNICO_DESTINO
from    
    MED_AVALIACAO_PACIENTE a
where  
    a.NR_SEQUENCIA = :nr_seq_avaliacao_p

