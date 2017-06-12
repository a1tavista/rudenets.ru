<script>
  export default {
    data() {
      return {
        labels: []
      };
    },
    mounted() {
      this.axios.get('/api/labels.json').then((response) => {
        this.labels = response.data;
      });
    }
  }
</script>

<template lang="pug">
  div
    header.widget__header
      h1.widget__title Метки
    .widget__list
      router-link.widget__item(v-for="label in labels" :to="'/bo/labels/' + label.id" :key="label.id") {{ label.name }}
</template>
