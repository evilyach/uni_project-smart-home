const routes = [
  {
    path: "",
    component: () => import("layouts/layout.vue"),
    children: [
      {
        path: "/index",
        component: () => import("pages/index.vue")
      },
      {
        path: "/about",
        component: () => import("pages/about.vue")
      }
    ]
  }
];

// Always leave this as last one
if (process.env.MODE !== "ssr") {
  routes.push({
    path: "*",
    component: () => import("pages/404.vue")
  });
}

export default routes;
