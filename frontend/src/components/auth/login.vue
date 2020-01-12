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
import User from "../../models/user";

export default {
  name: "login",

  computed: {
    loggedIn() {
      return this.$store.state.auth.status.loggedIn;
    }
  },

  data() {
    return {
      isPwd: true,
      user: new User("", "", "", "")
    };
  },

  mounted() {
    if (this.loggedIn) {
      this.$router.push("/");
    }
  },

  methods: {
    buttonClick() {
      this.loading = true;

      if (this.user.username && this.user.password) {
        this.$store.dispatch("login", this.user).then(
          () => {
            this.$q.notify({
              message: "Вы успешно вошли в систему!",
              color: "positive"
            });

            this.$router.push("/");
            window.location.reload();
          },
          () => {
            this.$q.notify({
              message: "Не удалось войти. Введите правильные данные!",
              color: "negative"
            });

            this.loading = false;
          }
        );
      } else {
        this.$q.notify({
          message: "Введите данные!",
          color: "warning"
        });
      }
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
