// Configuration for your app
// https://quasar.dev/quasar-cli/quasar-conf-js

module.exports = function(ctx) {
  return {
    boot: [],
    css: ["app.styl"],
    extras: [
      "roboto-font",
      "material-icons",
      "fontawesome-v5"
    ],
    framework: {
      all: "auto",
      components: ["QToggle"],
      directives: [],
      plugins: []
    },
    supportIE: false,
    build: {
      scopeHoisting: true,
      vueRouterMode: "history",
      showProgress: false,
      gzip: true,
      analyze: true,
      preloadChunks: false,
      extractCSS: false,
      extendWebpack(cfg) {
        cfg.module.rules.push({
          enforce: "pre",
          test: /\.(js|vue)$/,
          loader: "eslint-loader",
          exclude: /node_modules/,
          options: {
            formatter: require("eslint").CLIEngine.getFormatter("stylish")
          }
        });
      }
    },
    devServer: {
      https: true,
      port: 13490,
      open: true // opens browser window automatically
    },
    animations: "all",
    ssr: {
      pwa: false
    },
    pwa: {
      manifest: {
        name: "Smart Home Course Project",
        short_name: "SHCP",
        description: '"Smart Home" DBSec Course Project',
        display: "standalone",
        orientation: "portrait",
        background_color: "#ffffff",
        theme_color: "#027be3",
        icons: [
          {
            src: "statics/icons/icon-128x128.png",
            sizes: "128x128",
            type: "image/png"
          },
        ]
      }
    },
    cordova: {},
    electron: {
      extendWebpack(cfg) {},
      packager: {},
      builder: {}
    }
  };
}
