<template lang="pug">
  .note-editing-form
    .note-editing-form__wrapper
      markdown-editor.editor--x-large.editor--single(
        :value="notepad.text"
        @input="update('text', $event)"
        :is-preview-hidden="true"
      )
        select(slot="actions" v-model="currentID")
          option(v-for="option in notepads" :value="option.id") {{ option.name }}

</template>

<script>
  import MarkdownEditor from '../components/editor/MarkdownEditor.vue';
  import {mapActions, mapGetters, mapState} from "vuex";

  export default {
    data() {
      return {
        currentID: null
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
      }
    },

    computed: {
      ...mapGetters({
        notepad: 'getCurrentNotepad',
        notepads: 'getNotepads',
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
        this.fetchNotepad({ id: this.currentID });
      },
      'notepad.id'() {
        this.currentID = this.notepad.id;
      }
    },

    components: {MarkdownEditor}
  }
</script>
