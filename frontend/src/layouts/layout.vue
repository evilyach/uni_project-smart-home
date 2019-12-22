<template>
  <q-layout view="hHh LpR ffr">
    <q-header elevated class="bg-primary">
      <q-toolbar>
        <q-btn
          flat
          dense
          round
          @click="leftDrawerOpen = !leftDrawerOpen"
          icon="menu"
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

        <q-item clickable to="/addNew">
          <q-item-section avatar>
            <q-icon name="add" />
          </q-item-section>
          <q-item-section>
            <q-item-label>Добавить устройство</q-item-label>
            <q-item-label caption>Добавить новое устройство</q-item-label>
          </q-item-section>
        </q-item>

        <q-item clickable to="/list">
          <q-item-section avatar>
            <q-icon name="list" />
          </q-item-section>
          <q-item-section>
            <q-item-label>Вывести устройства</q-item-label>
            <q-item-label caption>Вывести список всех устройств</q-item-label>
          </q-item-section>
        </q-item>

        <!---->

        <q-item-label header>Устройства</q-item-label>

        <!---->

        <q-item-label header>Сырой вывод</q-item-label>

        <q-item clickable to="/rawAreas">
          <q-item-section avatar>
            <q-icon name="map" />
          </q-item-section>
          <q-item-section>
            <q-item-label>Пространства</q-item-label>
            <q-item-label caption>Таблица "Пространства"</q-item-label>
          </q-item-section>
        </q-item>

        <q-item clickable to="/rawCommands">
          <q-item-section avatar>
            <q-icon name="contactless" />
          </q-item-section>
          <q-item-section>
            <q-item-label>Команды</q-item-label>
            <q-item-label caption>Таблица "Команды"</q-item-label>
          </q-item-section>
        </q-item>

        <q-item clickable to="/rawCommandsByDevice">
          <q-item-section avatar>
            <q-icon name="device_hub" />
          </q-item-section>
          <q-item-section>
            <q-item-label>Управление</q-item-label>
            <q-item-label caption>Таблица "Управление"</q-item-label>
          </q-item-section>
        </q-item>

        <q-item clickable to="/rawCommandTypes">
          <q-item-section avatar>
            <q-icon name="contactless" />
          </q-item-section>
          <q-item-section>
            <q-item-label>Типы команд</q-item-label>
            <q-item-label caption>Таблица "Типы команд"</q-item-label>
          </q-item-section>
        </q-item>

        <q-item clickable to="/rawDevices">
          <q-item-section avatar>
            <q-icon name="devices_other" />
          </q-item-section>
          <q-item-section>
            <q-item-label>Устройства</q-item-label>
            <q-item-label caption>Таблица "Устройства"</q-item-label>
          </q-item-section>
        </q-item>

        <q-item clickable to="/rawDeviceParameters">
          <q-item-section avatar>
            <q-icon name="perm_device_information" />
          </q-item-section>
          <q-item-section>
            <q-item-label>Параметры устройств</q-item-label>
            <q-item-label caption>Таблица "Параметры устройств"</q-item-label>
          </q-item-section>
        </q-item>

        <q-item clickable to="/rawDeviceTypes">
          <q-item-section avatar>
            <q-icon name="devices_other" />
          </q-item-section>
          <q-item-section>
            <q-item-label>Типы устройств</q-item-label>
            <q-item-label caption>Таблица "Типы устройств"</q-item-label>
          </q-item-section>
        </q-item>

        <q-item clickable to="/rawDevicesByUserAccount">
          <q-item-section avatar>
            <q-icon name="device_hub" />
          </q-item-section>
          <q-item-section>
            <q-item-label>Контролируемые учетной записью устройства</q-item-label>
            <q-item-label caption>Таблица "Контролируемые учетной записью устройства"</q-item-label>
          </q-item-section>
        </q-item>

        <q-item clickable to="/rawDevicesInProfile">
          <q-item-section avatar>
            <q-icon name="device_hub" />
          </q-item-section>
          <q-item-section>
            <q-item-label>Содержащиеся в профиле устройства</q-item-label>
            <q-item-label caption>Таблица "Содержащиеся в профиле устройства"</q-item-label>
          </q-item-section>
        </q-item>

        <q-item clickable to="/rawProfiles">
          <q-item-section avatar>
            <q-icon name="person_outline" />
          </q-item-section>
          <q-item-section>
            <q-item-label>Профили</q-item-label>
            <q-item-label caption>Таблица "Профили"</q-item-label>
          </q-item-section>
        </q-item>

        <q-item clickable to="/rawRealEstates">
          <q-item-section avatar>
            <q-icon name="king_bed" />
          </q-item-section>
          <q-item-section>
            <q-item-label>Недвижимость</q-item-label>
            <q-item-label caption>Таблица "Недвижимость"</q-item-label>
          </q-item-section>
        </q-item>

        <q-item clickable to="/rawRealEstateTypes">
          <q-item-section avatar>
            <q-icon name="location_city" />
          </q-item-section>
          <q-item-section>
            <q-item-label>Типы недвижимости</q-item-label>
            <q-item-label caption>Таблица "Типы недвижимости"</q-item-label>
          </q-item-section>
        </q-item>

        <q-item clickable to="/rawUserAccounts">
          <q-item-section avatar>
            <q-icon name="people" />
          </q-item-section>
          <q-item-section>
            <q-item-label>Пользователи</q-item-label>
            <q-item-label caption>Таблица "Пользователи"</q-item-label>
          </q-item-section>
        </q-item>

        <q-item clickable to="/rawUserAccountTypes">
          <q-item-section avatar>
            <q-icon name="group" />
          </q-item-section>
          <q-item-section>
            <q-item-label>Типы пользователей</q-item-label>
            <q-item-label caption>Таблица "Типы пользователей"</q-item-label>
          </q-item-section>
        </q-item>

        <q-item clickable to="/rawUserAccountRights">
          <q-item-section avatar>
            <q-icon name="border_clear" />
          </q-item-section>
          <q-item-section>
            <q-item-label>Права пользователей</q-item-label>
            <q-item-label caption>Таблица "Права пользователей"</q-item-label>
          </q-item-section>
        </q-item>

        <!---->

        <q-item-label header>Настройки</q-item-label>

        <q-item clickable to="/log">
          <q-item-section avatar>
            <q-icon name="history" />
          </q-item-section>
          <q-item-section>
            <q-item-label>Журнал</q-item-label>
            <q-item-label caption>Журнал событий информационной системы</q-item-label>
          </q-item-section>
        </q-item>

        <q-item clickable to="/about">
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
