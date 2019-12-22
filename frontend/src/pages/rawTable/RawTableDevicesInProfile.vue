<template>
  <div class="q-pa-sm">
    <q-table
      title="Содержащиеся в профиле устройства"
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
        }
      ],
      data: [],
      getData() {
        axios.get("http://localhost:13491/api/raw/devices_in_profile")
          .then(res => {
            const data = res['data'][0];

            data.forEach(element => {
              const device_id = element[0][0];
              const profile_id = element[0][1];

              this.data.push({
                "device_id": device_id,
                "profile_id": profile_id
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