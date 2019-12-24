<template>
  <q-page class="flex flex-center">
    <q-splitter
      style="width: 90%"
    >
      <template v-slot:before>
        <q-tabs
          v-model="tab"
          vertical
        >
          <q-tab name="fridge" icon="kitchen" label="Умный холодильник" />
          <q-tab name="washing-machine" icon="fas fa-tshirt" label="Умная стиральная машина" />
          <q-tab name="robot-vacuum" icon="fas fa-robot" label="Робот-пылесос" />
          <q-tab name="video-surveillance" icon="camera" label="Система видеонаблюдения" />
          <q-tab name="kettle" icon="fas fa-mug-hot" label="Интеллектуальный чайник" />
          <q-tab name="coffee-maker" icon="fas fa-coffee" label="Кофеварка" />
          <q-tab name="scales" icon="fas fa-weight" label="Умные кухонные весы" />
          <q-tab name="dish-washer" icon="room_service" label="Посудомоечная машина" />
          <q-tab name="lock" icon="lock" label="Умный замок" />
          <q-tab name="ac" icon="ac_unit" label="Климатконтроль" />
          <q-tab name="lamp" icon="fas fa-lightbulb" label="Умная лампочка" />
        </q-tabs>
      </template>

      <template v-slot:after>
        <q-tab-panels
          v-model="tab"
          animated
          transition-prev="jump-up"
          transition-next="jump-up"
        >
          <q-tab-panel name="fridge">
            <add-fridge />
          </q-tab-panel>
        </q-tab-panels>
      </template>
    </q-splitter>
  </q-page>
</template>

<script>
import addFridge from './addDevice/addFridge'

export default {
  components: {
    addFridge
  },
  name: "AddDevice",
  data () {
    return {
      tab: 'fridge',
    }
  },
};
</script>
