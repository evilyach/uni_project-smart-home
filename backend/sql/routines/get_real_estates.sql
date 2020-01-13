create function select_real_estate_list() returns TABLE(id integer, name character varying) language sql as $ $
select
  shcp.public.real_estate.id,
  shcp.public.real_estate.name
from
  shcp.public.real_estate $ $;

alter function select_real_estate_list() owner to postgres;