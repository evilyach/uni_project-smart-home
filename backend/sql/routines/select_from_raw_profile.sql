create function select_from_raw_profile() returns setof shcp."public"."profile" language sql as $ $
SELECT
  *
FROM
  shcp."public"."profile";

$ $;

alter procedure select_from_raw_profile() owner to postgres;