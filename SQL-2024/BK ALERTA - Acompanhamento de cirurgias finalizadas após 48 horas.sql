select
a.NR_CIRURGIA
from
CIRURGIA a
where
a.DT_TERMINO is not null
and a.DT_INICIO_PREVISTA >= '15/06/2021'
AND ((((SELECT SYSDATE FROM DUAL) - a.DT_TERMINO)*1440)/60) >= 48
AND a.DT_LIBERACAO IS NULL
order by a.DT_TERMINO

--MODIFICIADO
select
a.NR_CIRURGIA
from
CIRURGIA a
where
a.DT_TERMINO is not null
and a.DT_INICIO_PREVISTA >= '15/06/2021'
AND ((((SELECT SYSDATE FROM DUAL) - a.DT_TERMINO)*1440)/60) >= 48
AND a.DT_LIBERACAO IS NULL
order by a.DT_TERMINO