<script setup>
import files from '~/static/files.json'

console.log(files)
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
        <h1>Main Content</h1>
        <code>
          {{ files }}
        </code>
      </v-container>
    </v-main>
  </v-app>
  <!-- </v-responsive> -->
</template>

<style scoped>
<style>body {
  background-color: black;
  color: white;
}

video {
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

h1 {
  text-align: center;
}
</style>