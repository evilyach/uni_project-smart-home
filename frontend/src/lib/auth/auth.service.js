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
        if (response.data.accessToken) {
          localStorage.setItem("user", JSON.stringify(response.data));
        }
      });
  }

  logout() {
    localStorage.removeItem("user");
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
