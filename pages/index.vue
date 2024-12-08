<script setup>
import files from '~/static/files.json'
const filesToDisplay = ref([])
const videoCount = ref(20)

function reloadVideos() {
  filesToDisplay.value = [...files].sort(() => 0.5 - Math.random()).slice(0, videoCount.value)
}

function reloadAll() {
  filesToDisplay.value = files
}

reloadAll()

</script>

<template>
  <v-app>
    <v-main>
      <v-container fluid>

        <h1>Salsa moves</h1>

        <v-btn variant="elevated" @click="reloadVideos">Load some random videos</v-btn>

        <br>
        <br>
        <v-text-field label="Num" variant="outlined" type="number" v-model="videoCount"></v-text-field>

        <v-btn variant="elevated" @click="reloadAll">Load all</v-btn>
        <br>
        <br>

        <v-row>
          <v-col class="pa-2 v-col-12 v-col-sm-6 v-col-md-4 v-col-lg-3 v-col-xl-2 align-self-center" v-for="file in filesToDisplay" :key="file.sha">
            <v-card variant="tonal" class="pa-0 ma-0">
              <v-card-title class="text-h5 text-center">
                {{ file.name.replace(/\.[^/.]+$/, '') }}
              </v-card-title>
              <my-lazy class="video-card">
                <video-player
                  :src="`https://media.githubusercontent.com/media/stas-sl/salsa-moves/refs/heads/main/moves/${file.name}`"
                  controls loop autoplay="muted" :playbackRate="1" :enableSmoothSeeking="true" fill playsinline />
              </my-lazy>
            </v-card>
          </v-col>
        </v-row>
      </v-container>
    </v-main>
  </v-app>
</template>

<style scoped>
.video-card {
  aspect-ratio: 1;
}
</style>