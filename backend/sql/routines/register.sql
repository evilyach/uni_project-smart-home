create procedure register(
  user_account_type_id integer,
  name character varying,
  username character varying,
  password character varying,
  email character varying
) language sql as $ $
insert into
  shcp.public.user_account
values
  (
    default,
    user_account_type_id,
    name,
    username,
    password,
    email
  );

$ $;

alter procedure register(integer, varchar, varchar, varchar, varchar) owner to postgres;