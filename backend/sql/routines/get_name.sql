create function get_name(_username character varying) returns TABLE(name character varying) language sql as $ $
select
  name
from
  shcp.public.user_account
where
  username = _username;

$ $;

alter function get_name(varchar) owner to postgres;