// https://nuxt.com/docs/api/configuration/nuxt-config

import { md3 } from "vuetify/blueprints";

export default defineNuxtConfig({
  compatibilityDate: "2024-11-01",
  devtools: { enabled: true },
  modules: ["vuetify-nuxt-module"],
  ssr: false,
  app: {
    buildAssetsDir: "/nuxt/"
  },
  vuetify: {
    moduleOptions: {
      /* module specific options */
    },
    vuetifyOptions: {
      theme: {
        defaultTheme: "dark"
      }
      // blueprint: md3
      /* vuetify options */
    }
  }
});
