import yaml from "@rollup/plugin-yaml";

export default defineNuxtConfig({
  compatibilityDate: "2024-11-01",
  devtools: { enabled: true },
  modules: ["vuetify-nuxt-module", "nuxt-lodash"],
  ssr: false,
  runtimeConfig: {
    public: {
      mediaUrl: "https://salsa-moves.curious.by/media/moves/",
      // mediaUrl: "https://media.githubusercontent.com/media/stas-sl/salsa-moves/refs/heads/main/media/moves/",
      // mediaUrl: "/media/moves/",
      storeUrl: "https://salsa-moves.curious.by/"
    }
  },
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
  },
  lodash: {
    prefix: "_",
    upperAfterPrefix: false,
  }
});
