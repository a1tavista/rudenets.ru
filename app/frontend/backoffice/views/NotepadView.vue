<template lang="pug">
  .note-editing-form
    .note-editing-form__wrapper
      markdown-editor.editor--x-large.editor--single(
        :value="notepad.text"
        @input="update('text', $event)"
        :is-preview-hidden="true"
      )
        template(slot="actions")
          button
            i.material-icons add
          button
            i.material-icons edit
          treeselect(
            :loadRootOptions='getTree'
            :show-count="true"
            v-model='currentID'
            :multiple='false'
            :clearable='false'
          )

</template>

<script>
  import MarkdownEditor from '../components/editor/MarkdownEditor.vue';
  import Treeselect from '@riophae/vue-treeselect'
  import {mapActions, mapGetters, mapState} from "vuex";

  export default {
    data() {
      return {
        currentID: null,

      }
    },

    methods: {
      ...mapActions([
        'fetchNotepad',
        'fetchNotepads',
        'fetchCurrentNotepad',
        'updateNotepadField',
      ]),
      update(field, value) {
        this.updateNotepadField({ field, value });
      },
      getTree(callback) {
        return callback(null, this.tree);
      }
    },

    computed: {
      ...mapGetters({
        notepad: 'getCurrentNotepad',
        notepads: 'getNotepads',
        tree: 'getNotepadsTree'
      }),
      savingInProgress() {
        return this.$store.state.backofficeContent.saving.notepad;
      }
    },

    mounted() {
      this.fetchNotepads();
      this.fetchCurrentNotepad();
    },

    watch: {
      currentID(to, from) {
        if(this.currentID)
          this.fetchNotepad({ id: this.currentID });
      },
      'notepad.id'() {
        this.currentID = this.notepad.id;
      }
    },

    components: {MarkdownEditor, Treeselect}
  }
</script>

<style src="@riophae/vue-treeselect/dist/vue-treeselect.min.css"></style>

<style>
  .vue-treeselect {
    display: inline-block;
  }
  .vue-treeselect__control {
    width: 600px;
    z-index: 500;
  }

  .vue-treeselect__menu {
    z-index: 500;
  }
</style>
