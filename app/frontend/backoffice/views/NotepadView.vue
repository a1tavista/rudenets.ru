<template lang="pug">
  .note-editing-form
    .note-editing-form__wrapper
      markdown-editor.editor--x-large.editor--single(
        :value="notepad.text"
        @input="update('text', $event)"
        :is-preview-hidden="true"
      )
        template.toolbar__spacer(slot="actions")
          .toolbar__group(v-show='!showEditForm && !showAddForm')
            .toolbar__group
              button(@click="showAddNoteForm")
                i.material-icons add
              button(@click="showEditNoteForm")
                i.material-icons edit
            .toolbar__spacer
            treeselect.treeselect--fullwidth(
              :loadRootOptions='getTree'
              :show-count="true"
              v-model='currentID'
              :multiple='false'
              :clearable='false'
              :autofocus='true'
              ref="ts0"
            )
            .toolbar__spacer

          .toolbar__group(v-show='showAddForm')
            input.toolbar__input(v-model='newNotepad.name' placeholder='ke')
            treeselect(
              :loadRootOptions='getTree'
              :show-count="true"
              v-model='newNotepad.ancestry'
              :multiple='false'
              ref="ts1"
            )
            button(@click="closeForm")
              i.material-icons done

          .toolbar__group(v-show='showEditForm')
            input.toolbar__input(:value="notepad.name" @input="update('name', $event.target.value)")
            treeselect(
              :loadRootOptions='getTree'
              :show-count="true"
              :value='notepad.ancestry'
              @input="update('ancestry', $event)"
              :multiple='false'
              ref="ts2"
            )
            button(@click="closeForm")
              i.material-icons done



</template>

<script>
  import MarkdownEditor from '../components/editor/MarkdownEditor.vue';
  import Treeselect from '@riophae/vue-treeselect'
  import {mapActions, mapGetters, mapState} from "vuex";

  export default {
    data() {
      return {
        currentID: null,
        showEditForm: false,
        showAddForm: false,
        editCurrentNote: false,

        newNotepad: {
          name: '',
          ancestry: null
        }
      }
    },

    methods: {
      ...mapActions([
        'fetchNotepad',
        'fetchNotepads',
        'fetchCurrentNotepad',
        'updateNotepadField',
        'createNotepad'
      ]),
      showAddNoteForm() {
        this.showAddForm = true;
        this.showEditForm = false;
      },
      showEditNoteForm() {
        this.showEditForm = true;
        this.showAddForm = false;
      },
      closeForm() {
        if(this.showAddForm && this.newNotepad.name.length > 0) {
          this.createNotepad(this.newNotepad);
        }
        this.showAddForm = false;
        this.showEditForm = false;
        setTimeout(() => { this.reloadTree() }, 400);
        setTimeout(() => { this.reloadTree() }, 600);
        setTimeout(() => { this.reloadTree() }, 800);
      },
      reloadTree() {
        this.$refs.ts0 && this.$refs.ts0.loadOptions(true);
        this.$refs.ts1 && this.$refs.ts1.loadOptions(true);
        this.$refs.ts2 && this.$refs.ts2.loadOptions(true);
      },
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

      // Mda, eto pizdec
      setTimeout(() => { this.reloadTree() }, 400);
      setTimeout(() => { this.reloadTree() }, 600);
      setTimeout(() => { this.reloadTree() }, 800);
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
  .toolbar__input {
    margin: 0 !important;
    margin-right: 0.4375em !important;
    padding-top: 6px !important;
    padding-bottom: 6px !important;
    max-width: 300px;
  }

  .vue-treeselect {
    display: inline-block;
    width: 400px;
    margin-right: 0.4375em;
  }

  .treeselect--fullwidth {
    width: 80%;
  }

  .vue-treeselect__control {
    z-index: 500;
  }

  .vue-treeselect__menu {
    z-index: 500;
  }
</style>
