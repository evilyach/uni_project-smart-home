<template>
  <div class="gutter-sm" id="page">
    <img
      id="profile-img"
      src="//ssl.gstatic.com/accounts/ui/avatar_2x.png"
      class="profile-img-card"
    />

    <div style="height: 20px" />

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
import User from "../../models/user";
import { addLogRecord } from "../../lib/log";

export default {
  name: "register",

  computed: {
    loggedIn() {
      return this.$store.state.auth.status.loggedIn;
    }
  },

  data() {
    return {
      isPwd: true,
      user: new User("", "", "", ""),
      submitted: false,
      successful: false,
      message: ""
    };
  },
  methods: {
    buttonClick() {
      if (
        this.user.username === "" ||
        this.user.name === "" ||
        this.user.password === "" ||
        this.user.email === ""
      ) {
        this.$q.notify({
          message: "Введите данные!",
          color: "warning"
        });
        return;
      }

      this.message = "";
      this.submitted = true;

      this.$store.dispatch("register", this.user).then(
        data => {
          this.message = data.message;
          this.successful = true;

          addLogRecord({
            log_level: "info",
            message: `Пользователь ${this.username} зарегистрирован в системе`
          });

          this.$q.notify({
            message: "Пользователь успешно зарегистрирован!",
            color: "positive"
          });
        },
        error => {
          this.message = error.message;
          this.successful = false;

          addLogRecord({
            log_level: "warning",
            message: `Была произведена неудачная попытка регистрации с использованием имени пользователя ${this.username}`
          });

          this.$q.notify({
            message: `Не удалось зарегистрировать пользователя: ${this.message}`,
            color: "negative"
          });
        }
      );
    }
  }
};
</script>

<style>
#page {
  width: 600px;
  max-width: 90vw;
}

.profile-img-card {
  width: 96px;
  height: 96px;
  margin: 0 auto 10px;
  display: block;
  -moz-border-radius: 50%;
  -webkit-border-radius: 50%;
  border-radius: 50%;
}
</style>
