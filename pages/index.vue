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

        <v-container fluid class="pa-0">
          <v-row>
            <!-- <v-virtual-scroll :items="filesToDisplay" item-height="200">
              <template v-slot:default="{ item }">
                <v-col class="pa-2 v-col-auto align-self-center">
                  <v-card variant="tonal" class="pa-0 ma-0">
                    <v-card-title class="text-h5 text-center">
                      {{ item.name.replace(/\.[^/.]+$/, '').slice(1) }}
                    </v-card-title>
                    <v-lazy :min-height="200" :options="{ 'threshold': 0.5 }" transition="fade-transition">
                      <video autoplay muted controls loop class="d-block"
                        :src="`https://media.githubusercontent.com/media/stas-sl/salsa-moves/refs/heads/main/moves/${item.name}`">
                      </video>
                    </v-lazy>
                  </v-card>
                </v-col>
              </template>
</v-virtual-scroll> -->

            <v-col class="pa-2 v-col-auto align-self-center" v-for="file in filesToDisplay" :key="file.sha">
              <v-card variant="tonal" class="pa-0 ma-0">
                <v-card-title class="text-h5 text-center">
                  {{ file.name.replace(/\.[^/.]+$/, '').slice(1) }}
                </v-card-title>
                <my-lazy :min-height="200" class="video-card">
                  <video-player
                    :src="`https://media.githubusercontent.com/media/stas-sl/salsa-moves/refs/heads/main/moves/${file.name}`"
                    controls loop muted autoplay :playbackRate="1" :enableSmoothSeeking="true" fill />
                </my-lazy>
              </v-card>
            </v-col>
          </v-row>
        </v-container>

      </v-container>
    </v-main>
  </v-app>
</template>

<style scoped>
.video-card {
  width: 30vw;
  /* height: 30vh; */
  aspect-ratio: 1;
  /* height: 360px; */
  /* max-width: 30vw; */
  /* max-height: 50vh; */
}

/* .video-js, video {
  max-width: 30vw !important;
  max-height: 50vh !important;
} */
</style>