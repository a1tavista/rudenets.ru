export default {
  data() {
    return {
      editorScrollHeight: -1
    }
  },
  methods: {
    syncScroll($event) {
      let element = $event.srcElement ? $event.srcElement : $event.target;
      let ratio = element.scrollTop / (element.scrollHeight - element.offsetHeight);

      if (this.editorScrollHeight >= 0 && (element.scrollHeight !== this.editorScrollHeight) && ((element.scrollHeight - element.offsetHeight - element.scrollTop) <= 30)) {
        this.$refs.editor.scrollTop = element.scrollHeight - element.offsetHeight;
        ratio = 1;
      }

      this.editorScrollHeight = element.scrollHeight;

      if (this.$refs.preview.scrollHeight > this.$refs.preview.offsetHeight) {
        this.$refs.preview.scrollTop = (this.$refs.preview.scrollHeight - this.$refs.preview.offsetHeight) * ratio;
      }
    }
  }
}
