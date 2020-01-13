create function select_from_raw_command_type() returns setof shcp."public"."command_type" language sql as $ $
SELECT
  *
FROM
  shcp."public"."command_type";

$ $;

alter procedure select_from_raw_command_type() owner to postgres;