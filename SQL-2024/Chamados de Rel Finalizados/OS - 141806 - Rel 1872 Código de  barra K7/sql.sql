--sql

Select :cd_barra as cd_barra 
from dual

Select :cd_barra as cd_barra 
from dual


--EPL UTILIZADO
Q160,400
S3
D15
ZB
JF
N
B115,30,0,1,2,7,70,B,"&cd_barra"
P1

-------------------------------------------
--ccon 3075- HCB - Etiqueta de identificação do bem 



I8,A,001
S1
D15
ZB
JF
N
A250,2,0,1,2,2,N," Patrimonio HCB"
A250,30,0,1,1,2,N," &ds_setor"
A195,240,2,2,2,N,""
B345,70,0,1,2,7,50,B,"&cd_bem"
A230,160,0,1,1,2,N,"&desc_campo"
A340,160,0,1,1,2,N,"  &cd_externo"
P&nr_etiquetas
FE

--exemplos
Q25
q831
rN
S1
D7
ZT
JB
R20,0
N
A300,1,0,1,1,2,N,"IDENTIFICACAO TI HCB"
A220,25,0,1,1,3,N,"Nome:"
A280,25,0,1,1,3,N,"&NOME"
A220,65,0,1,2,3,N,"IP:"
A280,65,0,1,2,3,N,"&IPP"
A220,102,0,1,1,1,N,"&OBSERVACAO"
P1
FE