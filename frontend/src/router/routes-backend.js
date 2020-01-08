const host = "http://localhost:13491";

export default {
  register() {
    return host + "/api/auth/register";
  },

  login() {
    return host + "/api/auth/login";
  },

  table(table_name) {
    return host + `/api/raw/${table_name}`;
  },

  getRealEstates() {
    return host + "/api/get/real_estates";
  },

  getDevices() {
    return host + "/api/get/devices";
  },

  addDevice() {
    return host + "/api/set/device";
  }
};
