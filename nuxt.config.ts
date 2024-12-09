import yaml from "@rollup/plugin-yaml";

export default defineNuxtConfig({
  compatibilityDate: "2024-11-01",
  devtools: { enabled: true },
  modules: ["vuetify-nuxt-module"],
  ssr: false,
  app: {
    buildAssetsDir: "/nuxt/",
    head: {
      title: "Salsa Moves"
    }
  },
  vuetify: {
    moduleOptions: {},
    vuetifyOptions: {
      theme: {
        defaultTheme: "dark"
      }
    }
  },
  vite: {
    plugins: [yaml()]
  }
});
