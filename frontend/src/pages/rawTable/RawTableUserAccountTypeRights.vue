<template>
  <div class="q-pa-sm">
    <q-table title="Права типа учетной записи" :data="data" :columns="columns">
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
import router from "../../router/routes-backend";

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
          name: "read_data_right",
          align: "center",
          label: "Чтение",
          field: row => row.read_data_right,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "write_data_right",
          align: "center",
          label: "Запись",
          field: row => row.write_data_right,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "read_raw_tables_right",
          align: "center",
          label: "Чтение таблиц",
          field: row => row.read_raw_tables_right,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "read_users_right",
          align: "center",
          label: "Чтение пользователей",
          field: row => row.read_users_right,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "write_users_right",
          align: "center",
          label: "Запись пользователей",
          field: row => row.write_users_right,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "read_log_right",
          align: "center",
          label: "Чтение журнала",
          field: row => row.read_log_right,
          format: val => `${val}`,
          sortable: true
        }
      ],
      data: [],
      getData() {
        axios
          .get(router.table("user_account_type_rights"))
          .then(res => {
            const data = res["data"];

            data.forEach(element => {
              const id = element[0][0];
              const read_data_right = element[0][1];
              const write_data_right = element[0][2];
              const read_raw_tables_right = element[0][3];
              const read_users_right = element[0][4];
              const write_users_right = element[0][5];
              const read_log_right = element[0][6];

              this.data.push({
                id: id,
                read_data_right: read_data_right,
                write_data_right: write_data_right,
                read_raw_tables_right: read_raw_tables_right,
                read_users_right: read_users_right,
                write_users_right: write_users_right,
                read_log_right: read_log_right
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
