create function get_devices() returns TABLE(
  name character varying,
  device_type_name character varying,
  real_estate_name character varying,
  status integer,
  ip character varying,
  to_alarm boolean,
  temperature integer,
  humidity integer,
  speed integer
) language sql as $ $
select
  device.name,
  device_type.name,
  real_estate.name,
  device.status,
  device_parameters.ip,
  device_parameters.to_alarm,
  device_parameters.temperature,
  device_parameters.humidity,
  device_parameters.speed
from
  shcp.public.device
  join shcp.public.device_type on device.device_type_id = device_type.id
  join shcp.public.real_estate on device.real_estate_id = real_estate.id
  join shcp.public.device_parameters on device.device_parameters_id = device_parameters.id;

$ $;

alter function get_devices() owner to postgres;