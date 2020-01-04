<template>
  <div class="q-pa-sm">
    <q-table title="Параметры устройств" :data="data" :columns="columns">
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
          label: "ID параметра",
          field: row => row.id,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "ip",
          align: "center",
          label: "IP-адрес",
          field: row => row.ip,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "to_alarm",
          align: "center",
          label: "Оповещать?",
          field: row => row.to_alarm,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "temperature",
          align: "center",
          label: "Температура",
          field: row => row.temperature,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "humidity",
          align: "center",
          label: "Влажность",
          field: row => row.humidity,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "speed",
          align: "center",
          label: "Скорость",
          field: row => row.speed,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "color",
          align: "center",
          label: "Цвет",
          field: row => row.color,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "max_value",
          align: "center",
          label: "Макс. значение",
          field: row => row.max_value,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "power",
          align: "center",
          label: "Мощность",
          field: row => row.power,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "password",
          align: "center",
          label: "Пароль",
          field: row => row.password,
          format: val => `${val}`,
          sortable: true
        }
      ],
      data: [],
      getData() {
        axios
          .get("http://localhost:13491/api/raw/device_parameters")
          .then(res => {
            const data = res["data"][0];

            data.forEach(element => {
              const id = element[0][0];
              const ip = element[0][1];
              const to_alarm = element[0][2];
              const temperature = element[0][3];
              const humidity = element[0][4];
              const speed = element[0][5];
              const color = element[0][6];
              const max_value = element[0][7];
              const power = element[0][8];
              const password = element[0][9];

              this.data.push({
                id: id,
                ip: ip,
                to_alarm: to_alarm,
                temperature: temperature,
                humidity: humidity,
                speed: speed,
                color: color,
                max_value: max_value,
                power: power,
                password: password
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
