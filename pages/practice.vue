<script setup>
import { useMagicKeys, whenever } from '@vueuse/core'

const { uid, moves, movesState, movesCounts,
  userSettings, updateMoveState } = useStore()

const config = useRuntimeConfig()
const currentMove = ref(null)
const answerVisible = ref(false)
const selectRandomMove = () => {
  answerVisible.value = false
  const candidateMoves = moves.value.filter(x =>
    userSettings.value.practiceOptions.states.includes(movesState.value[`move-${x.move}`]?.state || 'new'))
  currentMove.value = candidateMoves[Math.floor(Math.random() * candidateMoves.length)]
}

const { space } = useMagicKeys({
  passive: false,
  onEventFired(e) {
    if (e.code === 'Space' && e.type === 'keydown')
      e.preventDefault()
  },
})
whenever(space, () => {
  if (answerVisible.value) {
    selectRandomMove()
  } else {
    answerVisible.value = true
  }
})

onBeforeMount(() => {
  selectRandomMove()
})

const v = useTemplateRef('v')

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
          <v-card-title class="pa-0 text-h2 text-center">{{ currentMove?.move }}</v-card-title>
          <v-card-item class="pa-0 flex-grow-1 video-card-item">
            <!-- <div class="flex-grow-1"> -->
              <video-player :src="`${config.public.mediaUrl}${currentMove?.name}`" loop controls autoplay="muted"
                responsive :playbackRate="1" :enableSmoothSeeking="true" playsinline fill
                @loadedmetadata1="$event.target.player.userActive(false); v.style.aspectRatio = `${$event.target.player.videoWidth()} / ${$event.target.player.videoHeight()}`" v-if="answerVisible" />
            <!-- </div> -->
          </v-card-item>
          <v-card-actions class="justify-center pa-0">
            <v-btn @click="answerVisible = true" color="primary" class="my-2" v-if="!answerVisible" variant="flat">Show
              answer</v-btn>
            <v-btn @click="selectRandomMove()" color="primary" class="my-2" v-if="answerVisible"
              variant="flat">Next</v-btn>
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
</style>