<template>
  <q-btn-dropdown
    split
    class="glossy"
    color="bg-secondary"
    label="Тип устройства"
    @click="onMainClick"
  >
    <q-list>
      <q-item clickable v-close-popup @click="onItemClick">
        <q-item-section avatar>
          <q-avatar icon="ac_unit" color="primary" text-color="white" />
        </q-item-section>
        <q-item-section>
          <q-item-label>Кондиционер</q-item-label>
        </q-item-section>
      </q-item>

      <q-item clickable v-close-popup @click="onItemClick">
        <q-item-section avatar>
          <q-avatar icon="fas fa-fan" color="primary" text-color="white" />
        </q-item-section>
        <q-item-section>
          <q-item-label>Умный вентилятор</q-item-label>
        </q-item-section>
      </q-item>

      <q-item clickable v-close-popup @click="onItemClick">
        <q-item-section avatar>
          <q-avatar icon="free_breakfast" color="primary" text-color="white" />
        </q-item-section>
        <q-item-section>
          <q-item-label>Умный чайник</q-item-label>
        </q-item-section>
      </q-item>

      <q-item clickable v-close-popup @click="onItemClick">
        <q-item-section avatar>
          <q-avatar icon="free_breakfast" color="primary" text-color="white" />
        </q-item-section>
        <q-item-section>
          <q-item-label>LED лампа</q-item-label>
        </q-item-section>
      </q-item>
    </q-list>
  </q-btn-dropdown>
</template>

<script>
export default {
  props: {
    buttons: {
      type: Array,
      required: true
    }
  },
  name: "DeviceTypeButton"
};
</script>