<template>
  <div class="q-pa-sm">
    <q-table title="Типы недвижимости" :data="data" :columns="columns" row-key="name">
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
          name: "real_estate_type_id",
          align: "center",
          label: "Идентификатор типа недвижимости",
          field: row => row.real_estate_type_id,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "real_estate_type_type_name",
          align: "center",
          label: "Тип недвижимости",
          field: row => row.real_estate_type_type_name,
          format: val => `${val}`,
          sortable: true
        }
      ],
      data: [
        {
          name: "Жилой дом",
          real_estate_type_id: "1",
          real_estate_type_type_name: "Жилой дом",
        },
        {
          name: "Загородная дача",
          real_estate_type_id: "2",
          real_estate_type_type_name: "Загородная дача",
        },
        {
          name: "Гараж",
          real_estate_type_id: "3",
          real_estate_type_type_name: "Гараж",
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
  max-width: 300px;
  white-space: normal;
  color: #555;
  margin-top: 4px;
}
</style>