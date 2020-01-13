create view get_passwords(password) as
SELECT
  user_account.password
FROM
  user_account;

alter table
  get_passwords owner to postgres;