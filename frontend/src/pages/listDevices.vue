<template>
  <div class="q-pa-md">
    <q-table
      grid
      card-class="bg-primary text-black"
      title="Устройства"
      :data="data"
      :columns="columns"
      row-key="name"
      :filter="filter"
    >
      <template v-slot:top-right>
        <q-input
          borderless
          dense
          debounce="200"
          v-model="filter"
          placeholder="Поиск"
        >
          <template v-slot:append>
            <q-icon name="search" />
          </template>
        </q-input>
      </template>
    </q-table>
  </div>
</template>

<script>
import axios from "axios";

export default {
  data() {
    return {
      filter: "",
      columns: [
        {
          name: "name",
          align: "left",
          label: "Имя",
          field: row => row.name,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "device_type_name",
          align: "left",
          label: "Тип устройства",
          field: row => row.device_type_name,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "real_estate_name",
          align: "left",
          label: "Помещение",
          field: row => row.real_estate_name,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "status",
          align: "left",
          label: "Статус",
          field: row => row.status,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "ip",
          align: "left",
          label: "IP-адрес",
          field: row => row.ip,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "to_alarm",
          align: "left",
          label: "Оповещение",
          field: row => row.to_alarm,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "temperature",
          align: "left",
          label: "Температура",
          field: row => row.temperature,
          format: val => `${val}`,
          required: false,
          sortable: true
        },
        {
          name: "humidity",
          align: "left",
          label: "Влажность",
          field: row => row.humidity,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "speed",
          align: "left",
          label: "Скорость",
          field: row => row.speed,
          format: val => `${val}`,
          visible: false,
          sortable: true
        }
      ],
      data: [],
      getData() {
        axios
          .get("http://localhost:13491/api/get/devices")
          .then(res => {
            const data = res["data"][0];

            data.forEach(element => {
              const name = element[0][0];
              const device_type_name = element[0][1];
              const real_estate_name = element[0][2];
              const status = element[0][3];
              const ip = element[0][4];
              const to_alarm = element[0][5];
              const temperature = element[0][6];
              const humidity = element[0][7];
              const speed = element[0][8];

              this.data.push({
                name: name,
                device_type_name: device_type_name,
                real_estate_name: real_estate_name,
                status: status ? "Включено" : "Выключено",
                ip: ip,
                to_alarm: to_alarm
                  ? "Оповещение включено"
                  : "Оповещение выключено",
                temperature: temperature ? temperature : "Недоступно",
                humidity: humidity ? humidity : "Недоступно",
                speed: speed ? speed : "Недоступно"
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
