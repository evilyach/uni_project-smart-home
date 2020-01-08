<template>
  <div class="q-pa-sm">
    <q-table title="Команды" :data="data" :columns="columns">
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
          label: "ID команды",
          field: row => row.id,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "command_type_id",
          align: "center",
          label: "ID типа команды",
          field: row => row.command_type_id,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "device_id",
          align: "center",
          label: "ID устройства",
          field: row => row.device_id,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "profile_id",
          align: "center",
          label: "ID профиля",
          field: row => row.profile_id,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "argvar",
          align: "center",
          label: "Аргументы",
          field: row => row.argvar,
          format: val => `${val}`,
          sortable: true
        }
      ],
      data: [],
      getData() {
        axios
          .get(router.table("command"))
          .then(res => {
            const data = res["data"];

            data.forEach(element => {
              const id = element[0][0];
              const command_type_id = element[0][1];
              const device_id = element[0][2];
              const profile_id = element[0][3];
              const argvar = element[0][4];

              this.data.push({
                id: id,
                command_type_id: command_type_id,
                device_id: device_id,
                profile_id: profile_id,
                argvar: argvar
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
