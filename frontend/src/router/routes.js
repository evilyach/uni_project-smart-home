import MyLayout from "layouts/MyLayout.vue";
import Index from "pages/Index.vue";
import About from "pages/About.vue";

const routes = [
  {
    path: "",
    component: MyLayout,
    children: [
      {
        path: "/index",
        component: Index
      },
      {
        path: "/about",
        component: About
      }
    ]
  }
];

// Always leave this as last one
if (process.env.MODE !== "ssr") {
  routes.push({
    path: "*",
    component: () => import("pages/Error404.vue")
  });
}

export default routes;
