create function select_from_raw_user_account() returns setof shcp."public"."user_account" language sql as $ $
SELECT
  *
FROM
  shcp."public"."user_account";

$ $;

alter procedure select_from_raw_user_account() owner to postgres;