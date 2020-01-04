<template>
  <div class="q-pa-sm">
    <q-table title="Учетные записи" :data="data" :columns="columns">
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
import axios from "axios";

export default {
  data() {
    return {
      columns: [
        {
          name: "id",
          align: "center",
          label: "ID учетной записи",
          field: row => row.id,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "user_account_type_id",
          align: "center",
          label: "ID типа записи",
          field: row => row.user_account_type_id,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "name",
          align: "center",
          label: "Имя",
          field: row => row.name,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "username",
          align: "center",
          label: "Имя",
          field: row => row.username,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "password",
          align: "center",
          label: "Имя",
          field: row => row.password,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "email",
          align: "center",
          label: "Имя",
          field: row => row.email,
          format: val => `${val}`,
          sortable: true
        }
      ],
      data: [],
      getData() {
        axios
          .get("http://localhost:13491/api/raw/user_account")
          .then(res => {
            const data = res["data"][0];

            data.forEach(element => {
              const id = element[0][0];
              const user_account_type_id = element[0][1];
              const name = element[0][2];
              const username = element[0][3];
              const password = element[0][4];
              const email = element[0][5];

              this.data.push({
                id: id,
                user_account_type_id: user_account_type_id,
                name: name,
                username: username,
                password: password,
                email: email
              });
            });
          })
          .catch(e => {
            this.$q.notify({
              message: "Не удалось получить доступ к базе данных: " + e,
              color: "negative"
            });
          });
      }
    };
  },
  created() {
    this.getData();
  }
};
</script>

<style>
.my-table-details {
  font-size: 0.85em;
  font-style: italic;
  white-space: normal;
  color: #555;
  margin-top: 4px;
}
</style>
