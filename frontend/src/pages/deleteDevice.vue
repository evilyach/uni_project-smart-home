<template>
  <div class="q-pa-md q-gutter-sm" id="banner">
    <div class="text-h4" id="text">Удалить устройство</div>

    <div style="height: 20px" />

    <q-select
      v-model="list"
      filled
      label="Устройство"
      hint="Выберите устройство, которое вы хотите удалить"
      :options="options"
      style="width: 99%"
    />

    <div style="height: 20px" />

    <q-btn
      outline
      rounded
      color="primary"
      label="Добавить"
      @click="buttonClick"
    />
  </div>
</template>

<script>
import axios from "axios";
import router from "./../router/routes-backend";
import { addLogRecord } from "../lib/log";

export default {
  data() {
    return {
      options: [],
      names: [],
      list: null,

      getData() {
        axios
          .get(router.getDevices())
          .then(res => {
            const data = res["data"][0];

            data.forEach(element => {
              this.options.push(`${element[0][0]} (${element[0][2]})`);
              this.names.push(element[0][0]);
            });
          })
          .catch(e => {
            this.$q.notify({
              message: "Не удалось получить доступ к базе данных: " + e,
              color: "negative"
            });
          });
      },

      delete() {
        axios
          .post(router.deleteDevice(), {
            name: this.names[this.options.indexOf(this.list)]
          })
          .then(() => {
            this.$q.notify({
              message: "Устройство успешно удалено!",
              color: "positive"
            });

            addLogRecord({
              log_level: "info",
              message: `Удалено устройство с названием "${
                this.names[this.options.indexOf(this.list)]
              }"`
            });

            window.location.reload();
          })
          .catch(e => {
            this.$q.notify({
              message: "Не удалось получить доступ к базе данных: " + e,
              color: "negative"
            });

            addLogRecord({
              log_level: "warning",
              message: `Неудачная попытка удалить устройство с названием "${
                this.names[this.options.indexOf(this.list)]
              }"`
            });
          });
      }
    };
  },

  methods: {
    buttonClick() {
      this.delete();
    }
  },

  created() {
    this.getData();
  }
};
</script>

<style>
#text {
  overflow: hidden;
  text-align: center;
  max-width: 90vw;
  text-overflow: ellipsis;
}

#banner {
  width: 70%;
  margin: 0 auto;
}
</style>
