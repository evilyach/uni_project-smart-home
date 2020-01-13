create function select_from_raw_area() returns setof shcp."public"."area" language sql as $ $
SELECT
  *
FROM
  shcp."public"."area";

$ $;

alter procedure select_from_raw_area() owner to postgres;