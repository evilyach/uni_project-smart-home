<template>
  <div class="q-pa-md q-gutter-sm" id="banner">
    <q-banner class="bg-secondary text-white">
      <p id="text">
        Здравствуйте,
        <strong>{{ getCurrentUser }}</strong
        >!
      </p>
    </q-banner>

    <q-banner class="bg-primary text-white">
      <img
        id="profile-img"
        src="//ssl.gstatic.com/accounts/ui/avatar_2x.png"
        class="profile-img-card"
      />

      <p id="text">
        Вы вошли как:
        <strong>{{ getCurrentUsername }}</strong>
      </p>
    </q-banner>

    <q-banner class="bg-grey-3">
      <p id="text">
        Ваш токен доступа:
        <strong>{{ getCurrentToken }}</strong>
      </p>
    </q-banner>
  </div>
</template>

<script>
export default {
  name: "profile",

  computed: {
    getCurrentUsername() {
      return localStorage.getItem("username");
    },

    getCurrentToken() {
      return localStorage.getItem("token");
    },

    getCurrentUser() {
      return localStorage.getItem("name");
    }
  }
};
</script>

<style>
#banner {
  width: 70%;
  margin: 0 auto;
}

#text {
  overflow: hidden;
  text-align: center;
  max-width: 90vw;
  text-overflow: ellipsis;
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
