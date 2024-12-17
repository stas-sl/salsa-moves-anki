<script setup>
const config = useRuntimeConfig()
</script>

<template>
  <div class="grid-container">
    <div class="area top">Top</div>
    <div class="area bottom">Bottom</div>
    <div class="area left">Left</div>
    <div class="area right">Right</div>
    <div class="center">
      <video-player :src="`${config.public.mediaUrl}s043.webm`" loop controls />
       <!-- <img src="https://placehold.co/1200x600"/> -->
    </div>
  </div>
</template>

<style scoped>
.grid-container {
  width: 100vw;
  height: 100vh;
  display: grid;
  grid-template-rows: 100px auto 100px;
  grid-template-columns: 100px auto 100px;
  grid-template-areas:
    "top-left top top-right"
    "left center right"
    "bottom-left bottom bottom-right";
}

.area {
  background-color: blue;
}

.top {
  grid-area: top;
}

.bottom {
  grid-area: bottom;
}

.left {
  grid-area: left;
}

.right {
  grid-area: right;
}

.center {
  grid-area: center;
  display: flex;
  justify-content: center;
  align-items: center;
  background-color: green;
  /* contain: size; */
  /* height: 100%; */
  /* width: 100%; */
  position: relative;
}

img, .video-js {
  max-width: 100%;
  max-height: 100%;
  /* height: auto !important; */
  /* width: auto !important; */
  position: absolute;
  display: block;
  /* max-width: 100%; */
  /* height: 100%; */
  /* width: 100%; */
  /* height: min(auto, 100%); */
  /* aspect-ratio: 9/16; */
  /* max-width: 100%; */
  /* max-height: 100%; */

  /* object-fit: contain; */
  /* display: block; Removes any inline spacing */
}

video {
  /* height: 100%; */
  /* width: 100%; */
  /* max-width: 100%; */
  /* max-height: 100%; */
  /* position: absolute; */
  /* display: block; */
}
</style>
