<script>
  import _ from 'lodash';
  import marked from 'marked';

  export default {
    data() {
      return {
        input: "",
        isPreview: false
      }
    },
    computed: {
      compiledMarkdown: function () {
        if (this.input) {
          return marked(this.input, {sanitize: true});
        } else {
          return "";
        }
      }
    },
    methods: {
      update: _.debounce(function (e) {
        this.input = e.target.value
      }, 300)
    },
    mounted() {
      marked.setOptions({
        smartLists: true,
        smartypants: true
      });
      this.input = this.mdText;
    },
    props: ["mdText"]
  }
</script>

<template>
  <div>
    <button @click="isPreview = !isPreview"></button>
    <article class="post">
      <div class="post-form">
        <div class="post__content post-form__preview" v-html="compiledMarkdown" v-show="isPreview"></div>
        <textarea class="post-form__editor" v-model="input" v-show="!isPreview"></textarea>
      </div>
    </article>
  </div>
</template>
