create function select_from_raw_devices_in_profile() returns setof shcp."public"."devices_in_profile" language sql as $ $
SELECT
  *
FROM
  shcp."public"."devices_in_profile";

$ $;

alter procedure select_from_raw_devices_in_profile() owner to postgres;