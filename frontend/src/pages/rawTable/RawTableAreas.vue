<template>
  <div class="q-pa-sm">
    <q-table title="Пространства" :data="data" :columns="columns" row-key="name">
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
          name: "area_id",
          align: "center",
          label: "Идентификатор пространства",
          field: row => row.area_id,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "area_real_estate_id",
          align: "center",
          label: "Идентификатор недвижимости",
          field: row => row.area_real_estate_id,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "area_name",
          align: "center",
          label: "Имя",
          field: row => row.name,
          format: val => `${val}`,
          sortable: true
        }
      ],
      data: [
        {
          name: "Гостинная",
          area_id: "1",
          area_real_estate_id: "1",
          area_name: "Гостинная",
        },
        {
          name: "Кухня",
          area_id: "2",
          area_real_estate_id: "1",
          area_name: "Кухня",
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