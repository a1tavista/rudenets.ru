<script>
  import _ from 'lodash';
  import marked from 'marked';
  import SyncScrollMixin from './SyncScrollMixin';
  import Toolbar from './Toolbar.vue';

  export default {
    data() {
      return {
        markdown: "",
        editorState: {
          isFullscreen: false,
          isPreviewHidden: false,
          isInputHidden: false
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
        return this.markdown ? marked(this.markdown, {sanitize: true}) : '';
      },
      generalClasses() {
        return {
          "editor--fullscreen": this.editorState.isFullscreen
        };
      },
      workspaceClasses() {
        return {
          "editor__workspace--preview-hidden": this.editorState.isPreviewHidden,
          "editor__workspace--input-hidden": this.editorState.isInputHidden
        };
      }
    },
    methods: {
      updateValue(value) {
        this.markdown = value;
        this.calcStats();
        this.$emit('input', value);
      },
      changeState(payload) {
        this.editorState = Object.assign({}, this.editorState, payload);
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
    },
    watch: {
      value() {
        this.markdown = this.value;
      }
    },
    mixins: [SyncScrollMixin],
    components: {Toolbar},
    props: ['value', 'placeholder']
  }
</script>

<template lang="pug">
  .editor(:class='generalClasses')
    toolbar.editor__toolbar(:state="editorState" v-on:stateChanging="changeState")
      .toolbar__group(slot="actions")
        slot(name="actions")
    .editor__workspace(:class='workspaceClasses')
      textarea.editor__text-input(@scroll='syncScroll' v-on:input='updateValue($event.target.value)' v-bind:placeholder='placeholder' ref='editor') {{ markdown }}
      .editor__preview(v-html='html' ref='preview')
    .editor__status-bar
      div Символов: {{ stats.chars }}, слов: {{ stats.words }}, строк: {{ stats.lines }}
      slot(name="status")
</template>

