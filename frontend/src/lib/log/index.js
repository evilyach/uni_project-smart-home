import axios from "axios";
import router from "../../router/routes-backend";

export function addLogRecord(log) {
  const date = new Date();
  const time =
    date.getFullYear() +
    "-" +
    (date.getMonth() + 1) +
    "-" +
    date.getDate() +
    " " +
    date.getHours() +
    ":" +
    date.getMinutes() +
    ":" +
    date.getSeconds();

  axios
    .post(router.addLogRecord(), {
      log_level: log.log_level,
      message: log.message,
      time: time,
      author: localStorage.getItem("username")
    })
    .then(() => {
      return 0;
    })
    .catch(error => {
      console.log(`Could not add record to a DB: ${error}`);
      return -1;
    });
}
