create view get_users(username) as
SELECT
    user_account.username
FROM
    user_account;

alter table
    get_users owner to postgres;