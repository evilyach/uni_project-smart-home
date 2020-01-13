--
-- PostgreSQL database dump
--

-- Dumped from database version 12.1
-- Dumped by pg_dump version 12.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: add_device(integer, integer, integer, time without time zone, time without time zone, character varying, character varying, boolean, integer, integer, integer, bigint, bigint, integer, character varying); Type: PROCEDURE; Schema: public; Owner: -
--

CREATE PROCEDURE public.add_device(device_type_id integer, real_estate_id integer, status integer, time_activated time without time zone, time_deactivated time without time zone, name character varying, ip character varying, to_alarm boolean, temperature integer, humidity integer, speed integer, color bigint, max_value bigint, power integer, password character varying)
    LANGUAGE plpgsql
    AS $$
declare
    device_parameters_id_local int;
begin
    insert into shcp.public.device_parameters
    values (default, ip, to_alarm, temperature, humidity, speed, color, max_value, power, password);

    select id
    from shcp.public.device_parameters
    order by id desc
    limit 1
    into device_parameters_id_local;

    insert into shcp.public.device
    values (default, device_type_id, real_estate_id, status, time_activated, time_deactivated, device_parameters_id_local, name);
end $$;


--
-- Name: add_log_record(character varying, character varying, time without time zone, character varying); Type: PROCEDURE; Schema: public; Owner: -
--

CREATE PROCEDURE public.add_log_record(_log_level character varying, _message character varying, _time time without time zone, _author character varying)
    LANGUAGE sql
    AS $$
    insert into shcp.public.log
    values (
       default,
       _log_level,
       _message,
       _time,
       _author
    )
$$;


