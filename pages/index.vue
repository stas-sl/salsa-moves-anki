<script setup>
import files from '~/static/files.json'
const filesToDisplay = ref([])
const videoCount = ref(5)

function reloadVideos() {
  filesToDisplay.value = [...files].sort(() => 0.5 - Math.random()).slice(0, videoCount.value)
}

function reloadAll() {
  filesToDisplay.value = files
}

reloadVideos()

</script>

<template>
  <!-- <v-responsive class="border rounded" max-height="300"> -->
  <v-app>
    <!-- <v-app-bar title="App bar"></v-app-bar> -->

    <!-- <v-navigation-drawer>
        <v-list>
          <v-list-item title="Navigation drawer"></v-list-item>
        </v-list>
      </v-navigation-drawer> -->

    <v-main>
      <v-container>

        <h1>Salsa moves</h1>

        <v-btn variant="elevated" @click="reloadVideos">Load some random videos</v-btn>

        <br>
        <br>
        <!-- <v-responsive class="ma-0 pa-0" width="100px"> -->
        <v-text-field label="Num" variant="outlined" type="number" v-model="videoCount"></v-text-field>
        <!-- </v-responsive> -->
        <!-- <br> -->
        <!-- <br> -->

        <v-btn variant="elevated" @click="reloadAll" >Load all</v-btn>
        <br>
        <br>

        <div class="video-container">
          <div v-for="file in filesToDisplay" :key="file.sha" class="video-item">
            <h2>{{ file.name.replace(/\.[^/.]+$/, "").slice(1) }}</h2>
            <video autoplay muted controls loop
              :src="`https://media.githubusercontent.com/media/stas-sl/salsa-moves/refs/heads/main/moves/${file.name}`"></video>
          </div>
        </div>

      </v-container>
    </v-main>
  </v-app>
  <!-- </v-responsive> -->
</template>

<style scoped>
.video {
  max-height: 50vh;
  width: 100%;
  height: auto;
}

.video-container {
  display: flex;
  flex-wrap: wrap;
  gap: 16px;
  justify-content: center;
  align-items: center;
}

.video-item {
  flex: 1 1 calc(30vw - 16px);
  max-width: 30vw;
}

.video-item h2 {
  text-align: center;
}
</style>