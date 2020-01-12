import axios from "axios";

import { login, register } from "./../../router/routes-backend";

class AuthService {
  login(user) {
    return axios
      .post(login(), {
        username: user.username,
        password: user.password
      })
      .then(this.handleResponse)
      .then(response => {
        if (response.data.accessToken) {
          localStorage.setItem("user", JSON.stringify(response.data));
        }
      });
  }

  logout() {
    localStorage.removeItem("user");
  }

  register(user) {
    return axios.post(register(), {
      user_account_type_id: 3,
      username: user.username,
      name: user.name,
      password: crypto
        .createHash("sha1")
        .update(user.password, "binary")
        .digest("hex"),
      email: user.email
    });
  }

  handleResponse(response) {
    if (response.status === 401) {
      this.logout();
      location.reload(true);

      const error = response.data && response.data.message;
      return Promise.reject(error);
    }

    return Promise.resolve(response);
  }
}

export default new AuthService();
