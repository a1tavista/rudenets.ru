<script>
  import _ from 'lodash';
  import marked from 'marked';

  export default {
    data() {
      return {
        text: ""
      }
    },
    computed: {
      compiledMarkdown: function () {
        if (this.text) {
          return marked(this.text, {sanitize: true});
        } else {
          return "";
        }
      }
    },
    methods: {
      update: _.debounce(function (e) {
        this.text = e.target.value
      }, 300)
    },
    mounted() {
      marked.setOptions({
        smartLists: true,
        smartypants: true
      });
      this.text = this.mdText;
    },
    props: ["mdText"]
  }
</script>

<template lang="pug">
  div
    textarea(v-model="text")
    div(v-html="compiledMarkdown")
</template>
