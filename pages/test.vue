<template>
  <div class="c1">
    <div style="background-color: blue;">1</div>
    <div style="background-color: green; grid-area: content;">2</div>
    <div style="background-color: yellow;">3</div>
  </div>
</template>

<style scoped>
.c1 {
    align-items: center;
    display: grid;
    flex: none;
    grid-template-areas: "prepend content append";
    grid-template-columns: max-content auto max-content;
    padding: 0.625rem 1rem;
    height: 200px;
    background-color: red;
    align-items: stretch;
}
</style>