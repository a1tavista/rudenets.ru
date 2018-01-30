import 'codemirror/mode/gfm/gfm.js'
import 'codemirror/addon/edit/continuelist.js'
import 'codemirror/addon/fold/foldcode.js'
import 'codemirror/addon/fold/foldgutter.js'
import 'codemirror/addon/fold/markdown-fold.js'

const headerKeyMapping = (level) => {
  return {
    [`Ctrl-Alt-${level}`]: function (cm) {
      let s = cm.getSelection();
      let prefix = '#'.repeat(level) + ' ';
      let t = s.slice(0, level + 1) === prefix;
      cm.replaceSelection(t ? s.slice(level + 1) : prefix + s, 'around');
    }
  }
};

const surroundSelectionKeyMapping = (key, begin, end) => {
  if(!end) { end = begin }
  return {
    [key]: (cm) => {
      const s = cm.getSelection();
      let t = s.slice(0, begin.length) === begin && s.slice(-end.length) === end;
      cm.replaceSelection(t ? s.slice(begin.length, -end.length) : begin + s + end, 'around');
    }
  }
};

export default {
  data: () => {
    return {
      codeMirrorOptions: {
        mode: 'gfm',
        gitHubSpice: false,
        taskLists: true,
        strikethrough: true,
        emoji: false,
        theme: 'elegant',
        extraKeys: {
          "Enter": "newlineAndIndentContinueMarkdownList"
        },
        lineWrapping: true,
        tabSize: 2,
      }
    }
  },
  methods: {
    setKeyMapping(editor) {
      const self = this;

      editor.addKeyMap({
        ...surroundSelectionKeyMapping('Ctrl-I', '*'),
        ...surroundSelectionKeyMapping('Ctrl-B', '**'),
        ...surroundSelectionKeyMapping('Ctrl-K', '```\n', '\n```'),
        ...headerKeyMapping(1),
        ...headerKeyMapping(2),
        ...headerKeyMapping(3),
        ...headerKeyMapping(4),
        ...headerKeyMapping(5),
        ...headerKeyMapping(6),
        'Ctrl-Alt-P': function (cm) {
          self.editorState.isPreviewHidden = !self.editorState.isPreviewHidden;
        },
        'Ctrl-Alt-F': function (cm) {
          self.editorState.isFullscreen = !self.editorState.isFullscreen;
        },
      });
    }
  },
  mounted() {
    this.setKeyMapping(this.$refs.editor.codemirror);
  }
}
