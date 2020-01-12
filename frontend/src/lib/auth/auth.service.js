import axios from "axios";
import crypto from "crypto";

import router from "./../../router/routes-backend";

class AuthService {
  login(user) {
    return axios
      .post(router.login(), {
        username: user.username,
        password: crypto
          .createHash("sha1")
          .update(user.password, "binary")
          .digest("hex")
      })
      .then(response => {
        if (response.data.token) {
          localStorage.setItem("user", JSON.stringify(response.data));
          localStorage.setItem("username", user.username);
        }
      });
  }

  logout() {
    localStorage.removeItem("user");
    localStorage.removeItem("username");
  }

  register(user) {
    return axios.post(router.register(), {
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
}

export default new AuthService();
