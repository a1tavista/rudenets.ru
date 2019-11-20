<template>
  <div ref='editor' />
</template>

<script>
import EditorJS from '@editorjs/editorjs';
import Header from '@editorjs/header';
import RawHtml from '@editorjs/raw';
import Embed from '@editorjs/embed';
import List from '@editorjs/list';


export default {
  data: () => ({
    editor: null,
  }),
  mounted() {
    this.editor = new EditorJS({
      holder: this.$refs.editor,
      tools: {
        header: Header,
        html: RawHtml,
        embed: Embed,
        list: List
      }
    });
  }
}
</script>
