create function select_from_raw_device_parameters() returns setof shcp."public"."device_parameters" language sql as $ $
SELECT
  *
FROM
  shcp."public"."device_parameters";

$ $;

alter procedure select_from_raw_device_parameters() owner to postgres;