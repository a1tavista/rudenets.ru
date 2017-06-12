<script>
  import _ from 'lodash';
  import marked from 'marked';
  import SyncScrollMixin from './editor/SyncScrollMixin';
  import Toolbar from './editor/Toolbar.vue';

  export default {
    data() {
      return {
        markdown: "",
        editorState: {
          isFullscreen: false,
          isPreviewHidden: false
        },
        stats: {
          chars: 0,
          words: 0,
          lines: 0
        }
      }
    },
    computed: {
      html() {
        return this.markdown ? marked(this.markdown, {sanitize: true}) : "";
      }
    },
    methods: {
      updateValue(value) {
        this.markdown = value;
        this.calcStats();
        this.$emit('input', value);
      },
      calcStats() {
        this.stats.chars = this.markdown.length;
        this.stats.words = this.markdown.split(/\S+/g).length - 1;
        this.stats.lines = this.markdown.replace(/[^\n]/g, "").length + 1;
      }
    },
    mounted() {
      marked.setOptions({smartLists: true, smartypants: true});
      this.markdown = this.value;
      this.calcStats();
      this.$on('stateChanging', function(payload) {
        debugger;
        this.editorState[payload.option] = payload.value;
      });
    },
    mixins: [SyncScrollMixin],
    components: {Toolbar},
    props: ["value", "placeholder"]
  }
</script>

<template lang="pug">
  .editor(v-bind:class="{ 'editor--fullscreen': editorState.isFullscreen }")
    toolbar.editor__toolbar(:state="editorState")
    .editor__workspace
      textarea.editor__text-input(@scroll="syncScroll" @input="updateValue($event.target.value)" :placeholder="placeholder" ref="editor") {{ value }}
      .editor__preview(v-html="html" ref="preview" v-bind:class="{ 'editor__preview--hidden': editorState.isPreviewHidden }")
    .editor__status-bar Символов: {{ stats.chars }}, слов: {{ stats.words }}, строк: {{ stats.lines }}
</template>
