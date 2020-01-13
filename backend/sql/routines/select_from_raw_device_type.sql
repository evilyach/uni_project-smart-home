create function select_from_raw_device_type() returns setof shcp."public"."device_type" language sql as $ $
SELECT
  *
FROM
  shcp."public"."device_type";

$ $;

alter procedure select_from_raw_device_type() owner to postgres;