<template>
  <div class="q-pa-sm">
    <q-table title="Устройства" :data="data" :columns="columns" row-key="name">
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
          name: "device_id",
          align: "center",
          label: "Идентификатор устройства",
          field: row => row.device_id,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "device_real_estate_id",
          align: "center",
          label: "Идентификатор помещения",
          field: row => row.device_real_estate_id,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "device_area_id",
          align: "center",
          label: "Идентификатор пространства",
          field: row => row.device_area_id,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "device_device_type_id",
          align: "center",
          label: "Идентификатор типа устройства",
          field: row => row.device_device_type_id,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "device_parameters",
          align: "center",
          label: "Параметры устройства",
          field: row => row.device_parameters,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "device_status",
          align: "center",
          label: "Статус устройства",
          field: row => row.device_status,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "device_time_activated",
          align: "center",
          label: "Время активации",
          field: row => row.device_time_activated,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "device_time_deactivated",
          align: "center",
          label: "Время выключения",
          field: row => row.device_time_deactivated,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "device_is_active",
          align: "center",
          label: "Включено ли устройство",
          field: row => row.device_is_active,
          format: val => `${val}`,
          sortable: true
        },
      ],
      data: [
        {
          name: "Кондиционер SUPER AC 9000",
          device_id: "1",
          device_real_estate_id: "1",
          device_area_id: "1",
          device_device_type_id: "1",
          device_parameters: "Режимы: охлаждение и обогревание",
          device_status: "Включен",
          device_time_activated: "22:10",
          device_time_deactivated: "22:15",
          device_is_active: "Включено"
        },
        {
          name: "Кондиционер MEGA AC 2000",
          device_id: "2",
          device_real_estate_id: "1",
          device_area_id: "2",
          device_device_type_id: "1",
          device_parameters: "Режимы: охлаждение",
          device_status: "Ошибка",
          device_time_activated: "22:20",
          device_time_deactivated: "22:55",
          device_is_active: "Выключено"
        },
        {
          name: "Умный чайник AWESOME TEAPOT 1000",
          device_id: "3",
          device_real_estate_id: "1",
          device_area_id: "3",
          device_device_type_id: "2",
          device_parameters: "Время подогрева: 10 минут",
          device_status: "Успешно завершено",
          device_time_activated: "22:40",
          device_time_deactivated: "22:50",
          device_is_active: "Выключено"
        },
      ]
    };
  }
};
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
