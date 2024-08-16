--SQL:
SELECT  
    'NEFROLOGIA' AS titulo,
    'Paciente: ' || obter_nome_pf(cd_pessoa_fisica) AS nm_pessoa_fisica,
    'Dt.Nasc: ' || obter_dados_pf(cd_pessoa_fisica, 'DN') AS dt_nascimento,
    'Dt. 1ª Lav: ' || DT_PRIM_LAVAGEM AS dt_primeira_lavagem,
    'Dt. 1ª Uso: ' || DT_PRIM_USO AS dt_primeiro_uso,
    'Modelo: ' || obter_desc_modelo_dialise(nr_seq_modelo) AS ds_modelo,
    'Priming Inic: ' || QT_PRIMING AS qt_priming_inicial,
    'Priming Final: ' || QT_PRIMING_FINAL AS qt_priming_final
FROM HD_DIALIZADOR
WHERE NR_DIALIZADOR = :NR_DIALIZADOR

--Linguagem EPL utilizada
Modelo EPL
Q100
q54
rN
S1
D7
ZT
JF
R20,0
N
A300,0,0,2,1,2,N,"&titulo"
A52,40,0,4,1,4,N,"&nm_pessoa_fisica"
A52,130,0,4,1,3,N,"&dt_nascimento"
A52,200,0,3,1,2,N,"&dt_primeira_lavagem"
A52,250,0,3,1,2,N,"&dt_primeiro_uso"
A52,300,0,3,1,2,N,"&ds_modelo"
A52,350,0,3,1,2,N,"&qt_priming_inicial"
A400,350,0,3,1,2,N,"&qt_priming_final"
P1
FE
 


 ---É UM OUTRO SQL DE ETIQUETA APENAS PARA GUARDAR O CÓDIGO
 SELECT
    substr(obter_nome_pf(a.cd_pessoa_fisica), 1,100) nm_pessoa_fisica,
        (
        SELECT b.ds_modelo
        FROM hd_modelo_dialisador b
        WHERE a.nr_seq_modelo = b.nr_sequencia
        )ds_modelo,
        substr(obter_valor_dominio(1956, a.ie_tipo),1, 100) ds_tipo,
        substr(hd_obter_desc_unid_dialise(a.nr_seq_unid_dialise), 1,80)  ds_unidade
FROM hd_dializador a
WHERE
( ( a.nr_dializador = nvl(:nr_dializador, 0) )OR ( nvl(:nr_dializador, 0) = 0 ) )
AND a.dt_priming BETWEEN :dt_inicial AND fim_dia(:dt_final)
ORDER BY 1