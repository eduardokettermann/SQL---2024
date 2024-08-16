create or replace function hcb_obter_pont_morse (nr_atendimento_p	number)
return varchar2 is
qt_pontuacao_w	varchar2(30);

begin

select	max(QT_PONTUACAO)
into	qt_pontuacao_w
from	ESCALA_MORSE a
where	nr_sequencia	= (	select	max(x.nr_sequencia)
				from	ESCALA_MORSE x
				where	x.nr_atendimento	= nr_atendimento_p
				and	x.dt_liberacao is not null
				and	x.dt_inativacao is null);

return to_char(qt_pontuacao_w);
--BY EDUARDOKLARA
end hcb_obter_pont_morse;

commit

--PONTUAÇÃO DA MORSE
SELECT substr(hcb_obter_pont_morse(:nr_atendimento),1,255) FROM DUAL

-------------------------------------------------------------------------------------------
create or replace function hcb_obter_pont_pews (nr_atendimento_p	number)
return varchar2 is
qt_pontuacao_w	varchar2(30);

begin

select	max(QT_PONTUACAO)
into	qt_pontuacao_w
from	ESCALA_PEWS a
where	nr_sequencia	= (	select	max(x.nr_sequencia)
				from	ESCALA_PEWS x
				where	x.nr_atendimento	= nr_atendimento_p
				and	x.dt_liberacao is not null
				and	x.dt_inativacao is null);

return to_char(qt_pontuacao_w);
--BY EDUARDOKLARA
end hcb_obter_pont_pews;














create or replace function Obter_Result_PEWS(qt_pontuacao_p		varchar2)
 		    	return varchar2 is

begin
if	(qt_pontuacao_p	>=7) then
	return	'Sugerida reavaliação a cada 30 minutos';
elsif	(qt_pontuacao_p	= 6) then
	return 'Sugerida reavaliação a cada 1 hora';
elsif	(qt_pontuacao_p	= 5) then
	return	'Sugerida reavaliação a cada uma ou 2 horas';
elsif	(qt_pontuacao_p	< 5) then
	return	'Sugerida reavaliação a cada 4 horas';
end if;

end Obter_Result_PEWS;