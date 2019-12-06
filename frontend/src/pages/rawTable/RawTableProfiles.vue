<template>
  <div class="q-pa-sm">
    <q-table title="Профиль" :data="data" :columns="columns" row-key="name">
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
          name: "profile_id",
          align: "center",
          label: "Идентификатор профиля",
          field: row => row.profile_id,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "profile_user_account_id",
          align: "center",
          label: "Идентификатор аккаунта пользователя",
          field: row => row.profile_user_account_id,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "device_profile_name",
          align: "center",
          label: "Имя профиля",
          field: row => row.device_profile_name,
          format: val => `${val}`,
          sortable: true
        }
      ],
      data: [
        {
          name: "Будние дни",
          profile_id: "1",
          profile_user_account_id: "1",
          device_profile_name: "Будние дни",
        },
        {
          name: "Выходные дни",
          profile_id: "2",
          profile_user_account_id: "1",
          device_profile_name: "Выходные дни",
        },
        {
          name: "Праздники",
          profile_id: "3",
          profile_user_account_id: "1",
          device_profile_name: "Праздники",
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