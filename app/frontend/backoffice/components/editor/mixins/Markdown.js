import marked from 'marked';
import highlight from 'highlight.js';

export default {
  mounted() {
    marked.setOptions({
      smartLists: true,
      smartypants: true,
      highlight: function (code) {
        return highlight.highlightAuto(code).value;
      }
    });
  },
  computed: {
    html() {
      return this.code ? marked(this.code) : '';
    },
  }
}
