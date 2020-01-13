create function select_from_raw_command() returns setof shcp."public"."command" language sql as $ $
SELECT
  *
FROM
  shcp."public"."command";

$ $;

alter procedure select_from_raw_command() owner to postgres;