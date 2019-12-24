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

          <q-tab-panel name="washing-machine">
            <add-washing-machine />
          </q-tab-panel>

          <q-tab-panel name="robot-vacuum">
            <add-robot-vacuum />
          </q-tab-panel>

          <q-tab-panel name="video-surveillance">
            <add-video-surveillance />
          </q-tab-panel>

          <q-tab-panel name="kettle">
            <add-kettle />
          </q-tab-panel>

          <q-tab-panel name="coffee-maker">
            <add-coffee-maker />
          </q-tab-panel>

          <q-tab-panel name="scales">
            <add-scales />
          </q-tab-panel>
        </q-tab-panels>
      </template>
    </q-splitter>
  </q-page>
</template>

<script>
import addFridge from './addDevice/addFridge';
import addWashingMachine from './addDevice/addWashingMachine';
import addRobotVacuum from './addDevice/addRobotVacuum';
import addVideoSurveillance from './addDevice/addVideoSurveillance';
import addKettle from './addDevice/addKettle';
import addCoffeeMaker from './addDevice/addCoffeeMaker';
import addScales from './addDevice/addScales';

export default {
  components: {
    addFridge,
    addWashingMachine,
    addRobotVacuum,
    addVideoSurveillance,
    addKettle,
    addCoffeeMaker,
    addScales
  },
  name: "AddDevice",
  data () {
    return {
      tab: 'fridge',
    }
  },
};
</script>
