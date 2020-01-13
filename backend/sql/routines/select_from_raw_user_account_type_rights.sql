create function select_from_raw_user_account_type_rights() returns setof shcp."public"."user_account_type_rights" language sql as $ $
SELECT
  *
FROM
  shcp."public"."user_account_type_rights";

$ $;

alter procedure select_from_raw_user_account_type_rights() owner to postgres;