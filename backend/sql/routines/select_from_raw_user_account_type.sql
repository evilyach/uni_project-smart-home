create function select_from_raw_user_account_type() returns setof shcp."public"."user_account_type" language sql as $ $
SELECT
  *
FROM
  shcp."public"."user_account_type";

$ $;

alter procedure select_from_raw_user_account_type() owner to postgres;