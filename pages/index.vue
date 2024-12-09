<script setup>
import files from '~/static/files.json'
import descriptions from '~/static/descriptions.json'

const filesToDisplay = ref([])
const videoCount = ref(20)

const filesExtra = computed(() => {
  return files.map((f) => ({
    ...f,
    move: f.name.replace(/\.[^/.]+$/, ''),
    description: descriptions[f.name.replace(/\.[^/.]+$/, '')]
  }))
});

const uid = useState('uid')

function reloadVideos() {
  filesToDisplay.value = [...filesExtra.value].sort(() => 0.5 - Math.random()).slice(0, videoCount.value)
}

function reloadAll() {
  filesToDisplay.value = filesExtra.value
}

function addMoveLinks(s) {
  return s.replace(/s\d{3}[a-z]?/g, (match) => `<a href="#${match}">${match}</a>`);
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
          <v-col class="pa-2 v-col-12 v-col-sm-6 v-col-md-4 v-col-lg-3 v-col-xl-2"
            v-for="file in filesToDisplay" :key="file.sha">
            <v-card variant="tonal" class="pa-0 ma-0">
              <v-card-title class="text-h5 text-center" :id="file.move">
                {{ file.move }}
              </v-card-title>
              <my-lazy class="video-card">
                <video-player
                  :src="`https://media.githubusercontent.com/media/stas-sl/salsa-moves/refs/heads/main/moves/${file.name}`"
                  loop controls autoplay="muted" responsive :playbackRate="1" :enableSmoothSeeking="true" fill
                  playsinline @ready="$event.target.player.userActive(false)" />
              </my-lazy>
              <v-card-text v-if="file.description">
                <p v-if="file.description?.text" v-html="file.description?.text"></p>
                <p v-if="file.description?.related">
                  <span class="text-subtitle-1">Related:</span> <span v-html="addMoveLinks(file.description?.related)"></span>
                </p>
              </v-card-text>
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