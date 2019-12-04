<template>
  <div class="q-pa-sm">
    <q-table title="Типы устройств" :data="data" :columns="columns" row-key="name">
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
          name: "device_type_id",
          align: "center",
          label: "Идентификатор типа устройства",
          field: row => row.device_type_id,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "device_type_type",
          align: "center",
          label: "Тип устройства",
          field: row => row.device_type_type,
          format: val => `${val}`,
          sortable: true
        },
        {
          name: "device_type_description",
          align: "justify",
          label: "Описание",
          field: row => row.device_type_description,
          format: val => `${val}`,
          sortable: true
        }
      ],
      data: [
        {
          name: "Кондиционер",
          device_type_id: "1",
          device_type_type: "Кондиционер",
          device_type_description: "Кондиционе́р (англ. conditioner) — устройство для поддержания оптимальных климатических условий в помещениях строительных сооружений, транспортных средств и другой техники.",
        },
        {
          name: "Умный вентилятор",
          device_type_id: "2",
          device_type_type: "Умный вентилятор",
          device_type_description: "Вентилятор — устройство для перемещения газа со степенью сжатия менее 1,15 (или разностью давлений на выходе и входе не более 15 кПа, при большей разнице давлений используют компрессор).",
        },
        {
          name: "Умный чайник",
          device_type_id: "3",
          device_type_type: "Умный чайник",
          device_type_description: "Ча́йник — небольшой закрытый сосуд с носиком, крышкой (как правило, хотя бывают и исключения — см. фото) и ручкой для подогревания и кипячения воды. Обычно чайники изготавливаются из металла.",
        },
        {
          name: "LED лампа",
          device_type_id: "4",
          device_type_type: "LED лампа",
          device_type_description: "Светодиодное освещение — одно из перспективных направлений технологий искусственного освещения, основанное на использовании светодиодов в качестве источника света.",
        }
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
