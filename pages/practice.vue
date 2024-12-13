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
    userSettings.value.practiceOptions.states.includes(movesState.value[`move-${x.move}`]?.state || 'new') )
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

</script>

<template>
  <v-app>
    <v-main>
      <v-container fluid>
        <NuxtLink to="/"><v-icon icon="mdi-home"></v-icon></NuxtLink>
        <h1>Practice</h1>
        <h2>{{ currentMove?.move }}</h2>
        
        <video-player :src="`${config.public.mediaUrl}${currentMove?.name}`" loop controls autoplay="muted" responsive
                  :playbackRate="1" :enableSmoothSeeking="true" :width="500" :height="500" playsinline
                  @ready="$event.target.player.userActive(false)" v-if="answerVisible" />
        <v-btn @click="answerVisible = true" color="primary" class="my-4" v-if="!answerVisible">Show answer</v-btn>
        <v-btn @click="selectRandomMove()" color="primary" class="my-4" v-if="answerVisible">Next</v-btn>
      </v-container>
    </v-main>
  </v-app>
</template>

<style>
.video-js {
  background-color: var(--v-theme-background);
}
</style>