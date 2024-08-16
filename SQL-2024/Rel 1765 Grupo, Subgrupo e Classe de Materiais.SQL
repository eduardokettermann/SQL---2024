---------------------------------------------------
/** HCB - Grupo, Subgrupo e Classe de Materiais **/
---------------------------------------------------

-----------------------
/** BANDA PRINCIPAL **/
----------------------
SELECT 1 FROM DUAL

-----------------------
/** BANDA DADOS **/
----------------------
select
	a.CD_MATERIAL, 
	a.DS_MATERIAL,
	Obter_desc_grupo_mat(OBTER_ESTRUTURA_MATERIAL(a.CD_MATERIAL,'G')) DS_GRUPO_MATERIAL,
	Obter_desc_subgrupo_mat(OBTER_ESTRUTURA_MATERIAL(a.CD_MATERIAL,'S')) DS_SUBGRUPO_MATERIAL,
	Obter_desc_classe_mat(A.CD_CLASSE_MATERIAL) DS_CLASSE_MATERIAL
from
	MATERIAL a
where
	1=1
	and A.IE_SITUACAO = 'A'
	AND ((:CD_GRUPO_MATERIAL = 0) OR (OBTER_ESTRUTURA_MATERIAL(a.CD_MATERIAL,'G') = :CD_GRUPO_MATERIAL))
	AND ((:CD_SUBGRUPO_MATERIAL = 0) OR (OBTER_ESTRUTURA_MATERIAL(a.CD_MATERIAL,'S') = :CD_SUBGRUPO_MATERIAL))
	AND ((:CD_CLASSE_MATERIAL = 0) OR (A.CD_CLASSE_MATERIAL = :CD_CLASSE_MATERIAL))

@SQL_WHERE
ORDER BY 2
