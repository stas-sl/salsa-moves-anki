<script setup>
import { useMagicKeys, whenever, onKeyStroke } from '@vueuse/core'

const { uid, moves, movesState, movesCounts,
  userSettings, updateMoveState } = useStore()

const config = useRuntimeConfig()
const currentMove = ref(null)
const answerVisible = ref(false)
const selectRandomMove = () => {
  answerVisible.value = false
  player?.value?.$el?.player?.pause()
  const candidateMoves = moves.value.filter(x =>
    userSettings.value.practiceOptions.states.includes(movesState.value[`move-${x.move}`]?.state || 'new'))
  currentMove.value = candidateMoves[Math.floor(Math.random() * candidateMoves.length)]
}

let isSeeking = false;

const { space } = useMagicKeys({
  passive: false,
  onEventFired(e) {
    if (e.code === 'Space' && e.type === 'keydown')
      e.preventDefault()
  },
})

const { comma, period, keyP, digit1, digit2, digit3 } = useMagicKeys()

function waitForSeeked() {
  return new Promise((resolve) => {
    player.value.$el.player.one('seeked', () => {
      resolve();
    });
  });
}

whenever(space, () => {
  if (answerVisible.value) {
    selectRandomMove()
  } else {
    answerVisible.value = true
    player?.value?.$el?.player?.play()
  }
})

whenever(keyP, () => {
  if (answerVisible.value) {
    const p = player.value.$el.player
    if (p.paused())
      p.play()
    else
      p.pause()
  }
})

whenever(digit1, () => {
  if (answerVisible.value) {
    updateMoveState([{ key: `move-${currentMove.value?.move}`, value: { state: 'new' } }])
  }
})
whenever(digit2, () => {
  if (answerVisible.value) {
    updateMoveState([{ key: `move-${currentMove.value?.move}`, value: { state: 'learning' } }])
  }
})
whenever(digit3, () => {
  if (answerVisible.value) {
    updateMoveState([{ key: `move-${currentMove.value?.move}`, value: { state: 'review' } }])
  }
})

onKeyStroke(',', async () => {
  if (answerVisible.value && !isSeeking) {
    isSeeking = true
    const p = player.value.$el.player
    p.pause()
    p.currentTime(p.currentTime() - 1 / 30)
    await waitForSeeked();
    isSeeking = false
  }
})

onKeyStroke('.', async () => {
  if (answerVisible.value && !isSeeking) {
    isSeeking = true
    const p = player.value.$el.player
    p.pause()
    p.currentTime(p.currentTime() + 1 / 30)
    await waitForSeeked();
    isSeeking = false
  }
})

onBeforeMount(() => {
  selectRandomMove()
})

const player = useTemplateRef('player')

</script>

<template>
  <v-app>
    <v-app-bar color="primary" density="compact">
      <template v-slot:prepend>
        <v-app-bar-nav-icon></v-app-bar-nav-icon>
      </template>
      <NuxtLink to="/"><v-icon color="white" icon="mdi-arrow-left"></v-icon></NuxtLink>
      <v-app-bar-title>Practice</v-app-bar-title>

      <template v-slot:append>
        <v-btn icon="mdi-dots-vertical"></v-btn>
      </template>
    </v-app-bar>
    <v-main>
      <v-container fluid class="pa-0 fill-height">
        <v-card class="fill-height d-flex flex-column w-100">
          <v-card-title class="pa-0 text-h2 text-center">{{ currentMove?.move }}
          </v-card-title>
          <v-card-item class="pa-0 flex-grow-1 video-card-item">
            <video-player :src="`${config.public.mediaUrl}${currentMove?.name}`" :playbackRate="1"
              :enableSmoothSeeking="true" playsinline fill loop muted preload="auto" responsive ref="player"
              @loadedmetadata="$event.target.player.userActive(false); $event.target.player.controls(true);"
              v-show="answerVisible" />
          </v-card-item>
          <v-card-actions class="justify-center pa-0">
            <v-btn @click="answerVisible = true; player?.$el?.player?.play()" color="primary" class="my-2"
              v-if="!answerVisible" variant="flat">Show
              answer<span v-if="$device.isDesktop">&nbsp;(space)</span></v-btn>
            <v-menu location="top center" transition="slide-y-transition" :offset="2" v-if="answerVisible">
              <template v-slot:activator="{ props }">
                <v-chip v-bind="props"
                  :color="{ new: 'primary', undefined: 'primary', learning: 'deep-purple-lighten-1', review: 'success' }[movesState[`move-${currentMove?.move}`]?.state]"
                  variant="flat" density="compact">
                  {{ movesState[`move-${currentMove?.move}`]?.state || "new" }}
                </v-chip>
              </template>

              <v-card style="background-color: rgba(var(--v-theme-surface), 0.8)">
                <v-chip-group variant="flat" direction="vertical"
                  @update:modelValue="updateMoveState([{ key: `move-${currentMove?.move}`, value: { state: $event } }])">
                  <v-chip class="bg-primary mx-2" value="new" density="compact">
                    new (1)
                  </v-chip>
                  <v-chip class="bg-deep-purple-lighten-1 mx-2" value="learning" density="compact">
                    learning (2)
                  </v-chip>
                  <v-chip class="bg-success mx-2" value="review" density="compact">
                    review (3)
                  </v-chip>
                </v-chip-group>
              </v-card>

            </v-menu>

            <v-btn @click="selectRandomMove()" color="primary" class="my-2" v-if="answerVisible"
              variant="flat">Next<span v-if="$device.isDesktop">&nbsp;(space)</span></v-btn>
          </v-card-actions>
        </v-card>
      </v-container>
    </v-main>
  </v-app>
</template>

<style>
.video-card-item .v-card-item__content {
  align-self: stretch;
  display: flex;
  flex-direction: column;
}

.video-js {
  background-color: unset;
}
</style>