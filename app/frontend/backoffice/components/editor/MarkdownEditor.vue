<script>
  import _ from 'lodash';
  import marked from 'marked';
  import SyncScrollMixin from './SyncScrollMixin';
  import Toolbar from './Toolbar.vue';
  import 'codemirror/mode/markdown/markdown.js'
  import 'codemirror/addon/edit/continuelist.js'
  import 'codemirror/addon/fold/foldcode.js'
  import 'codemirror/addon/fold/foldgutter.js'
  import 'codemirror/addon/fold/markdown-fold.js'

  export default {
    data() {
      return {
        code: null,
        watched: false,
        editorState: {
          isFullscreen: false,
          isPreviewHidden: false,
          isInputHidden: false
        },
        codeMirrorOptions: {
          mode: 'text/x-markdown',
          theme: 'elegant',
          extraKeys: {"Enter": "newlineAndIndentContinueMarkdownList"},
          lineWrapping: true,
          tabSize: 2,
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
        return this.code ? marked(this.code, {sanitize: true}) : '';
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
        this.code = value;
        this.calcStats();
        this.$emit('input', this.code);
      },
      kek(event) {
        console.log(this.$refs.preview.scrollHeight, this.$refs.preview.offsetHeight, this.$refs.preview.scrollTop);
      },
      changeState(payload) {
        this.editorState = Object.assign({}, this.editorState, payload);
      },
      calcStats() {
        if(this.code === null) return;
        this.stats.chars = this.code.length;
        this.stats.words = this.code.split(/\S+/g).length - 1;
        this.stats.lines = this.code.replace(/[^\n\n]/g, "").length + 1;
      }
    },
    mounted() {
      marked.setOptions({smartLists: true, smartypants: true});
      this.calcStats();
    },
    watch: {
      value() {
        this.code = this.value;
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
      codemirror(
        :value='code'
        @input='updateValue($event)'
        @viewportChange='syncScroll'
        ref='editor'
        :options='codeMirrorOptions'
      )
      .editor__preview(v-html='html' ref='preview' @scroll='kek')
    .editor__status-bar
      div Символов: {{ stats.chars }}, слов: {{ stats.words }}, абзацев: {{ stats.lines }}
      slot(name="status")
</template>

