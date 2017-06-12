<script>
  export default {
    data() {
      return {
        posts: []
      };
    },
    mounted() {
      this.axios.get('/api/posts.json').then((response) => {
        this.posts = response.data;
      });
    }
  }
</script>

<template lang="pug">
  div
    header.widget__header
      h1.widget__title Заметки
    .widget__list
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
