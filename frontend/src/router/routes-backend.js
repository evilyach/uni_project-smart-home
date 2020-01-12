export default {
  host: "http://localhost:13491",

  register() {
    return this.host + "/api/auth/register";
  },

  login() {
    return this.host + "/api/auth/login";
  },

  publicContent() {
    return this.host + "/api/test/all";
  },

  userBoard() {
    return this.host + "/api/test/user";
  },

  operatorBoard() {
    return this.host + "/api/test/operator";
  },

  adminBoard() {
    return this.host + "/api/test/admin";
  },

  table(table_name) {
    return this.host + `/api/raw/${table_name}`;
  },

  getRealEstates() {
    return this.host + "/api/get/real_estates";
  },

  getDevices() {
    return this.host + "/api/get/devices";
  },

  addDevice() {
    return this.host + "/api/set/device";
  }
};
