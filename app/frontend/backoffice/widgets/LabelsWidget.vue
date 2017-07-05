<script>
  import Spinner from 'vue-simple-spinner';

  export default {
    data() {
      return {
        labels: [],
        loading: true
      };
    },
    mounted() {
      this.axios.get('/api/labels.json').then((response) => {
        this.loading = false;
        this.labels = response.data;
      });
    },
    components: { Spinner }
  }
</script>

<template lang="pug">
  div
    header.widget__header
      h1.widget__title Метки
    .widget__spinner(v-if="loading")
      spinner(size="huge")
    .widget__list(v-else)
      router-link.widget__item(v-for="label in labels" :to="'/bo/labels/' + label.id" :key="label.id") {{ label.name }}
</template>
