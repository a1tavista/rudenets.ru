<script>
  import Spinner from 'vue-simple-spinner';

  export default {
    data() {
      return {
        posts: [],
        loading: true
      };
    },
    mounted() {
      this.axios.get('/api/posts/published.json').then((response) => {
        this.posts = response.data;
        this.loading = false;
      });
    },
    components: { Spinner }
  }
</script>

<template lang="pug">
  div
    header.widget__header
      h1.widget__title Опубликованные
    .widget__spinner(v-if="loading")
      spinner(size="huge")
    .widget__list(v-else)
      router-link.widget__item(v-for="post in posts" :to="'/bo/notes/' + post.id" :key="post.id")
        h6 {{ post.title }}
        p(v-html="post.summary" v-show="post.summary")
</template>

<style lang="scss">
  .widget__item {
    h6, p {
      margin-bottom: 0;
    }

    p {
      margin-top: 0.4em;
    }
  }
</style>
