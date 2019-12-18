create table if not exists user_account_type_rights
(
    id                    serial not null,
    read_data_right       boolean,
    write_data_right      boolean,
    read_raw_tables_right boolean,
    read_users_right      boolean,
    write_users_right     boolean,
    read_log_right        boolean,
    constraint user_account_type_rights_pk
        primary key (id)
);

comment on table user_account_type_rights is 'Права типа учетной записи';

create unique index if not exists user_account_type_rights_id_uindex
    on user_account_type_rights (id);

create table if not exists user_account_type
(
    id                          serial  not null,
    name                        varchar not null,
    user_account_type_rights_id serial  not null,
    constraint user_account_type_pk
        primary key (id),
    constraint user_account_type_user_account_type_rights_fk
        foreign key (user_account_type_rights_id) references user_account_type_rights
);

comment on table user_account_type is 'Тип учетной записи';

create unique index if not exists user_account_type_id_uindex
    on user_account_type (id);

create table if not exists user_account
(
    id                   serial  not null,
    user_account_type_id serial  not null,
    name                 varchar,
    username             integer not null,
    password             varchar not null,
    email                integer not null,
    constraint user_account_pk
        primary key (id),
    constraint user_account_user_account_type_fk
        foreign key (user_account_type_id) references user_account_type
);

comment on table user_account is 'Учетная запись';

create unique index if not exists user_account_email_uindex
    on user_account (email);

create unique index if not exists user_account_id_uindex
    on user_account (id);

create unique index if not exists user_account_username_uindex
    on user_account (username);

create table if not exists profile
(
    id              serial not null,
    user_account_id serial not null,
    name            integer,
    constraint profile_pk
        primary key (id),
    constraint profile_user_account_fk
        foreign key (user_account_id) references user_account
);

comment on table profile is 'Профиль';

create unique index if not exists profile_id_uindex
    on profile (id);

create table if not exists device_type
(
    id          serial  not null,
    name        varchar not null,
    description text,
    constraint device_type_pk
        primary key (id)
);

comment on table device_type is 'Тип устройства';

create unique index if not exists device_type_id_uindex
    on device_type (id);

create table if not exists device_parameters
(
    id          serial not null,
    ip          varchar,
    to_alarm    boolean,
    temperature integer,
    humidity    integer,
    speed       integer,
    color       bigint,
    max_value   bigint,
    power       integer,
    password    varchar,
    constraint device_parameters_pk
        primary key (id)
);

comment on table device_parameters is 'Параметры устройства';

create unique index if not exists device_parameters_id_uindex
    on device_parameters (id);

create table if not exists real_estate_type
(
    id   serial  not null,
    name varchar not null,
    constraint real_estate_type_pk
        primary key (id)
);

comment on table real_estate_type is 'Тип помещения';

create unique index if not exists real_estate_type_id_uindex
    on real_estate_type (id);

create unique index if not exists real_estate_type_name_uindex
    on real_estate_type (name);

create table if not exists area
(
    id   serial  not null,
    name varchar not null,
    constraint area_id_pk
        primary key (id)
);

comment on table area is 'Тип пространства';

create unique index if not exists area_id_id_uindex
    on area (id);

create unique index if not exists area_id_name_uindex
    on area (name);

create table if not exists command_type
(
    id     serial  not null,
    name   varchar not null,
    argvar varchar,
    constraint command_type_pk
        primary key (id)
);

comment on table command_type is 'Тип команды';

create unique index if not exists command_type_id_uindex
    on command_type (id);

create table if not exists real_estate
(
    id                  serial  not null,
    real_estate_type_id serial  not null,
    area_id             serial  not null,
    name                varchar not null,
    address             varchar not null,
    description         text,
    constraint real_estate_pk
        primary key (id),
    constraint real_estate_real_estate_type_fk
        foreign key (real_estate_type_id) references real_estate_type,
    constraint real_estate_area_fk
        foreign key (area_id) references area
);

create unique index if not exists real_estate_id_uindex
    on real_estate (id);

create table if not exists device
(
    id                   serial   not null,
    device_type_id       serial   not null,
    real_estate_id       serial   not null,
    status               smallint not null,
    time_activated       time,
    time_deactivated     time,
    device_parameters_id serial   not null,
    constraint device_device_type_fk
        foreign key (device_type_id) references device_type,
    constraint device_real_estate_fk
        foreign key (real_estate_id) references real_estate,
    constraint device_device_parameters_fk
        foreign key (device_parameters_id) references device_parameters
);

comment on table device is 'Устройства';

create unique index if not exists device_id_uindex
    on device (id);

create table if not exists command
(
    id              serial  not null,
    command_type_id serial  not null,
    device_id       serial  not null,
    profile_id      serial  not null,
    argvar          varchar not null,
    constraint command_pk
        primary key (id),
    constraint command_command_type_fk
        foreign key (command_type_id) references command_type,
    constraint command_device_fk
        foreign key (device_id) references device (id),
    constraint command_profile_fk
        foreign key (profile_id) references profile
);

comment on table command is 'Команда';

create unique index if not exists command_id_uindex
    on command (id);

create table if not exists devices_in_profile
(
    profile_id serial not null,
    device_id  serial not null,
    constraint devices_in_profile_profile_fk
        foreign key (profile_id) references profile,
    constraint devices_in_profile_device_fk
        foreign key (device_id) references device (id)
);

comment on table devices_in_profile is 'Содержащиеся в профиле устройства';

create unique index if not exists devices_in_profile_device_id_uindex
    on devices_in_profile (device_id);

create unique index if not exists devices_in_profile_profile_id_uindex
    on devices_in_profile (profile_id);

create table if not exists devices_by_user_account
(
    user_account_id serial not null,
    device_id       serial not null,
    constraint devices_by_user_account_user_account_fk
        foreign key (user_account_id) references user_account,
    constraint devices_by_user_account_device_fk
        foreign key (device_id) references device (id)
);

comment on table devices_by_user_account is 'Контролируемые учетной записью устройства';

create unique index if not exists devices_by_user_account_user_account_id_uindex
    on devices_by_user_account (user_account_id);

create table if not exists command_by_device
(
    command_id serial not null,
    device_id  serial not null,
    constraint command_by_device_command_fk
        foreign key (command_id) references command,
    constraint command_by_device_device_fk
        foreign key (device_id) references device (id)
);

comment on table command_by_device is 'Управление';
