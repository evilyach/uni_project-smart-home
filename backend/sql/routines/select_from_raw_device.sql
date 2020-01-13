create function select_from_raw_device() returns setof shcp."public"."device" language sql as $ $
SELECT
  *
FROM
  shcp."public"."device";

$ $;

alter procedure select_from_raw_device() owner to postgres;