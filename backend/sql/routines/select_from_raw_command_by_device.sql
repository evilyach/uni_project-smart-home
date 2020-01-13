create function select_from_raw_command_by_device() returns setof shcp."public"."command_by_device" language sql as $ $
SELECT
  *
FROM
  shcp."public"."command_by_device";

$ $;

alter procedure select_from_raw_command_by_device() owner to postgres;