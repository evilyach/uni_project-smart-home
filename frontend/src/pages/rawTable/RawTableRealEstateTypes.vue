<template>
  <div class="q-pa-sm">
    <q-table title="Типы помещения" :data="data" :columns="columns">
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
          label: "ID типа помещения",
          field: row => row.id,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "name",
          align: "center",
          label: "Имя типа помещения",
          field: row => row.name,
          format: val => `${val}`,
          sortable: true
        }
      ],
      data: [],
      getData() {
        axios
          .get("http://localhost:13491/api/raw/real_estate_type")
          .then(res => {
            const data = res["data"];

            data.forEach(element => {
              const id = element[0][0];
              const name = element[0][1];

              this.data.push({
                id: id,
                name: name
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