--
-- Name: get_devices(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.get_devices() RETURNS TABLE(name character varying, device_type_name character varying, real_estate_name character varying, status smallint, ip character varying, to_alarm boolean, temperature integer, humidity integer, speed integer)
    LANGUAGE sql
    AS $$
    select device.name,
           device_type.name,
           real_estate.name,
           device.status,
           device_parameters.ip,
           device_parameters.to_alarm,
           device_parameters.temperature,
           device_parameters.humidity,
           device_parameters.speed
    from shcp.public.device
    join shcp.public.device_type
    on device.device_type_id = device_type.id
    join shcp.public.real_estate
    on device.real_estate_id = real_estate.id
    join shcp.public.device_parameters
    on device.device_parameters_id = device_parameters.id;
$$;


--
-- Name: get_name(character varying); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.get_name(_username character varying) RETURNS TABLE(name character varying)
    LANGUAGE sql
    AS $$
    select name
    from shcp.public.user_account
    where username = _username;
$$;


--
-- Name: get_rights(character varying); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.get_rights(_username character varying) RETURNS TABLE(read_data_right boolean, write_data_right boolean, read_raw_tables_right boolean, read_users_right boolean, write_users_right boolean, read_log_right boolean)
    LANGUAGE sql
    AS $$
   select read_data_right,
           write_data_right,
           read_raw_tables_right,
           read_users_right,
           write_users_right,
           read_log_right
    from shcp.public.user_account_type_rights, shcp.public.user_account_type, shcp.public.user_account
    where shcp.public.user_account_type_rights.id = shcp.public.user_account_type.user_account_type_rights_id and
          shcp.public.user_account_type.id = shcp.public.user_account.user_account_type_id and
          shcp.public.user_account.username = _username;

$$;


--
-- Name: register(integer, character varying, character varying, character varying, character varying); Type: PROCEDURE; Schema: public; Owner: -
--

CREATE PROCEDURE public.register(user_account_type_id integer, name character varying, username character varying, password character varying, email character varying)
    LANGUAGE sql
    AS $$
    insert into shcp.public.user_account
    values (default, user_account_type_id, name, username, password, email);
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: area; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.area (
    id integer NOT NULL,
    name character varying NOT NULL
);


--
-- Name: TABLE area; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.area IS 'Тип пространства';


--
-- Name: select_from_raw_area(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.select_from_raw_area() RETURNS SETOF public.area
    LANGUAGE sql
    AS $$
SELECT * FROM shcp."public"."area";
$$;


--
-- Name: command; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.command (
    id integer NOT NULL,
    command_type_id integer NOT NULL,
    device_id integer NOT NULL,
    profile_id integer NOT NULL,
    argvar character varying NOT NULL
);


--
-- Name: TABLE command; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.command IS 'Команда';


--
-- Name: select_from_raw_command(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.select_from_raw_command() RETURNS SETOF public.command
    LANGUAGE sql
    AS $$
SELECT * FROM shcp."public"."command";
$$;


--
-- Name: command_by_device; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.command_by_device (
    command_id integer NOT NULL,
    device_id integer NOT NULL
);


--
-- Name: TABLE command_by_device; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.command_by_device IS 'Управление';


--
-- Name: select_from_raw_command_by_device(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.select_from_raw_command_by_device() RETURNS SETOF public.command_by_device
    LANGUAGE sql
    AS $$
SELECT * FROM shcp."public"."command_by_device";
$$;


--
-- Name: command_type; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.command_type (
    id integer NOT NULL,
    name character varying NOT NULL,
    argvar character varying
);


--
-- Name: TABLE command_type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.command_type IS 'Тип команды';


--
-- Name: select_from_raw_command_type(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.select_from_raw_command_type() RETURNS SETOF public.command_type
    LANGUAGE sql
    AS $$
SELECT * FROM shcp."public"."command_type";
$$;


--
-- Name: device; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.device (
    id integer NOT NULL,
    device_type_id integer NOT NULL,
    real_estate_id integer NOT NULL,
    status smallint NOT NULL,
    time_activated time without time zone,
    time_deactivated time without time zone,
    device_parameters_id integer NOT NULL,
    name character varying NOT NULL
);


--
-- Name: TABLE device; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.device IS 'Устройства';


--
-- Name: select_from_raw_device(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.select_from_raw_device() RETURNS SETOF public.device
    LANGUAGE sql
    AS $$
SELECT * FROM shcp."public"."device";
$$;


--
-- Name: device_parameters; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.device_parameters (
    id integer NOT NULL,
    ip character varying,
    to_alarm boolean,
    temperature integer,
    humidity integer,
    speed integer,
    color bigint,
    max_value bigint,
    power integer,
    password character varying
);


--
-- Name: TABLE device_parameters; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.device_parameters IS 'Параметры устройства';


--
-- Name: select_from_raw_device_parameters(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.select_from_raw_device_parameters() RETURNS SETOF public.device_parameters
    LANGUAGE sql
    AS $$
SELECT * FROM shcp."public"."device_parameters";
$$;


--
-- Name: device_type; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.device_type (
    id integer NOT NULL,
    name character varying NOT NULL,
    description text
);


--
-- Name: TABLE device_type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.device_type IS 'Тип устройства';


--
-- Name: select_from_raw_device_type(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.select_from_raw_device_type() RETURNS SETOF public.device_type
    LANGUAGE sql
    AS $$
SELECT * FROM shcp."public"."device_type";
$$;


--
-- Name: devices_by_user_account; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.devices_by_user_account (
    user_account_id integer NOT NULL,
    device_id integer NOT NULL
);


--
-- Name: TABLE devices_by_user_account; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.devices_by_user_account IS 'Контролируемые учетной записью устройства';


--
-- Name: select_from_raw_devices_by_user_account(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.select_from_raw_devices_by_user_account() RETURNS SETOF public.devices_by_user_account
    LANGUAGE sql
    AS $$
SELECT * FROM shcp."public"."devices_by_user_account";
$$;


--
-- Name: devices_in_profile; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.devices_in_profile (
    profile_id integer NOT NULL,
    device_id integer NOT NULL
);


--
-- Name: TABLE devices_in_profile; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.devices_in_profile IS 'Содержащиеся в профиле устройства';


--
-- Name: select_from_raw_devices_in_profile(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.select_from_raw_devices_in_profile() RETURNS SETOF public.devices_in_profile
    LANGUAGE sql
    AS $$
SELECT * FROM shcp."public"."devices_in_profile";
$$;


--
-- Name: profile; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.profile (
    id integer NOT NULL,
    user_account_id integer NOT NULL,
    name integer
);


--
-- Name: TABLE profile; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.profile IS 'Профиль';


--
-- Name: select_from_raw_profile(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.select_from_raw_profile() RETURNS SETOF public.profile
    LANGUAGE sql
    AS $$
SELECT * FROM shcp."public"."profile";
$$;


--
-- Name: real_estate; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.real_estate (
    id integer NOT NULL,
    real_estate_type_id integer NOT NULL,
    area_id integer NOT NULL,
    name character varying NOT NULL,
    address character varying NOT NULL,
    description text
);


--
-- Name: select_from_raw_real_estate(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.select_from_raw_real_estate() RETURNS SETOF public.real_estate
    LANGUAGE sql
    AS $$
SELECT * FROM shcp."public"."real_estate";
$$;


--
-- Name: real_estate_type; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.real_estate_type (
    id integer NOT NULL,
    name character varying NOT NULL
);


--
-- Name: TABLE real_estate_type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.real_estate_type IS 'Тип помещения';


--
-- Name: select_from_raw_real_estate_type(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.select_from_raw_real_estate_type() RETURNS SETOF public.real_estate_type
    LANGUAGE sql
    AS $$
SELECT * FROM shcp."public"."real_estate_type";
$$;


--
-- Name: user_account; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_account (
    id integer NOT NULL,
    user_account_type_id integer NOT NULL,
    name character varying,
    username character varying NOT NULL,
    password character varying NOT NULL,
    email character varying NOT NULL
);


--
-- Name: TABLE user_account; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.user_account IS 'Учетная запись';


--
-- Name: select_from_raw_user_account(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.select_from_raw_user_account() RETURNS SETOF public.user_account
    LANGUAGE sql
    AS $$
SELECT * FROM shcp."public"."user_account";
$$;


--
-- Name: user_account_type; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_account_type (
    id integer NOT NULL,
    name character varying NOT NULL,
    user_account_type_rights_id integer NOT NULL
);


--
-- Name: TABLE user_account_type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.user_account_type IS 'Тип учетной записи';


--
-- Name: select_from_raw_user_account_type(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.select_from_raw_user_account_type() RETURNS SETOF public.user_account_type
    LANGUAGE sql
    AS $$
SELECT * FROM shcp."public"."user_account_type";
$$;


--
-- Name: user_account_type_rights; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_account_type_rights (
    id integer NOT NULL,
    read_data_right boolean,
    write_data_right boolean,
    read_raw_tables_right boolean,
    read_users_right boolean,
    write_users_right boolean,
    read_log_right boolean
);


--
-- Name: TABLE user_account_type_rights; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.user_account_type_rights IS 'Права типа учетной записи';


--
-- Name: select_from_raw_user_account_type_rights(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.select_from_raw_user_account_type_rights() RETURNS SETOF public.user_account_type_rights
    LANGUAGE sql
    AS $$
SELECT * FROM shcp."public"."user_account_type_rights";
$$;


--
-- Name: select_real_estate_list(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.select_real_estate_list() RETURNS TABLE(id integer, name character varying)
    LANGUAGE sql
    AS $$
    select shcp.public.real_estate.id,
           shcp.public.real_estate.name
    from shcp.public.real_estate
$$;


--
-- Name: area_id_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.area_id_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: area_id_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.area_id_id_seq OWNED BY public.area.id;


--
-- Name: command_by_device_command_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.command_by_device_command_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: command_by_device_command_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.command_by_device_command_id_seq OWNED BY public.command_by_device.command_id;


--
-- Name: command_by_device_device_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.command_by_device_device_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: command_by_device_device_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.command_by_device_device_id_seq OWNED BY public.command_by_device.device_id;


--
-- Name: command_command_type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.command_command_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: command_command_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.command_command_type_id_seq OWNED BY public.command.command_type_id;


--
-- Name: command_device_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.command_device_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: command_device_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.command_device_id_seq OWNED BY public.command.device_id;


--
-- Name: command_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.command_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: command_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.command_id_seq OWNED BY public.command.id;


--
-- Name: command_profile_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.command_profile_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: command_profile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.command_profile_id_seq OWNED BY public.command.profile_id;


--
-- Name: command_type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.command_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: command_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.command_type_id_seq OWNED BY public.command_type.id;


--
-- Name: device_device_type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.device_device_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: device_device_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.device_device_type_id_seq OWNED BY public.device.device_type_id;


--
-- Name: device_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.device_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: device_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.device_id_seq OWNED BY public.device.id;


--
-- Name: device_parameters_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.device_parameters_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: device_parameters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.device_parameters_id_seq OWNED BY public.device_parameters.id;


--
-- Name: device_real_estate_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.device_real_estate_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: device_real_estate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.device_real_estate_id_seq OWNED BY public.device.real_estate_id;


--
-- Name: device_type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.device_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: device_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.device_type_id_seq OWNED BY public.device_type.id;


--
-- Name: devices_by_user_account_device_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.devices_by_user_account_device_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: devices_by_user_account_device_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.devices_by_user_account_device_id_seq OWNED BY public.devices_by_user_account.device_id;


--
-- Name: devices_by_user_account_user_account_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.devices_by_user_account_user_account_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: devices_by_user_account_user_account_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.devices_by_user_account_user_account_id_seq OWNED BY public.devices_by_user_account.user_account_id;


--
-- Name: devices_in_profile_device_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.devices_in_profile_device_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: devices_in_profile_device_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.devices_in_profile_device_id_seq OWNED BY public.devices_in_profile.device_id;


--
-- Name: devices_in_profile_profile_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.devices_in_profile_profile_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: devices_in_profile_profile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.devices_in_profile_profile_id_seq OWNED BY public.devices_in_profile.profile_id;


--
-- Name: get_passwords; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.get_passwords AS
 SELECT user_account.password
   FROM public.user_account;


--
-- Name: get_users; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.get_users AS
 SELECT user_account.username
   FROM public.user_account;


--
-- Name: log; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.log (
    id bigint NOT NULL,
    log_level character varying NOT NULL,
    message character varying,
    "time" time without time zone NOT NULL,
    author character varying NOT NULL
);


--
-- Name: log_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.log_id_seq OWNED BY public.log.id;


--
-- Name: profile_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.profile_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: profile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.profile_id_seq OWNED BY public.profile.id;


--
-- Name: profile_user_account_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.profile_user_account_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: profile_user_account_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.profile_user_account_id_seq OWNED BY public.profile.user_account_id;


--
-- Name: real_estate_area_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.real_estate_area_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: real_estate_area_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.real_estate_area_id_seq OWNED BY public.real_estate.area_id;


--
-- Name: real_estate_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.real_estate_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: real_estate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.real_estate_id_seq OWNED BY public.real_estate.id;


--
-- Name: real_estate_real_estate_type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.real_estate_real_estate_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: real_estate_real_estate_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.real_estate_real_estate_type_id_seq OWNED BY public.real_estate.real_estate_type_id;


--
-- Name: real_estate_type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.real_estate_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: real_estate_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.real_estate_type_id_seq OWNED BY public.real_estate_type.id;


--
-- Name: user_account_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_account_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_account_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_account_id_seq OWNED BY public.user_account.id;


--
-- Name: user_account_type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_account_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_account_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_account_type_id_seq OWNED BY public.user_account_type.id;


--
-- Name: user_account_type_rights_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_account_type_rights_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_account_type_rights_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_account_type_rights_id_seq OWNED BY public.user_account_type_rights.id;


--
-- Name: user_account_type_user_account_type_rights_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_account_type_user_account_type_rights_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_account_type_user_account_type_rights_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_account_type_user_account_type_rights_id_seq OWNED BY public.user_account_type.user_account_type_rights_id;


--
-- Name: user_account_user_account_type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_account_user_account_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_account_user_account_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_account_user_account_type_id_seq OWNED BY public.user_account.user_account_type_id;


--
-- Name: area id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.area ALTER COLUMN id SET DEFAULT nextval('public.area_id_id_seq'::regclass);


--
-- Name: command id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.command ALTER COLUMN id SET DEFAULT nextval('public.command_id_seq'::regclass);


--
-- Name: command command_type_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.command ALTER COLUMN command_type_id SET DEFAULT nextval('public.command_command_type_id_seq'::regclass);


--
-- Name: command device_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.command ALTER COLUMN device_id SET DEFAULT nextval('public.command_device_id_seq'::regclass);


--
-- Name: command profile_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.command ALTER COLUMN profile_id SET DEFAULT nextval('public.command_profile_id_seq'::regclass);


--
-- Name: command_by_device command_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.command_by_device ALTER COLUMN command_id SET DEFAULT nextval('public.command_by_device_command_id_seq'::regclass);


--
-- Name: command_by_device device_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.command_by_device ALTER COLUMN device_id SET DEFAULT nextval('public.command_by_device_device_id_seq'::regclass);


--
-- Name: command_type id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.command_type ALTER COLUMN id SET DEFAULT nextval('public.command_type_id_seq'::regclass);


--
-- Name: device id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.device ALTER COLUMN id SET DEFAULT nextval('public.device_id_seq'::regclass);


--
-- Name: device device_type_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.device ALTER COLUMN device_type_id SET DEFAULT nextval('public.device_device_type_id_seq'::regclass);


--
-- Name: device real_estate_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.device ALTER COLUMN real_estate_id SET DEFAULT nextval('public.device_real_estate_id_seq'::regclass);


--
-- Name: device_parameters id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.device_parameters ALTER COLUMN id SET DEFAULT nextval('public.device_parameters_id_seq'::regclass);


--
-- Name: device_type id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.device_type ALTER COLUMN id SET DEFAULT nextval('public.device_type_id_seq'::regclass);


--
-- Name: devices_by_user_account user_account_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.devices_by_user_account ALTER COLUMN user_account_id SET DEFAULT nextval('public.devices_by_user_account_user_account_id_seq'::regclass);


--
-- Name: devices_by_user_account device_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.devices_by_user_account ALTER COLUMN device_id SET DEFAULT nextval('public.devices_by_user_account_device_id_seq'::regclass);


--
-- Name: devices_in_profile profile_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.devices_in_profile ALTER COLUMN profile_id SET DEFAULT nextval('public.devices_in_profile_profile_id_seq'::regclass);


--
-- Name: devices_in_profile device_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.devices_in_profile ALTER COLUMN device_id SET DEFAULT nextval('public.devices_in_profile_device_id_seq'::regclass);


--
-- Name: log id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.log ALTER COLUMN id SET DEFAULT nextval('public.log_id_seq'::regclass);


--
-- Name: profile id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.profile ALTER COLUMN id SET DEFAULT nextval('public.profile_id_seq'::regclass);


--
-- Name: profile user_account_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.profile ALTER COLUMN user_account_id SET DEFAULT nextval('public.profile_user_account_id_seq'::regclass);


--
-- Name: real_estate id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.real_estate ALTER COLUMN id SET DEFAULT nextval('public.real_estate_id_seq'::regclass);


--
-- Name: real_estate real_estate_type_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.real_estate ALTER COLUMN real_estate_type_id SET DEFAULT nextval('public.real_estate_real_estate_type_id_seq'::regclass);


--
-- Name: real_estate area_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.real_estate ALTER COLUMN area_id SET DEFAULT nextval('public.real_estate_area_id_seq'::regclass);


--
-- Name: real_estate_type id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.real_estate_type ALTER COLUMN id SET DEFAULT nextval('public.real_estate_type_id_seq'::regclass);


--
-- Name: user_account id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_account ALTER COLUMN id SET DEFAULT nextval('public.user_account_id_seq'::regclass);


--
-- Name: user_account user_account_type_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_account ALTER COLUMN user_account_type_id SET DEFAULT nextval('public.user_account_user_account_type_id_seq'::regclass);


--
-- Name: user_account_type id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_account_type ALTER COLUMN id SET DEFAULT nextval('public.user_account_type_id_seq'::regclass);


--
-- Name: user_account_type user_account_type_rights_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_account_type ALTER COLUMN user_account_type_rights_id SET DEFAULT nextval('public.user_account_type_user_account_type_rights_id_seq'::regclass);


--
-- Name: user_account_type_rights id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_account_type_rights ALTER COLUMN id SET DEFAULT nextval('public.user_account_type_rights_id_seq'::regclass);


--
-- Data for Name: area; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.area (id, name) FROM stdin;
1	Дом на Пушкина
2	Гараж в Недостоево
3	Офис в Москва Сити
4	Дача в Мурманске
\.


--
-- Data for Name: command; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.command (id, command_type_id, device_id, profile_id, argvar) FROM stdin;
\.


--
-- Data for Name: command_by_device; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.command_by_device (command_id, device_id) FROM stdin;
\.


--
-- Data for Name: command_type; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.command_type (id, name, argvar) FROM stdin;
1	toggle	mode
2	change_ip	ip
3	change_to_alarm	mode
4	change_temperature	temp
5	change_humidity	humidity
6	change_speed	speed
7	change_color	color
8	change_max_value	val
9	set_new_password	password
10	change_power	power
\.


--
-- Data for Name: device; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.device (id, device_type_id, real_estate_id, status, time_activated, time_deactivated, device_parameters_id, name) FROM stdin;
13	1	2	0	06:42:50	06:42:50	43	Samsung Smart Fridge
\.


--
-- Data for Name: device_parameters; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.device_parameters (id, ip, to_alarm, temperature, humidity, speed, color, max_value, power, password) FROM stdin;
1	192.168.0.100	\N	-20	\N	\N	\N	\N	2000	password
3	10.10.10.90	\N	\N	\N	10	\N	20	2100	vacuum
4	192.168.0.200	t	\N	\N	\N	\N	10	\N	admin
5	192.168.0.102	t	100	\N	10800	0	100	700	
6	192.168.0.103	t	100	\N	7200	\N	\N	\N	wanna_coffee
7	16.10.16.10	\N	\N	\N	\N	\N	5	\N	\N
8	192.168.0.104	t	95	100	10800	\N	\N	\N	lol
9	10.90.90.128	t	\N	\N	\N	\N	\N	\N	s4fe-p4$$w0rd
10	192.168.0.105	t	24	54	\N	555555	\N	\N	
2	192.168.0.101	\N	30	\N	800	\N	\N	1500	admin
11	160.1.1.1	\N	\N	\N	\N	434343	\N	40	\N
14	192.168.0.1	\N	5	\N	\N	\N	\N	2000	sha1$3c56f095$1$bba84c08c9d27b4c7e40a8003ae931072454c331
15	192.168.1.111	\N	\N	\N	\N	4539717	\N	\N	sha1$deac55fa$1$7bf96bbfd18fdf391fed75745ae7552d1fa02414
25	10.90.90.228	t	\N	\N	\N	\N	1337	\N	sha1$ae910306$1$ed3b31db1cc20bcf4d5ab8230bf080534fa7fc23
28	10.90.90.90	\N	\N	\N	10	\N	10	2100	sha1$3cbfb454$1$4903cd0e064e888c6488e1b1dd23b04c844f2322
38	192.168.0.1	\N	4	\N	\N	\N	\N	2000	sha1$b5f314a9$1$23176420f0e179e0870cacbd45554025e4df93db
40	192.168.1.221	t	5	\N	\N	162787	\N	\N	sha1$bc9dc040$1$8740e364bbbd4e33cdea54fa3591b7e2ae8c3f92
41	192.168.1.222	\N	4	\N	\N	2845345	\N	\N	sha1$93b57a06$1$02cc8b4ad15440ee6c62a930e88491d92dbf9026
43	192.168.0.1	\N	-20	\N	\N	\N	\N	2000	sha1$2f65bed3$1$760363a764a270b2586aab6dbf85b493393ced18
\.


--
-- Data for Name: device_type; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.device_type (id, name, description) FROM stdin;
1	Умный холодильник	Управлять им можно через Wi-Fi. Большой сенсорный экран с портретной ориентацией находится на правой верхней дверце.
2	Умная стиральная машина	Как и другие из этой серии, укомплектована модулем Wi-Fi. Это позволяет поддерживать управление удаленно.
3	Робот-пылесос	Вакуумный робот-пылесос управляется удаленно посредством мобильного приложения, т.е. является IoT-подключенным.
4	Система видеонаблюдения	Этот гаджет для видеонаблюдения, позволит контролировать обстановку в доме, на даче, в гараже.
5	Интеллектуальный чайник	Нагрев может сопровождаться музыкой, а дети в ожидании чая могут поиграть в развивающие игры. Они тоже есть в приложении.
6	Кофеварка	Эта кофемашина компании с поддержкой Wi-Fi управляется с планшета или смартфона.
7	Умные кухонные весы	Весы позволяют узнать о сбалансированности и сочетаемости компонентов в продуктах.
8	Посудомоечная машина	Посудомоечная машина с подключением к интернету. Это устройство частично встраиваемое.
9	Умный замок	Обо всех заходах и выходах владелец дома получает оповещения на телефон.
10	Климатконтроль	При помощи этого гаджета регулируют настройки микроклимата: освещенность, влажность, температуру.
11	Умная лампочка	Посредством этих устройств включают/выключают освещение, настраивают режим и продолжительность освещения, создают цветовую атмосферу.
\.


--
-- Data for Name: devices_by_user_account; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.devices_by_user_account (user_account_id, device_id) FROM stdin;
\.


--
-- Data for Name: devices_in_profile; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.devices_in_profile (profile_id, device_id) FROM stdin;
\.


--
-- Data for Name: log; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.log (id, log_level, message, "time", author) FROM stdin;
1	info	Добавлено устройство "Климатконтроль" с именем Кондиционер	05:35:35	evilyach
2	info	Пользователь с именем evilyach вышел из системы	05:51:12	evilyach
3	info	Пользователь undefined успешно зашел в систему	05:51:25	None
4	info	Пользователь с именем evilyach вышел из системы	05:51:51	evilyach
5	info	Пользователь undefined успешно зашел в систему	05:52:07	None
6	info	Пользователь undefined успешно зашел в систему	05:52:11	None
7	info	Пользователь с именем user вышел из системы	05:54:28	user
8	info	Пользователь undefined зарегистрирован в системе	05:54:47	None
9	info	Пользователь undefined успешно зашел в систему	05:55:03	chesalin
10	info	Пользователь с именем chesalin вышел из системы	05:55:18	chesalin
11	info	Пользователь undefined успешно зашел в систему	05:55:28	chesalin
12	info	Пользователь с именем chesalin вышел из системы	05:55:43	chesalin
13	info	Пользователь undefined зарегистрирован в системе	05:56:11	None
14	info	Пользователь undefined зарегистрирован в системе	05:56:51	None
15	info	Пользователь undefined зарегистрирован в системе	05:57:08	None
16	info	Пользователь undefined успешно зашел в систему	05:57:33	chesalin
17	info	Пользователь с именем chesalin вышел из системы	05:57:42	chesalin
18	info	Пользователь undefined успешно зашел в систему	05:57:48	None
19	info	Пользователь undefined успешно зашел в систему	05:58:40	None
20	warning	Была произведена неудачная попытка входа с использованием имени пользователя undefined	05:58:40	None
21	info	Пользователь undefined успешно зашел в систему	05:59:23	None
22	warning	Была произведена неудачная попытка входа с использованием имени пользователя undefined	05:59:23	None
23	info	Пользователь undefined успешно зашел в систему	06:00:47	None
24	warning	Была произведена неудачная попытка входа с использованием имени пользователя undefined	06:00:47	None
25	info	Пользователь undefined успешно зашел в систему	06:02:00	user
26	info	Пользователь с именем user вышел из системы	06:02:06	user
27	info	Пользователь с именем priv вышел из системы	06:03:10	priv
28	info	Пользователь undefined успешно зашел в систему	06:03:16	priv
29	info	Пользователь с именем priv вышел из системы	06:03:23	priv
30	info	Пользователь undefined успешно зашел в систему	06:03:35	guest
31	info	Пользователь с именем guest вышел из системы	06:03:40	guest
32	info	Пользователь undefined успешно зашел в систему	06:04:23	chesalin
33	info	Пользователь с именем chesalin вышел из системы	06:19:37	chesalin
34	info	Пользователь undefined зарегистрирован в системе	06:40:32	None
35	info	Пользователь undefined успешно зашел в систему	06:40:52	chesalin
36	info	Добавлено устройство "Умный холодильник" с названием "Samsung Smart Fridge"	06:42:50	chesalin
37	info	Удалено устройство с названием "Холодядя 9000"	06:46:58	chesalin
38	info	Пользователь с именем chesalin вышел из системы	07:01:24	chesalin
39	info	Пользователь undefined успешно зашел в систему	07:01:38	user
40	info	Пользователь с именем user вышел из системы	07:01:55	user
41	info	Пользователь undefined успешно зашел в систему	07:02:01	user
42	info	Пользователь с именем user вышел из системы	07:02:13	user
43	info	Пользователь undefined успешно зашел в систему	07:02:25	priv
44	info	Пользователь с именем priv вышел из системы	07:02:49	priv
45	info	Пользователь с именем guest вышел из системы	07:04:56	guest
\.


--
-- Data for Name: profile; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.profile (id, user_account_id, name) FROM stdin;
\.


--
-- Data for Name: real_estate; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.real_estate (id, real_estate_type_id, area_id, name, address, description) FROM stdin;
1	2	1	Гостинная дома	г. Москва, ул. Пушкина, д. 25, кв. 314	Гостинная в доме на Пушкина
2	3	1	Кухня дома	г. Москва, ул. Пушкина, д. 25, кв. 314	Кухня в доме на Пушкина
3	4	1	Прихожая дома	г. Москва, ул. Пушкина, д. 25, кв. 314	Прихожая в доме на Пушкина
\.


--
-- Data for Name: real_estate_type; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.real_estate_type (id, name) FROM stdin;
2	Гостинная
3	Кухня
4	Прихожая
5	Ванная
6	Туалет
7	Спальное помещение
8	Офисное помещение
9	Гаражное помещение
10	Подъезд
11	Холл
\.


--
-- Data for Name: user_account; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_account (id, user_account_type_id, name, username, password, email) FROM stdin;
17	1	Чесалин Илья	chesalin	80598670a3b5ecf2107e54216ae09d0e81385b31	evilyach@protonmail.com
19	3	Зарегистрированный пользвоатель	user	80598670a3b5ecf2107e54216ae09d0e81385b31	user@user.ru
18	2	Привилегированный пользователь	priv	80598670a3b5ecf2107e54216ae09d0e81385b31	priv@priv.ru
20	4	Непривилегированный пользователь	guest	80598670a3b5ecf2107e54216ae09d0e81385b31	guest@user.ru
21	3	Новый Пользователь	NewUser	79af437c1eb682bf22b722aa773e86b81650503a	mail@newuser.com
\.


--
-- Data for Name: user_account_type; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_account_type (id, name, user_account_type_rights_id) FROM stdin;
1	Администратор ИС	1
2	Оператор ИС	2
3	Привилегированный пользователь	3
4	Непривилегированный пользователь	4
\.


--
-- Data for Name: user_account_type_rights; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_account_type_rights (id, read_data_right, write_data_right, read_raw_tables_right, read_users_right, write_users_right, read_log_right) FROM stdin;
1	t	t	t	t	t	t
3	t	t	f	f	f	f
4	t	f	f	f	f	f
2	t	t	t	t	f	f
\.


--
-- Name: area_id_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.area_id_id_seq', 4, true);


--
-- Name: command_by_device_command_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.command_by_device_command_id_seq', 1, false);


--
-- Name: command_by_device_device_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.command_by_device_device_id_seq', 1, false);


--
-- Name: command_command_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.command_command_type_id_seq', 1, false);


--
-- Name: command_device_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.command_device_id_seq', 1, false);


--
-- Name: command_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.command_id_seq', 1, false);


--
-- Name: command_profile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.command_profile_id_seq', 1, false);


--
-- Name: command_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.command_type_id_seq', 10, true);


--
-- Name: device_device_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.device_device_type_id_seq', 1, false);


--
-- Name: device_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.device_id_seq', 13, true);


--
-- Name: device_parameters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.device_parameters_id_seq', 43, true);


--
-- Name: device_real_estate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.device_real_estate_id_seq', 1, false);


--
-- Name: device_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.device_type_id_seq', 11, true);


--
-- Name: devices_by_user_account_device_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.devices_by_user_account_device_id_seq', 1, false);


--
-- Name: devices_by_user_account_user_account_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.devices_by_user_account_user_account_id_seq', 1, false);


--
-- Name: devices_in_profile_device_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.devices_in_profile_device_id_seq', 1, false);


--
-- Name: devices_in_profile_profile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.devices_in_profile_profile_id_seq', 1, false);


--
-- Name: log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.log_id_seq', 45, true);


--
-- Name: profile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.profile_id_seq', 1, false);


--
-- Name: profile_user_account_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.profile_user_account_id_seq', 1, false);


--
-- Name: real_estate_area_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.real_estate_area_id_seq', 1, false);


--
-- Name: real_estate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.real_estate_id_seq', 3, true);


--
-- Name: real_estate_real_estate_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.real_estate_real_estate_type_id_seq', 1, false);


--
-- Name: real_estate_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.real_estate_type_id_seq', 11, true);


--
-- Name: user_account_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.user_account_id_seq', 21, true);


--
-- Name: user_account_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.user_account_type_id_seq', 4, true);


--
-- Name: user_account_type_rights_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.user_account_type_rights_id_seq', 1, false);


--
-- Name: user_account_type_user_account_type_rights_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.user_account_type_user_account_type_rights_id_seq', 1, false);


--
-- Name: user_account_user_account_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.user_account_user_account_type_id_seq', 1, false);


--
-- Name: area area_id_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.area
    ADD CONSTRAINT area_id_pk PRIMARY KEY (id);


--
-- Name: command command_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.command
    ADD CONSTRAINT command_pk PRIMARY KEY (id);


--
-- Name: command_type command_type_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.command_type
    ADD CONSTRAINT command_type_pk PRIMARY KEY (id);


--
-- Name: device_parameters device_parameters_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.device_parameters
    ADD CONSTRAINT device_parameters_pk PRIMARY KEY (id);


--
-- Name: device_type device_type_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.device_type
    ADD CONSTRAINT device_type_pk PRIMARY KEY (id);


--
-- Name: log log_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.log
    ADD CONSTRAINT log_pk PRIMARY KEY (id);


--
-- Name: profile profile_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.profile
    ADD CONSTRAINT profile_pk PRIMARY KEY (id);


--
-- Name: real_estate real_estate_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.real_estate
    ADD CONSTRAINT real_estate_pk PRIMARY KEY (id);


--
-- Name: real_estate_type real_estate_type_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.real_estate_type
    ADD CONSTRAINT real_estate_type_pk PRIMARY KEY (id);


--
-- Name: user_account user_account_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_account
    ADD CONSTRAINT user_account_pk PRIMARY KEY (id);


--
-- Name: user_account_type user_account_type_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_account_type
    ADD CONSTRAINT user_account_type_pk PRIMARY KEY (id);


--
-- Name: user_account_type_rights user_account_type_rights_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_account_type_rights
    ADD CONSTRAINT user_account_type_rights_pk PRIMARY KEY (id);


--
-- Name: area_id_id_uindex; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX area_id_id_uindex ON public.area USING btree (id);


--
-- Name: area_id_name_uindex; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX area_id_name_uindex ON public.area USING btree (name);


--
-- Name: command_id_uindex; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX command_id_uindex ON public.command USING btree (id);


--
-- Name: command_type_id_uindex; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX command_type_id_uindex ON public.command_type USING btree (id);


--
-- Name: device_id_uindex; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX device_id_uindex ON public.device USING btree (id);


--
-- Name: device_name_uindex; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX device_name_uindex ON public.device USING btree (name);


--
-- Name: device_parameters_id_uindex; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX device_parameters_id_uindex ON public.device_parameters USING btree (id);


--
-- Name: device_type_id_uindex; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX device_type_id_uindex ON public.device_type USING btree (id);


--
-- Name: devices_by_user_account_user_account_id_uindex; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX devices_by_user_account_user_account_id_uindex ON public.devices_by_user_account USING btree (user_account_id);


--
-- Name: devices_in_profile_device_id_uindex; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX devices_in_profile_device_id_uindex ON public.devices_in_profile USING btree (device_id);


--
-- Name: devices_in_profile_profile_id_uindex; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX devices_in_profile_profile_id_uindex ON public.devices_in_profile USING btree (profile_id);


--
-- Name: log_id_uindex; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX log_id_uindex ON public.log USING btree (id);


--
-- Name: profile_id_uindex; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX profile_id_uindex ON public.profile USING btree (id);


--
-- Name: real_estate_id_uindex; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX real_estate_id_uindex ON public.real_estate USING btree (id);


--
-- Name: real_estate_type_id_uindex; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX real_estate_type_id_uindex ON public.real_estate_type USING btree (id);


--
-- Name: real_estate_type_name_uindex; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX real_estate_type_name_uindex ON public.real_estate_type USING btree (name);


--
-- Name: user_account_email_uindex; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX user_account_email_uindex ON public.user_account USING btree (email);


--
-- Name: user_account_id_uindex; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX user_account_id_uindex ON public.user_account USING btree (id);


--
-- Name: user_account_type_id_uindex; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX user_account_type_id_uindex ON public.user_account_type USING btree (id);


--
-- Name: user_account_type_rights_id_uindex; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX user_account_type_rights_id_uindex ON public.user_account_type_rights USING btree (id);


--
-- Name: user_account_username_uindex; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX user_account_username_uindex ON public.user_account USING btree (username);


--
-- Name: command_by_device command_by_device_command_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.command_by_device
    ADD CONSTRAINT command_by_device_command_fk FOREIGN KEY (command_id) REFERENCES public.command(id);


--
-- Name: command_by_device command_by_device_device_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.command_by_device
    ADD CONSTRAINT command_by_device_device_fk FOREIGN KEY (device_id) REFERENCES public.device(id);


--
-- Name: command command_command_type_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.command
    ADD CONSTRAINT command_command_type_fk FOREIGN KEY (command_type_id) REFERENCES public.command_type(id);


--
-- Name: command command_device_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.command
    ADD CONSTRAINT command_device_fk FOREIGN KEY (device_id) REFERENCES public.device(id);


--
-- Name: command command_profile_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.command
    ADD CONSTRAINT command_profile_fk FOREIGN KEY (profile_id) REFERENCES public.profile(id);


--
-- Name: device device_device_parameters_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.device
    ADD CONSTRAINT device_device_parameters_fk FOREIGN KEY (device_parameters_id) REFERENCES public.device_parameters(id);


--
-- Name: device device_device_type_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.device
    ADD CONSTRAINT device_device_type_fk FOREIGN KEY (device_type_id) REFERENCES public.device_type(id);


--
-- Name: device device_real_estate_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.device
    ADD CONSTRAINT device_real_estate_fk FOREIGN KEY (real_estate_id) REFERENCES public.real_estate(id);


--
-- Name: devices_by_user_account devices_by_user_account_device_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.devices_by_user_account
    ADD CONSTRAINT devices_by_user_account_device_fk FOREIGN KEY (device_id) REFERENCES public.device(id);


--
-- Name: devices_by_user_account devices_by_user_account_user_account_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.devices_by_user_account
    ADD CONSTRAINT devices_by_user_account_user_account_fk FOREIGN KEY (user_account_id) REFERENCES public.user_account(id);


--
-- Name: devices_in_profile devices_in_profile_device_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.devices_in_profile
    ADD CONSTRAINT devices_in_profile_device_fk FOREIGN KEY (device_id) REFERENCES public.device(id);


--
-- Name: devices_in_profile devices_in_profile_profile_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.devices_in_profile
    ADD CONSTRAINT devices_in_profile_profile_fk FOREIGN KEY (profile_id) REFERENCES public.profile(id);


--
-- Name: profile profile_user_account_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.profile
    ADD CONSTRAINT profile_user_account_fk FOREIGN KEY (user_account_id) REFERENCES public.user_account(id);


--
-- Name: real_estate real_estate_area_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.real_estate
    ADD CONSTRAINT real_estate_area_fk FOREIGN KEY (area_id) REFERENCES public.area(id);


--
-- Name: real_estate real_estate_real_estate_type_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.real_estate
    ADD CONSTRAINT real_estate_real_estate_type_fk FOREIGN KEY (real_estate_type_id) REFERENCES public.real_estate_type(id);


--
-- Name: user_account_type user_account_type_user_account_type_rights_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_account_type
    ADD CONSTRAINT user_account_type_user_account_type_rights_fk FOREIGN KEY (user_account_type_rights_id) REFERENCES public.user_account_type_rights(id);


--
-- Name: user_account user_account_user_account_type_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_account
    ADD CONSTRAINT user_account_user_account_type_fk FOREIGN KEY (user_account_type_id) REFERENCES public.user_account_type(id);


--
-- PostgreSQL database dump complete
--

