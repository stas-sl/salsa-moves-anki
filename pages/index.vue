<script setup>
import { ref, h, Fragment } from "vue"
import { VChip } from "vuetify/components"

const filesToDisplay = ref([])
const videoCount = ref(20)
const isMenuOpen = ref(false)
const menuActivator = ref(null)
const menuMove = ref('')
const config = useRuntimeConfig()

const { uid, moves, movesState, movesCounts,
  userSettings, updateMoveState } = useStore()

function reloadVideos() {
  filesToDisplay.value = [...moves.value].sort(() => 0.5 - Math.random()).slice(0, videoCount.value)
}

function reloadAll() {
  filesToDisplay.value = moves.value
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
        size: 'default', variant: 'flat', link: true, class: 'mx-1 mt-n1', density: 'compact',
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

        <!-- <v-btn variant="elevated" @click="reloadVideos">Load some random videos</v-btn>

        <br>
        <br>
        <v-text-field label="Num" variant="outlined" type="number" v-model="videoCount"></v-text-field>

        <v-btn variant="elevated" @click="reloadAll">Load all</v-btn>
        <v-btn variant="elevated" @click="menuActivator = $event.target; isMenuOpen = true;">Show dialog</v-btn>
        <br>
        <br> -->
        <p class="pb-4">
          Total: {{ movesCounts.total }}<br>
          New: {{ movesCounts.new }}<br>
          Learning: {{ movesCounts.learning }}<br>
          Review: {{ movesCounts.review }}
        </p>
        <v-row>
          <v-col cols="4">
            <v-card variant="outlined">
              <v-card-title>
                Practice
              </v-card-title>
              <v-card-item>
                <div class="d-flex align-center">
                  State:
                  <v-chip-group variant="flat" class="ml-2" multiple mandatory
                    v-model="userSettings.practiceOptions.states"
                    @update:modelValue="updateMoveState([{ key: `settings`, value: userSettings }])">
                    <!-- @update:modelValue="updateMoveState([{ key: `settings`, value: _merge(userSettings, { practiceOptions: { states: $event } }) }]); console.log(userSettings)"> -->
                    <v-chip color="primary" value="new" density="compact" filter>
                      new({{ movesCounts.new }})
                    </v-chip>
                    <v-chip color="deep-purple-lighten-1" value="learning" density="compact" filter>
                      learning({{ movesCounts.learning }})
                    </v-chip>
                    <v-chip color="success" value="review" density="compact" filter>
                      review({{ movesCounts.review }})
                    </v-chip>
                  </v-chip-group>
                </div>
              </v-card-item>
              <v-card-actions class="justify-center">
                <v-btn to="/practice" color="primary" variant="flat">Go</v-btn>
              </v-card-actions>
            </v-card>
          </v-col>
        </v-row>
        <v-row>
          <v-col class="pa-2 v-col-12 v-col-sm-6 v-col-md-4 v-col-lg-3 v-col-xl-2" v-for="file in filesToDisplay"
            :key="file.sha">
            <v-card variant="flat" class="pa-0 ma-0">
              <v-card-title class="text-h5 text-center" :id="file.move">
                {{ file.move }}
              </v-card-title>
              <my-lazy class="video-card">
                <!-- <video :src="`${config.public.mediaUrl}${file.name}`" loop controls autoplay playsinline/> -->
                <video-player :src="`${config.public.mediaUrl}${file.name}`" loop controls autoplay="muted" responsive
                  :playbackRate="1" :enableSmoothSeeking="true" fill playsinline
                  @ready="$event.target.player.userActive(false);" />
              </my-lazy>
              <v-card-text v-if="file.description">
                <my-lazy>
                  <p v-if="file.description?.text" v-html="file.description?.text"></p>
                  <p v-if="file.description?.related">
                    <span class="text-subtitle-1">Related:</span>
                    <component :is="renderMoveRefs(file.description?.related)" />
                  </p>
                </my-lazy>
              </v-card-text>

              <v-card-actions>
                <my-lazy>
                  <v-menu location="right center" transition="slide-x-transition" :offset="6">
                    <template v-slot:activator="{ props }">
                      <v-chip v-bind="props"
                        :color="{ new: 'primary', undefined: 'primary', learning: 'deep-purple-lighten-1', review: 'success' }[movesState[`move-${file.move}`]?.state]"
                        variant="flat" density="compact">
                        {{ movesState[`move-${file.move}`]?.state || "new" }}
                      </v-chip>
                    </template>

                    <v-card>
                      <v-chip-group variant="flat"
                        @update:modelValue="updateMoveState([{ key: `move-${file.move}`, value: { state: $event } }])">
                        <v-chip class="bg-primary" value="new" density="compact">
                          new
                        </v-chip>
                        <v-chip class="bg-deep-purple-lighten-1" value="learning" density="compact">
                          learning
                        </v-chip>
                        <v-chip class="bg-success" value="review" density="compact">
                          review
                        </v-chip>
                      </v-chip-group>
                    </v-card>

                  </v-menu>
                </my-lazy>
              </v-card-actions>
            </v-card>
          </v-col>
        </v-row>
      </v-container>
      <v-menu v-model="isMenuOpen" location="center" :activator="menuActivator" :scrim="true">
        <v-card variant="flat" class="pa-0 ma-0">
          <v-card-title class="text-h5 text-center">
            {{ menuMove }}
          </v-card-title>
          <div style="width: 50dvw; aspect-ratio: 1;">
            <video-player :src="`${config.public.mediaUrl}${menuMove}.webm`" loop controls autoplay="muted" responsive
              :playbackRate="1" :enableSmoothSeeking="true" fill playsinline
              @ready="$event.target.player.userActive(false)" />
          </div>
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

<style>
.vjs-loading-spinner,
.vjs-big-play-button {
  display: none !important;
}
</style>