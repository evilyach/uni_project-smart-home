<template>
  <div class="gutter-sm" id="page">
    <div>
      <q-input
        v-model="user.username"
        type="text"
        label="Имя пользователя"
        :rules="[
          val =>
            /^[a-zA-Zа-яА-Я0-9\-_]+$/.test(val) ||
            'Введенное имя пользователя некорректно!'
        ]"
      />
    </div>

    <div style="height: 20px" />

    <div>
      <q-input
        v-model="user.password"
        :type="isPwd ? 'password' : 'text'"
        label="Пароль"
        :rules="[
          val =>
            /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z]{8,}$/.test(val) ||
            'Пароль не удовлетворяет политике безопасности паролей!'
        ]"
      >
        <template v-slot:append>
          <q-icon
            :name="isPwd ? 'visibility_off' : 'visibility'"
            class="cursor-pointer"
            @click="isPwd = !isPwd"
          />
        </template>
      </q-input>
    </div>

    <div style="height: 20px" />

    <div class="row justify-center">
      <q-btn class="full-width" label="Войти" @click="buttonClick" />
    </div>
  </div>
</template>

<script>
import axios from "axios";
import crypto from "crypto";

export default {
  data() {
    return {
      isPwd: true,
      user: {
        username: "",
        password: ""
      },
      pushData() {
        if (this.user.username === "" || this.user.password === "") {
          this.$q.notify({
            message: "Не все поля заполнены!",
            color: "negative"
          });

          return;
        }

        axios
          .post("http://localhost:13491/api/auth/login", {
            username: this.user.username,
            password: crypto
              .createHash("sha1")
              .update(this.user.password, "binary")
              .digest("hex")
          })
          .then(() => {
            this.$q.notify({
              message: "Вошли",
              color: "positive"
            });

            // TODO:
          })
          .catch(e => {
            this.$q.notify({
              message: "Не удалось войти: " + e,
              color: "negative"
            });
          });
      }
    };
  },
  methods: {
    buttonClick() {
      this.pushData();
    }
  }
};
</script>

<style>
#page {
  width: 600px;
  max-width: 90vw;
}
</style>
