<template>
  <div class="editor" :class="generalClasses">
    <toolbar class="editor__toolbar" :state="editorState" v-on:stateChanging="changeState">
      <div class="toolbar__group toolbar__spacer" slot="actions">
        <slot name="actions" />
      </div>
    </toolbar>
    <div class="editor__workspace" :class='workspaceClasses'>
      <codemirror
        :value='code'
        @input='updateValue($event)'
        @scroll='syncScroll'
        ref='editor'
        :options='codeMirrorOptions'
      />
      <div
        class="editor__preview"
        v-html='html'
        ref='preview'
      />
    </div>
    <div class="editor__status-bar">
      <div>Символов: {{ stats.chars }}, слов: {{ stats.words }}, абзацев: {{ stats.lines }}</div>
      <slot name="status" />
    </div>
  </div>
</template>

<script>

  // Mixins
  import SyncScroll from './mixins/SyncScroll';
  import CodeMirror from './mixins/CodeMirror';
  import Markdown from './mixins/Markdown';

  // Components
  import Toolbar from './Toolbar.vue';

  export default {
    props: {
      value: {
        required: true
      },
      placeholder: {
        required: false,
        type: String
      },
      isFullscreen: {
        required: false,
        type: Boolean,
        default: false
      },
      isPreviewHidden: {
        required: false,
        type: Boolean,
        default: false
      },
      isInputHidden: {
        required: false,
        type: Boolean,
        default: false
      },
    },
    data() {
      return {
        code: null,
        watched: false,
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
      changeState(payload) {
        this.editorState = Object.assign({}, this.editorState, payload);
      },
      calcStats() {
        if (this.code === null) return;
        this.stats.chars = this.code.length;
        this.stats.words = this.code.split(/\S+/g).length - 1;
        this.stats.lines = this.code.split(/\n{2,}/g).length;
      },
    },
    mounted() {
      this.calcStats();
      this.editorState.isFullscreen = this.isFullscreen;
      this.editorState.isPreviewHidden = this.isPreviewHidden;
      this.editorState.isInputHidden = this.isInputHidden;
    },
    watch: {
      value() {
        this.code = this.value;
      }
    },
    mixins: [SyncScroll, CodeMirror, Markdown],
    components: {Toolbar}
  }
</script>
