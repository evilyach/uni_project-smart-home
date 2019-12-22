<template>
  <div class="q-pa-sm">
    <q-table
      title="Управление"
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
          name: "command_id",
          align: "center",
          label: "ID команды",
          field: row => row.command_id,
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
        }
      ],
      data: [],
      getData() {
        axios.get("http://localhost:13491/api/raw/command_by_device")
          .then(res => {
            const data = res['data'][0];

            data.forEach(element => {
              const command_id = element[0][0];
              const device_id = element[0][1];

              this.data.push({
                "command_id": command_id,
                "device_id": device_id
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