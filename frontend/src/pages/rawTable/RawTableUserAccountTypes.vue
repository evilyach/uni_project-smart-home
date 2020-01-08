<template>
  <div class="q-pa-sm">
    <q-table title="Типы учетных записей" :data="data" :columns="columns">
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
          name: "name",
          align: "center",
          label: "Имя",
          field: row => row.name,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "user_account_rights_id",
          align: "center",
          label: "ID прав учетной записи",
          field: row => row.user_account_rights_id,
          format: val => `${val}`,
          sortable: true
        }
      ],
      data: [],
      getData() {
        axios
          .get(router.table("user_account_type"))
          .then(res => {
            const data = res["data"];

            data.forEach(element => {
              const id = element[0][0];
              const name = element[0][1];
              const user_account_rights_id = element[0][2];

              this.data.push({
                id: id,
                name: name,
                user_account_rights_id: user_account_rights_id
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
