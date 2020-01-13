create procedure add_device(
  device_type_id integer,
  real_estate_id integer,
  status integer,
  time_activated time without time zone,
  time_deactivated time without time zone,
  name character varying,
  ip character varying,
  to_alarm boolean,
  temperature integer,
  humidity integer,
  speed integer,
  color bigint,
  max_value bigint,
  power integer,
  password character varying
) language plpgsql as $ $ declare device_parameters_id_local int;

begin
insert into
  shcp.public.device_parameters
values
  (
    default,
    ip,
    to_alarm,
    temperature,
    humidity,
    speed,
    color,
    max_value,
    power,
    password
  );

select
  id
from
  shcp.public.device_parameters
order by
  id desc
limit
  1 into device_parameters_id_local;

insert into
  shcp.public.device
values
  (
    default,
    device_type_id,
    real_estate_id,
    status,
    time_activated,
    time_deactivated,
    device_parameters_id_local,
    name
  );

end $ $;

alter procedure add_device(
  integer,
  integer,
  integer,
  time,
  time,
  varchar,
  varchar,
  boolean,
  integer,
  integer,
  integer,
  bigint,
  bigint,
  integer,
  varchar
) owner to postgres;