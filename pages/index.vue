<script setup>
import { ref, h, Fragment } from "vue"
import { VChip } from "vuetify/components"

import files from '~/static/files.json'
import descriptions from '~/static/descriptions.json'

const filesToDisplay = ref([])
const videoCount = ref(20)
const isMenuOpen = ref(false)
const menuActivator = ref(null)
const menuMove = ref('')

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

function splitByMoves(s) {
  const r = /(?<=\b)s\d{3}[a-z]?(?=\b)/g;

  let lastIndex = 0;
  const parts = [];
  let match;

  while ((match = r.exec(s)) !== null) {
    if (match.index > lastIndex) {
      parts.push({
        text: s.slice(lastIndex, match.index),
        isMatch: false,
      });
    }

    parts.push({
      text: match[0],
      isMatch: true,
    });

    lastIndex = r.lastIndex;
  }

  if (lastIndex < s.length) {
    parts.push({
      text: s.slice(lastIndex),
      isMatch: false,
    });
  }

  return parts;
}

function renderMoveRefs(s) {
  return h(Fragment, null, splitByMoves(s).map((x) => {
    if (x.isMatch) {
      return h(VChip, {
        size: 'default', variant: 'flat', link: true, class: 'mx-1 mt-n1',
        onClick: (e) => {
          menuActivator.value = e.target
          isMenuOpen.value = true
          menuMove.value = x.text
        }
      },
        () => x.text)
    } else {
      return x.text == ',' ? "" : x.text;
    }
  }))
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
        <v-btn variant="elevated" @click="menuActivator = $event.target; isMenuOpen = true;">Show dialog</v-btn>
        <br>
        <br>

        <v-row>
          <v-col class="pa-2 v-col-12 v-col-sm-6 v-col-md-4 v-col-lg-3 v-col-xl-2" v-for="file in filesToDisplay"
            :key="file.sha">
            <v-hover v-slot="{ isHovering, props }">
              <v-card variant="flat" :color="isHovering ? 'indigo' : undefined" class="pa-0 ma-0" v-bind="props">
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
                    <span class="text-subtitle-1">Related:</span>
                    <component :is="renderMoveRefs(file.description?.related)" />
                  </p>
                </v-card-text>
              </v-card>
            </v-hover>
          </v-col>
        </v-row>
      </v-container>
      <v-menu v-model="isMenuOpen" location="center" :activator="menuActivator" :scrim="true">
        <v-card variant="flat" class="pa-0 ma-0">
          <v-card-title class="text-h5 text-center">
            {{ menuMove }}
          </v-card-title>
          <!-- <my-lazy class="video-card"> -->
          <div style="width: 50dvw; aspect-ratio: 1;">
            <video-player
              :src="`https://media.githubusercontent.com/media/stas-sl/salsa-moves/refs/heads/main/moves/${menuMove}.webm`"
              loop controls autoplay="muted" responsive :playbackRate="1" :enableSmoothSeeking="true" fill playsinline
              @ready="$event.target.player.userActive(false)" />
          </div>
          <!-- </my-lazy> -->
          <!-- <v-card-text v-if="file.description">
            <p v-if="file.description?.text" v-html="file.description?.text"></p>
            <p v-if="file.description?.related">
              <span class="text-subtitle-1">Related:</span> <span
                v-html="addMoveLinks(file.description?.related)"></span>
            </p>
          </v-card-text> -->
        </v-card>
      </v-menu>
    </v-main>
  </v-app>
</template>

<style scoped>
.video-card {
  aspect-ratio: 1;
}
</style>