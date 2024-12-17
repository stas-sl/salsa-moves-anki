<script setup>
const config = useRuntimeConfig()
</script>

<template>
  <div class="c1">
    <video :src="`${config.public.mediaUrl}s043.webm`" loop fill controls />
    <!-- <video-player :src="`${config.public.mediaUrl}s002.webm`" loop fill controls /> -->
  </div>
</template>

<style scoped>
.c1 {
    /* width: 100%; */
    height: 100dvh;
    width: 100dvw;
    /* display: flex; */
    justify-content: center;
    /* align-items: right; */
    /* justify-items: right; */
    background-color: blue;
    /* position: relative; */
}

.video {
  width: 100%;
  object-fit: contain;
  height: 100%;
  aspect-ratio: 9/16;
}
</style>