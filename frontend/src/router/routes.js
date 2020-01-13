import rights from "../models/rights";

const guard = (to, from, next, right) => {
  const rights = localStorage.getItem("rights").split(",");
  if (rights[right] === "true") {
    next();
  } else {
    next("*");
  }
};

const routes = [
  {
    path: "/auth",
    component: () => import("pages/auth/auth.vue")
  },
  {
    path: "/",
    component: () => import("layouts/layout.vue"),
    children: [
      {
        path: "/",
        component: () => import("pages/listDevices.vue")
      },
      {
        path: "/index",
        component: () => import("pages/listDevices.vue")
      },
      {
        path: "/profile",
        component: () => import("pages/auth/profile.vue")
      },
      {
        path: "/about",
        component: () => import("pages/about.vue")
      },
      {
        path: "/addNew",
        component: () => import("pages/addDevice.vue"),
        beforeEnter: (to, from, next) => {
          guard(to, from, next, rights.write_data_right);
        }
      },
      {
        path: "/delete",
        component: () => import("pages/deleteDevice.vue"),
        beforeEnter: (to, from, next) => {
          guard(to, from, next, rights.write_data_right);
        }
      },
      {
        path: "/list",
        component: () => import("pages/listDevices.vue"),
        beforeEnter: (to, from, next) => {
          guard(to, from, next, rights.read_data_right);
        }
      },
      {
        path: "/rawAreas",
        component: () => import("pages/rawTable/RawTableAreas.vue"),
        beforeEnter: (to, from, next) => {
          guard(to, from, next, rights.read_raw_tables_right);
        }
      },
      {
        path: "/rawCommands",
        component: () => import("pages/rawTable/RawTableCommands.vue"),
        beforeEnter: (to, from, next) => {
          guard(to, from, next, rights.read_raw_tables_right);
        }
      },
      {
        path: "/rawCommandsByDevice",
        component: () => import("pages/rawTable/RawTableCommandsByDevice.vue"),
        beforeEnter: (to, from, next) => {
          guard(to, from, next, rights.read_raw_tables_right);
        }
      },
      {
        path: "/rawCommandTypes",
        component: () => import("pages/rawTable/RawTableCommandTypes.vue"),
        beforeEnter: (to, from, next) => {
          guard(to, from, next, rights.read_raw_tables_right);
        }
      },
      {
        path: "/rawDevices",
        component: () => import("pages/rawTable/RawTableDevices.vue"),
        beforeEnter: (to, from, next) => {
          guard(to, from, next, rights.read_raw_tables_right);
        }
      },
      {
        path: "/rawDeviceParameters",
        component: () => import("pages/rawTable/RawTableDeviceParameters.vue"),
        beforeEnter: (to, from, next) => {
          guard(to, from, next, rights.read_raw_tables_right);
        }
      },
      {
        path: "/rawDeviceTypes",
        component: () => import("pages/rawTable/RawTableDeviceTypes.vue"),
        beforeEnter: (to, from, next) => {
          guard(to, from, next, rights.read_raw_tables_right);
        }
      },
      {
        path: "/rawDevicesByUserAccount",
        component: () =>
          import("pages/rawTable/RawTableDevicesByUserAccount.vue"),
        beforeEnter: (to, from, next) => {
          guard(to, from, next, rights.read_raw_tables_right);
        }
      },
      {
        path: "/rawDevicesInProfile",
        component: () =>
          import("pages/rawTable/RawTableDevicesByUserAccount.vue"),
        beforeEnter: (to, from, next) => {
          guard(to, from, next, rights.read_raw_tables_right);
        }
      },
      {
        path: "/rawProfiles",
        component: () => import("pages/rawTable/RawTableProfiles.vue"),
        beforeEnter: (to, from, next) => {
          guard(to, from, next, rights.read_raw_tables_right);
        }
      },
      {
        path: "/rawRealEstateTypes",
        component: () => import("pages/rawTable/RawTableRealEstateTypes.vue"),
        beforeEnter: (to, from, next) => {
          guard(to, from, next, rights.read_raw_tables_right);
        }
      },
      {
        path: "/rawRealEstates",
        component: () => import("pages/rawTable/RawTableRealEstates.vue"),
        beforeEnter: (to, from, next) => {
          guard(to, from, next, rights.read_raw_tables_right);
        }
      },
      {
        path: "/rawUserAccounts",
        component: () => import("pages/rawTable/RawTableUserAccounts.vue"),
        beforeEnter: (to, from, next) => {
          guard(to, from, next, rights.read_raw_tables_right);
        }
      },
      {
        path: "/rawUserAccountTypes",
        component: () => import("pages/rawTable/RawTableUserAccountTypes.vue"),
        beforeEnter: (to, from, next) => {
          guard(to, from, next, rights.read_raw_tables_right);
        }
      },
      {
        path: "/rawUserAccountRights",
        component: () =>
          import("pages/rawTable/RawTableUserAccountTypeRights.vue"),
        beforeEnter: (to, from, next) => {
          guard(to, from, next, rights.read_raw_tables_right);
        }
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
