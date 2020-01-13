create function select_from_raw_devices_by_user_account() returns setof shcp."public"."devices_by_user_account" language sql as $ $
SELECT
  *
FROM
  shcp."public"."devices_by_user_account";

$ $;

alter procedure select_from_raw_devices_by_user_account() owner to postgres;