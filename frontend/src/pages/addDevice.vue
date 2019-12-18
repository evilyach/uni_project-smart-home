<template>
    <q-page class="flex flex-center">
      <device-type-button />
    </q-page>
</template>

<script>
import DeviceTypeButton from '../components/Buttons/DeviceTypeButton'

export default {
  name: "PageIndex",
  components: [
    DeviceTypeButton
  ]
};
</script>
