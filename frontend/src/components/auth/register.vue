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
        v-model="user.name"
        type="text"
        label="Ваше имя"
        :rules="[
          val =>
            /^[a-zA-Zа-яА-Я\- ]+$/.test(val) || 'Введенное имя некорректно!'
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

    <div>
      <q-input
        v-model="user.email"
        type="text"
        label="Адрес электронной почты"
        :rules="[
          val => /\S+@\S+\.\S+/.test(val) || 'Адрес электронной почты неверный!'
        ]"
      />
    </div>

    <div style="height: 20px" />

    <div class="row justify-center">
      <q-btn
        class="full-width"
        label="Зарегистрироваться"
        @click="buttonClick"
      />
    </div>
  </div>
</template>

<script>
import axios from "axios";
import crypto from "crypto";
import router from "../../router/routes-backend"

export default {
  data() {
    return {
      isPwd: true,
      user: {
        username: "",
        name: "",
        password: "",
        email: ""
      },
      pushData() {
        if (
          this.user.username === "" ||
          this.user.name === "" ||
          this.user.password === "" ||
          this.user.email === ""
        ) {
          this.$q.notify({
            message: "Не все поля заполнены!",
            color: "negative"
          });

          return;
        }

        axios
          .post(router.register(), {
            user_account_type_id: 3,
            username: this.user.username,
            name: this.user.name,
            password: crypto
              .createHash("sha1")
              .update(this.user.password, "binary")
              .digest("hex"),
            email: this.user.email
          })
          .then(() => {
            this.$q.notify({
              message: "Пользователь успешно зарегистрирован!",
              color: "positive"
            });
          })
          .catch(e => {
            this.$q.notify({
              message: "Не удалось зарегистрироваться! " + e,
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
