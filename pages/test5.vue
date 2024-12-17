<script setup>
const config = useRuntimeConfig()
</script>

<template>
  <div class="container">
    <video :src="`${config.public.mediaUrl}s002.webm`" loop controls />
  </div>
</template>

<style>
.container {
  height: 100dvh;
  width: 100dvw;
}

video {
  max-height: 100%;
  width: 100%;
  /* object-fit: contain; */
  /* aspect-ratio: 9/16; */
}
</style>
