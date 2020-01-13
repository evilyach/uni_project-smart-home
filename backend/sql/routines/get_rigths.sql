create function get_rights(_username character varying) returns TABLE(
  read_data_right boolean,
  write_data_right boolean,
  read_raw_tables_right boolean,
  read_users_right boolean,
  write_users_right boolean,
  read_log_right boolean
) language sql as $ $
select
  read_data_right,
  write_data_right,
  read_raw_tables_right,
  read_users_right,
  write_users_right,
  read_log_right
from
  shcp.public.user_account_type_rights,
  shcp.public.user_account_type,
  shcp.public.user_account
where
  shcp.public.user_account_type_rights.id = shcp.public.user_account_type.user_account_type_rights_id
  and shcp.public.user_account_type.id = shcp.public.user_account.user_account_type_id
  and shcp.public.user_account.username = _username;

$ $;

alter function get_rights(varchar) owner to postgres;