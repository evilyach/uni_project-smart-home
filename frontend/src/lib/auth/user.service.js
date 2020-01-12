import axios from "axios";
import authHeader from "./auth-header";

import {
  publicContent,
  userBoard,
  operatorBoard,
  adminBoard
} from "./../../router/routes-backend";

class UserService {
  getPublicContent() {
    return axios.get(publicContent());
  }

  getUserBoard() {
    return axios.get(userBoard(), { headers: authHeader() });
  }

  getOperatorBoard() {
    return axios.get(operatorBoard(), { headers: authHeader() });
  }

  getAdminBoard() {
    return axios.get(adminBoard(), { headers: authHeader() });
  }
}

export default new UserService();