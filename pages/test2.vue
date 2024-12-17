<script setup>
const config = useRuntimeConfig()
</script>

<template>
  <div class="c3">
    <div class="c1"></div>
    <div class="c4">
      <!-- <div class="c5"> -->
<!-- asd -->
      <!-- </div> -->
      <video-player :src="`${config.public.mediaUrl}s002.webm`" loop fill />
    </div>
    <div class="c2"></div>
  </div>
</template>

<style scoped>
.c1 {
  height: 100px;
  background-color: bisque;
}

.c2 {
  height: 100px;
  background-color: brown;
}

.c3 {
  display: flex;
  flex-direction: column;
  min-height: 100dvh;
  background-color: red;
}

.c4 {
  flex-grow: 1;
  display: flex;
  /* position: relative; */
  background-color: blue;
  /* max-height: 100%; */
  /* height: 200px; */
}

/* .c5 {
  height: 100%;
  width: 100%;
  position: absolute;
  background-color: yellow;
} */

.video-js {
  max-height: 100%;
  flex-grow: 1;
  /* position: absolute; */
  height: auto;
  /* height: 100%; */
  /* width: 100%; */
  /* object-fit: contain; */
  /* aspect-ratio: 9/16 !important; */
  /* background-color: red; */
}

.vjs-tech {
  /* object-fit: contain; */
  /* aspect-ratio: 9/16; */
}
</style>