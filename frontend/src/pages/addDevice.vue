<template>
  <q-page class="flex flex-center">
    <q-splitter
      v-model="splitterModel"
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
          <q-tab-panel name="fridge" style="width: 100%">
            <div class="text-h4 q-mb-md">Умный холодильник</div>

            <q-input
              v-model="text_fridge_ip"
              filled
              label="IP-адрес"
              hint="Введите сетевой адрес устройства"
              style="width: 99%"
            />

            <div style="height: 20px" />

            <q-input
              v-model="text_fridge_password"
              filled
              label="Пароль"
              hint="Введите пароль доступа"
              style="width: 99%"
              :type="fridge_isPwd ? 'password' : 'text'"
            >
              <template v-slot:append>
                <q-icon
                  :name="fridge_isPwd ? 'visibility_off' : 'visibility'"
                  class="cursor-pointer"
                  @click="fridge_isPwd = !fridge_isPwd"
                />
              </template>
            </q-input>

            <div style="height: 20px" />

            <q-input
              v-model="text_fridge_temperature"
              filled
              label="Температура"
              hint="Введите температуру работы холодильника"
              style="width: 99%"
            />

            <div style="height: 20px" />

            <q-btn name="fridge_add" outline rounded color="primary" label="Добавить" />
          </q-tab-panel>

          <!-- ------- -->

          <q-tab-panel name="washing-machine" style="width: 100%">
            <div class="text-h4 q-mb-md">Умная стиральная машина</div>

            <q-input
              v-model="text_washing_machine_ip"
              filled
              label="IP-адрес"
              hint="Введите сетевой адрес устройства"
              style="width: 99%"
            />

            <div style="height: 20px" />

            <q-input
              v-model="text_washing_machine_password"
              filled
              label="Пароль"
              hint="Введите пароль доступа"
              style="width: 99%"
              :type="washing_machine_isPwd ? 'password' : 'text'"
            >
              <template v-slot:append>
                <q-icon
                  :name="washing_machine_isPwd ? 'visibility_off' : 'visibility'"
                  class="cursor-pointer"
                  @click="washing_machine_isPwd = !washing_machine_isPwd"
                />
              </template>
            </q-input>

            <div style="height: 20px" />

            <q-input
              v-model="text_washing_machine_speed"
              filled
              label="Скорость"
              hint="Введите скорость вращения барабана"
              style="width: 99%"
            />

            <div style="height: 20px" />

            <q-btn outline rounded color="primary" label="Добавить" />
          </q-tab-panel>

          <!-- ------- -->

          <q-tab-panel name="robot-vacuum" style="width: 100%">
            <div class="text-h4 q-mb-md">Робот-пылесос</div>

            <q-input
              v-model="text_robot_vacuum_ip"
              filled
              label="IP-адрес"
              hint="Введите сетевой адрес устройства"
              style="width: 99%"
            />

            <div style="height: 20px" />

            <q-input
              v-model="text_robot_vacuum_password"
              filled
              label="Пароль"
              hint="Введите пароль доступа"
              style="width: 99%"
              :type="robot_vacuum_isPwd ? 'password' : 'text'"
            >
              <template v-slot:append>
                <q-icon
                  :name="robot_vacuum_isPwd ? 'visibility_off' : 'visibility'"
                  class="cursor-pointer"
                  @click="robot_vacuum_isPwd = !robot_vacuum_isPwd"
                />
              </template>
            </q-input>

            <div style="height: 20px" />

            <q-input
              v-model="text_robot_vacuum_speed"
              filled
              label="Скорость"
              hint="Введите скорость передвижения пылесоса"
              style="width: 99%"
            />

            <div style="height: 20px" />

            <q-input
              v-model="text_robot_vacuum_max_value"
              filled
              label="Количество комнат"
              hint="Введите количество комнат, в которых пылесос будет вести работу"
              style="width: 99%"
            />

            <div style="height: 20px" />

            <q-btn outline rounded color="primary" label="Добавить" />
          </q-tab-panel>

          <!-- ------- -->

          <q-tab-panel name="video-surveillance" style="width: 100%">
            <div class="text-h4 q-mb-md">Система видеонаблюдения</div>

            <q-input
              v-model="text_video_surveillance_ip"
              filled
              label="IP-адрес"
              hint="Введите сетевой адрес устройства"
              style="width: 99%"
            />

            <div style="height: 20px" />

            <q-input
              v-model="text_video_surveillance_password"
              filled
              label="Пароль"
              hint="Введите пароль доступа"
              style="width: 99%"
              :type="video_surveillance_isPwd ? 'password' : 'text'"
            >
              <template v-slot:append>
                <q-icon
                  :name="video_surveillance_isPwd ? 'visibility_off' : 'visibility'"
                  class="cursor-pointer"
                  @click="video_surveillance_isPwd = !video_surveillance_isPwd"
                />
              </template>
            </q-input>

            <div style="height: 20px" />

            <q-checkbox
              right-label
              v-model="video_surveillance_to_alarm"
              label="Включить оповещение?"
            />

            <div style="height: 20px" />

            <q-btn outline rounded color="primary" label="Добавить" />
          </q-tab-panel>

          <!-- ------- -->

          <q-tab-panel name="kettle" style="width: 100%">
            <div class="text-h4 q-mb-md">Интеллектуальный чайник</div>

            <q-input
              v-model="text_kettle_ip"
              filled
              label="IP-адрес"
              hint="Введите сетевой адрес устройства"
              style="width: 99%"
            />

            <div style="height: 20px" />

            <q-input
              v-model="text_kettle_password"
              filled
              label="Пароль"
              hint="Введите пароль доступа"
              style="width: 99%"
              :type="kettle_isPwd ? 'password' : 'text'"
            >
              <template v-slot:append>
                <q-icon
                  :name="kettle_isPwd ? 'visibility_off' : 'visibility'"
                  class="cursor-pointer"
                  @click="kettle_isPwd = !kettle_isPwd"
                />
              </template>
            </q-input>

            <div style="height: 20px" />

            <q-color v-model="kettle_color" class="my-picker" />

            <div style="height: 20px" />

            <q-input
              v-model="text_kettle_temperature"
              filled
              label="Время работы"
              hint="Введите температуру работы чайника"
              style="width: 99%"
            />

            <div style="height: 20px" />

            <q-input
              v-model="text_kettle_speed"
              filled
              label="Скорость"
              hint="Введите скорость закипания чайника (в секундах)"
              style="width: 99%"
            />

            <div style="height: 20px" />

            <q-checkbox
              right-label
              v-model="kettle_to_alarm"
              label="Включить оповещение?"
            />

            <div style="height: 20px" />

            <q-btn outline rounded color="primary" label="Добавить" />
          </q-tab-panel>
        </q-tab-panels>
      </template>
    </q-splitter>
  </q-page>
</template>

<script>
export default {
  name: "AddDevice",
  data () {
    return {
      tab: 'fridge',

      text_fridge_ip: '192.168.0.1',
      text_fridge_password: '',
      text_fridge_temperature: '',
      fridge_isPwd: true,

      text_washing_machine_ip: '192.168.0.1',
      text_washing_machine_password: '',
      text_washing_machine_speed: '',
      washing_machine_isPwd: true,

      text_robot_vacuum_ip: '192.168.0.1',
      text_robot_vacuum_password: '',
      text_robot_vacuum_speed: '',
      text_robot_vacuum_max_value: '',
      robot_vacuum_isPwd: true,

      text_video_surveillance_ip: '192.168.0.1',
      text_video_surveillance_password: '',
      video_surveillance_to_alarm: true,
      video_surveillance_isPwd: true,

      text_kettle_ip: '192.168.0.1',
      text_kettle_password: '',
      text_kettle_temperature: '',
      text_kettle_speed: '',
      kettle_color: '#FF00FF',
      kettle_to_alarm: true,
      kettle_temperature: '',
    }
  },
};
</script>

<style lang="sass" scoped>
.my-picker
  max-width: 250px
</style>