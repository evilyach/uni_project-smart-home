<template>
  <div class="q-pa-sm">
    <q-table title="Аккаунты пользователей" :data="data" :columns="columns" row-key="name">
      <template v-slot:body-cell-name="props">
        <q-td :props="props">
          <div>
            <q-badge color="$primary" :label="props.value" />
          </div>
          <div class="my-table-details">
            {{ props.row.details }}
          </div>
        </q-td>
      </template>
    </q-table>
  </div>
</template>

<script>
export default {
  data() {
    return {
      columns: [
        {
          name: "name",
          required: true,
          label: "Название столбца",
          align: "center",
          field: row => row.name,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "user_account_id",
          align: "center",
          label: "Идентификатор аккаунта пользователя",
          field: row => row.user_account_id,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "user_account_name",
          align: "center",
          label: "Имя пользователя",
          field: row => row.user_account_name,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "user_account_username",
          align: "center",
          label: "Логин пользователя",
          field: row => row.user_account_username,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "user_account_password",
          align: "center",
          label: "Пароль пользователя",
          field: row => row.user_account_password,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "user_account_email",
          align: "center",
          label: "Адрес электронной почты пользователя",
          field: row => row.user_account_email,
          format: val => `${val}`,
          sortable: true
        }
      ],
      data: [
        {
          name: "evilyach",
          user_account_id: "1",
          user_account_name: "Чесалин Илья",
          user_account_username: "evilyach",
          user_account_password: "mypasswordhash",
          user_account_email: "evilyach@protonmail.com"
        },
        {
          name: "other_user",
          user_account_id: "2",
          user_account_name: "Другой Пользователь",
          user_account_username: "other_user",
          user_account_password: "otherpasswordhash",
          user_account_email: "other_user@mail.provider"
        },
      ]
    }
  }
}
</script>

<style>
.my-table-details {
  font-size: 0.85em;
  font-style: italic;
  max-width: 300px;
  white-space: normal;
  color: #555;
  margin-top: 4px;
}
</style>