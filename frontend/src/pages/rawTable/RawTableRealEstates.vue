<template>
  <div class="q-pa-md">
    <q-table title="Недвижимость" :data="data" :columns="columns" row-key="name">
      <template v-slot:body-cell-name="props">
        <q-td :props="props">
          <div>
            <q-badge color="$primary" :label="props.value" />
          </div>
          <div class="my-table-details">
            {{ props.row.details }}
          </div>
        </q-td>
      </template>
    </q-table>
  </div>
</template>

<script>
export default {
  data() {
    return {
      columns: [
        {
          name: "name",
          required: true,
          label: "Название столбца",
          align: "center",
          field: row => row.name,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "real_estate_id",
          align: "center",
          label: "Идентификатор недвижимости",
          field: row => row.real_estate_id,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "real_estate_user_account_id",
          align: "center",
          label: "Идентификатор аккаунта пользователя",
          field: row => row.real_estate_user_account_id,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "real_estate_real_estate_type_id",
          align: "center",
          label: "Идентификатор типа недвижимости",
          field: row => row.real_estate_real_estate_type_id,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "real_estate_name",
          align: "center",
          label: "Имя",
          field: row => row.real_estate_name,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "real_estate_address",
          align: "center",
          label: "Имя",
          field: row => row.real_estate_address,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "real_estate_details",
          align: "center",
          label: "Имя",
          field: row => row.real_estate_details,
          format: val => `${val}`,
          sortable: true
        },
      ],
      data: [
        {
          name: "Дом на Пушкина",
          real_estate_id: "1",
          real_estate_user_account_id: "1",
          real_estate_real_estate_type_id: "1",
          real_estate_name: "Дом на Пушкина",
          real_estate_address: "Рязанская область, г. Рязань, ул. Пушкина, д. 1, кв. 100",
          real_estate_details: "Дом, где живет владелец информационной системы"
        },
        {
          name: "Дача в Подмосковье",
          real_estate_id: "1",
          real_estate_user_account_id: "1",
          real_estate_real_estate_type_id: "2",
          real_estate_name: "Дача в Подмосковье",
          real_estate_address: "Московская область, г. Бронницы, ул. Дачная, д. 114",
          real_estate_details: "Летняя дача"
        },
        {
          name: "Гараж",
          real_estate_id: "1",
          real_estate_user_account_id: "1",
          real_estate_real_estate_type_id: "3",
          real_estate_name: "Гараж",
          real_estate_address: "Рязанская область, г. Рязань, ул. Пушкина, стр. 15",
          real_estate_details: "Гараж для работы над автомобилем"
        },
      ]
    }
  }
}
</script>

<style>
.my-table-details {
  font-size: 0.85em;
  font-style: italic;
  max-width: 200px;
  white-space: normal;
  color: #555;
  margin-top: 4px;
  margin-right: 100px;
}
</style>