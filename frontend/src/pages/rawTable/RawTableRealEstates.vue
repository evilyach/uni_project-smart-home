<template>
  <div class="q-pa-sm">
    <q-table
      title="Недвижимость"
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
          label: "ID недвижимости",
          field: row => row.id,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "real_estate_type_id",
          align: "center",
          label: "ID типа недвижимости",
          field: row => row.real_estate_type_id,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "area_id",
          align: "center",
          label: "ID типа пространства",
          field: row => row.area_id,
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
          name: "address",
          align: "center",
          label: "Адрес",
          field: row => row.address,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "description",
          align: "center",
          label: "Описание",
          field: row => row.description,
          format: val => `${val}`,
          sortable: true
        },
      ],
      data: [],
      getData() {
        axios.get("http://localhost:13491/api/raw/real_estate")
          .then(res => {
            const data = res['data'][0];

            data.forEach(element => {
              const id = element[0][0];
              const real_estate_type_id = element[0][1];
              const area_id = element[0][2];
              const name = element[0][3];
              const address = element[0][4];
              const description = element[0][5];

              this.data.push({
                "id": id,
                "real_estate_type_id": real_estate_type_id,
                "area_id": area_id,
                "name": name,
                "address": address,
                "description": description,
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