<script setup>
function initUID() {
  const uid = useState("uid");
  if (!localStorage.getItem("uid")) {
    localStorage.setItem("uid", crypto.randomUUID());
  }
  uid.value = localStorage.getItem("uid");
}

initUID();
</script>

<template>
  <NuxtRouteAnnouncer />
  <NuxtLayout>
    <NuxtLoadingIndicator />
    <NuxtPage />
  </NuxtLayout>
</template>
