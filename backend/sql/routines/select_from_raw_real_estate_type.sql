create function select_from_raw_real_estate_type() returns setof shcp."public"."real_estate_type" language sql as $ $
SELECT
  *
FROM
  shcp."public"."real_estate_type";

$ $;

alter procedure select_from_raw_real_estate_type() owner to postgres;