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
          <q-tab name="about" label="О проекте" />
          <q-tab name="task" label="Задание" />
          <q-tab name="help" label="Справка" />
        </q-tabs>

        <q-separator />

        <q-tab-panels
          v-model="tab"
          animated
          transition-prev="jump-up"
          transition-next="jump-up"
        >
          <q-tab-panel name="about">
            <div class="gutter-sm" id="page">
              <p class="text">Выполнил курсовой проект по дисциплине "Безопасность систем баз данных"</p>
              <p class="text">студент группы 641 Чесалин И.Е."</p>
              <p class="text">проверила старший преподаватель кафедры "Информационная безопасность" Калинкина Т.И.</p>
            </div>
          </q-tab-panel>

          <q-tab-panel name="task">
            <div class="gutter-sm" id="page">
              <p>TODO:</p>
            </div>
          </q-tab-panel>

          <q-tab-panel name="help">
            <div class="gutter-sm" id="page">
              <p>TODO:</p>
            </div>
          </q-tab-panel>
        </q-tab-panels>
      </q-card>
    </q-page>
  </q-layout>
</template>

<script>
export default {
  name: "AboutPage",
  data () {
    return {
      tab: 'about'
    }
  }
};
</script>

<style>
.text {
  font-size: 1.2em;
  text-align: center;
}

#page {
  width: 900px;
  max-width: 90vw;
}
</style>
