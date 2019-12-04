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
      },
      {
        path: "/addnew",
        component: () => import("pages/addDevice.vue")
      },
      {
        path: "/rawAreas",
        component: () => import("pages/rawTable/RawTableAreas.vue")
      },
      {
        path: "/rawDeviceTypes",
        component: () => import("pages/rawTable/RawTableDeviceTypes.vue")
      },
      {
        path: "/rawDevices",
        component: () => import("pages/rawTable/RawTableDevices.vue")
      },
      {
        path: "/rawProfiles",
        component: () => import("pages/rawTable/RawTableProfiles.vue")
      },
      {
        path: "/rawRealEstateTypes",
        component: () => import("pages/rawTable/RawTableRealEstateTypes.vue")
      },
      {
        path: "/rawRealEstates",
        component: () => import("pages/rawTable/RawTableRealEstates.vue")
      },
      {
        path: "/rawUserAccounts",
        component: () => import("pages/rawTable/RawTableUserAccounts.vue")
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