<script setup>
const { loadMoves, loadMovesState } = useStore()
loadMoves()
await loadMovesState()
</script>
<template>
  <NuxtLayout>
    <NuxtLoadingIndicator />
    <NuxtPage />
  </NuxtLayout>
</template>
