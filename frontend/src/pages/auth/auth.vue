<template>
  <q-layout view="lhr lpr lfr">
    <q-page class="flex flex-center">
      <q-card>
        <q-tabs
          v-model="tab"
          class="text-grey"
          active-color="primary"
          indicator-color="primary"
          align="center"
        >
          <q-tab name="login" label="Войти" />
          <q-tab name="register" label="Регистрация" />
        </q-tabs>

        <q-separator />

        <q-tab-panels
          v-model="tab"
          animated
          transition-prev="jump-up"
          transition-next="jump-up"
        >
          <q-tab-panel name="login">
            <login />
          </q-tab-panel>

          <q-tab-panel name="register">
            <register />
          </q-tab-panel>
        </q-tab-panels>
      </q-card>
    </q-page>
  </q-layout>
</template>

<script>
import login from "../../components/auth/login";
import register from "../../components/auth/register";

export default {
  components: {
    login,
    register
  },
  data() {
    return {
      tab: "login"
    };
  }
};
</script>

<style lang="scss">
body {
  background-color: $primary;
}
</style>
