create or replace function obter_email_pf(cd_pessoa_fisica_p varchar2)
 		    	return varchar2 is


ds_email_w		varchar2(255);

begin

select 	max(ds_email)
into	ds_email_w
from	COMPL_PESSOA_FISICA
where 	cd_pessoa_fisica = cd_pessoa_fisica_p
and	ie_tipo_complemento = '1';

if (ds_email_w is null) then
	select 	max(ds_email)
	into	ds_email_w
	from	COMPL_PESSOA_FISICA
	where 	cd_pessoa_fisica = cd_pessoa_fisica_p
	and	ie_tipo_complemento = '2';
end if;

return	ds_email_w;

end obter_email_pf;