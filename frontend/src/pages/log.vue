<template>
  <div class="q-pa-sm">
    <q-table title="Журнал событий" :data="data" :columns="columns">
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
import router from "../router/routes-backend";

export default {
  data() {
    return {
      columns: [
        {
          name: "id",
          align: "center",
          label: "ID",
          field: row => row.id,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "log_level",
          align: "center",
          label: "Уровень опасности",
          field: row => row.log_level,
          format: val => `${val}`
        },
        {
          name: "message",
          align: "center",
          label: "Сообщение",
          field: row => row.message,
          format: val => `${val}`
        },
        {
          name: "time",
          align: "center",
          label: "Время",
          field: row => row.time,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "author",
          align: "center",
          label: "Автор",
          field: row => row.author,
          format: val => `${val}`,
          sortable: true
        }
      ],
      data: [],
      getData() {
        axios
          .get(router.getLogs())
          .then(res => {
            const data = res["data"];
            console.log(data);

            data.forEach(element => {
              const id = element[0];
              const log_level = element[1];
              const message = element[2];
              const time = element[3];
              const author = element[4];

              this.data.push({
                id: id,
                log_level: log_level,
                message: message,
                time: time,
                author: author
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
