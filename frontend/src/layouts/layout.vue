<template>
  <q-layout view="lHh Lpr lFf">
    <q-header elevated>
      <q-toolbar>
        <q-btn
          flat
          dense
          round
          @click="leftDrawerOpen = !leftDrawerOpen"
          icon="home"
          aria-label="Menu"
        />

        <q-toolbar-title>
          Умный дом
        </q-toolbar-title>
      </q-toolbar>
    </q-header>

    <q-drawer v-model="leftDrawerOpen" show-if-above bordered>
      <q-list>
        <q-item-label header>Возможности</q-item-label>

        <q-item clickable tag="a" href="/addnew">
          <q-item-section avatar>
            <q-icon name="add" />
          </q-item-section>
          <q-item-section>
            <q-item-label>Добавить устройство</q-item-label>
            <q-item-label caption>Добавить новое устройство</q-item-label>
          </q-item-section>
        </q-item>

        <q-item clickable tag="a" href="/list">
          <q-item-section avatar>
            <q-icon name="list" />
          </q-item-section>
          <q-item-section>
            <q-item-label>Вывести устройства</q-item-label>
            <q-item-label caption>Вывести список всех устройств</q-item-label>
          </q-item-section>
        </q-item>

        <q-item clickable tag="a" href="/triggers">
          <q-item-section avatar>
            <q-icon name="settings_input_component" />
          </q-item-section>
          <q-item-section>
            <q-item-label>Триггеры</q-item-label>
            <q-item-label caption>Настроить триггеры</q-item-label>
          </q-item-section>
        </q-item>

        <q-item clickable tag="a" href="/automation">
          <q-item-section avatar>
            <q-icon name="cached" />
          </q-item-section>
          <q-item-section>
            <q-item-label>Автоматизация</q-item-label>
            <q-item-label caption>
              Настроить автоматические действия
            </q-item-label>
          </q-item-section>
        </q-item>

        <!---->

        <q-item-label header>Устройства</q-item-label>

        <!---->

        <q-item-label header>Сырой вывод</q-item-label>

        <q-item clickable tag="a" href="/rawAreas">
          <q-item-section avatar>
            <q-icon name="view_list" />
          </q-item-section>
          <q-item-section>
            <q-item-label>Пространства</q-item-label>
            <q-item-label caption>Таблица "Пространства"</q-item-label>
          </q-item-section>
        </q-item>

        <q-item clickable tag="a" href="/rawDeviceTypes">
          <q-item-section avatar>
            <q-icon name="view_list" />
          </q-item-section>
          <q-item-section>
            <q-item-label>Типы устройств</q-item-label>
            <q-item-label caption>Таблица "Типы устройств"</q-item-label>
          </q-item-section>
        </q-item>

        <q-item clickable tag="a" href="/rawDevices">
          <q-item-section avatar>
            <q-icon name="view_list" />
          </q-item-section>
          <q-item-section>
            <q-item-label>Устройства</q-item-label>
            <q-item-label caption>Таблица "Устройства"</q-item-label>
          </q-item-section>
        </q-item>

        <q-item clickable tag="a" href="/rawProfiles">
          <q-item-section avatar>
            <q-icon name="view_list" />
          </q-item-section>
          <q-item-section>
            <q-item-label>Профили</q-item-label>
            <q-item-label caption>Таблица "Профили"</q-item-label>
          </q-item-section>
        </q-item>

        <q-item clickable tag="a" href="/rawRealEstateTypes">
          <q-item-section avatar>
            <q-icon name="view_list" />
          </q-item-section>
          <q-item-section>
            <q-item-label>Типы недвижимости</q-item-label>
            <q-item-label caption>Таблица "Типы недвижимости"</q-item-label>
          </q-item-section>
        </q-item>

        <q-item clickable tag="a" href="/rawRealEstates">
          <q-item-section avatar>
            <q-icon name="view_list" />
          </q-item-section>
          <q-item-section>
            <q-item-label>Недвижимость</q-item-label>
            <q-item-label caption>Таблица "Недвижимость"</q-item-label>
          </q-item-section>
        </q-item>

        <q-item clickable tag="a" href="/rawUsers">
          <q-item-section avatar>
            <q-icon name="view_list" />
          </q-item-section>
          <q-item-section>
            <q-item-label>Пользователи</q-item-label>
            <q-item-label caption>Таблица "Пользователи"</q-item-label>
          </q-item-section>
        </q-item>

        <!---->

        <q-item-label header>Настройки</q-item-label>

        <q-item clickable tag="a" href="/about">
          <q-item-section avatar>
            <q-icon name="info" />
          </q-item-section>
          <q-item-section>
            <q-item-label>Справка</q-item-label>
            <q-item-label caption>Информация о проекте</q-item-label>
          </q-item-section>
        </q-item>
      </q-list>
    </q-drawer>

    <q-page-container>
      <router-view />
    </q-page-container>
  </q-layout>
</template>

<script>
export default {
  name: "Layout",

  data() {
    return {
      leftDrawerOpen: false
    };
  }
};
</script>
