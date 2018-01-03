export default {
  data() {
    return {
      editorScrollHeight: -1
    }
  },
  methods: {
    syncScroll() {
      const element = this.$refs.editor.codemirror.getScrollInfo();
      let ratio = element.top / (element.height - element.clientHeight);

      // if (this.editorScrollHeight >= 0 && (element.height !== this.editorScrollHeight) && ((element.height - element.clientHeight - element.top) <= 30)) {
      //   this.$refs.editor.codemirror.scrollTo(null, element.height - element.clientHeight);
      //   ratio = 1;
      // }

      this.editorScrollHeight = element.height;

      console.log((element.height - element.top), element.clientHeight);
      if((element.height - element.top) === element.clientHeight) {
        const self = this;
        setTimeout(function() {
          self.$refs.preview.scrollTop = self.$refs.preview.scrollHeight;
        }, 500);
        return;
      }

      if (this.$refs.preview.scrollHeight >= this.$refs.preview.offsetHeight) {
        this.$refs.preview.scrollTop = (this.$refs.preview.scrollHeight - this.$refs.preview.offsetHeight) * ratio;
      }
    }
  }
}
