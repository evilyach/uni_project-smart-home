<template>
  <div class="q-pa-sm">
    <q-table
      title="Команды"
      :data="data"
      :columns="columns"
    >
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
          label: "ID устройства",
          field: row => row.id,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "device_type_id",
          align: "center",
          label: "ID типа устройства",
          field: row => row.device_type_id,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "real_estate_id",
          align: "center",
          label: "ID помещения",
          field: row => row.real_estate_id,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "status",
          align: "center",
          label: "Статус",
          field: row => row.status,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "time_activated",
          align: "center",
          label: "Время активации",
          field: row => row.time_activated,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "time_deactivated",
          align: "center",
          label: "Время деактивации",
          field: row => row.time_deactivated,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "device_parameters_id",
          align: "center",
          label: "ID параметров",
          field: row => row.device_parameters_id,
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
      ],
      data: [],
      getData() {
        axios.get("http://localhost:13491/api/raw/device")
          .then(res => {
            const data = res['data'][0];

            data.forEach(element => {
              const id = element[0][0];
              const device_type_id = element[0][1];
              const real_estate_id = element[0][2];
              const status = element[0][3];
              const time_activated = element[0][4];
              const time_deactivated = element[0][5];
              const device_parameters_id = element[0][6];
              const name = element[0][7];

              this.data.push({
                "id": id,
                "device_type_id": device_type_id,
                "real_estate_id": real_estate_id,
                "status": status,
                "time_activated": time_activated,
                "time_deactivated": time_deactivated,
                "device_parameters_id": device_parameters_id,
                "name": name
              });
            });
          })
          .catch(e => {
            this.$q.notify({
              message: "Не удалось получить доступ к базе данных: " + e,
              color: "negative"
            });
          });
      },
    }
  },
  created() {
    this.getData();
  },
}
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