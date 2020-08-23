<template>
  <div class="location">
    <h1 class="location-timezone">{{ locationTimezone }}</h1>
    <img class="wheather-icon" :src="wheatherIconSrc">
  </div>
</template>

<script>
export default {
  props: {
    locationTimezone: String,
    wheatherIconSrc: String
  }
}
</script>

<style>
.location {
    height: 30vh;
    width: 50%;
    display: flex;
    justify-content: space-around;
    align-items: center;
}
</style>
