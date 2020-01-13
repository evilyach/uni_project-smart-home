create function select_from_raw_real_estate() returns setof shcp."public"."real_estate" language sql as $ $
SELECT
  *
FROM
  shcp."public"."real_estate";

$ $;

alter procedure select_from_raw_real_estate() owner to postgres;