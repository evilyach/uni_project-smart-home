create procedure add_log_record(
  _log_level character varying,
  _message character varying,
  _time time without time zone,
  _author character varying
) language sql as $ $
insert into
  shcp.public.log
values
  (
    default,
    _log_level,
    _message,
    _time,
    _author
  ) $ $;

alter procedure add_log_record(varchar, varchar, time, varchar) owner to postgres;