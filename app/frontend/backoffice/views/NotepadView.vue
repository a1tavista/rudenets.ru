<template>
  <div class="note-editing-form">
    <div class="note-editing-form__wrapper">
      <markdown-editor
        class="editor--x-large editor--single"
        :value="notepad.text"
        @input="update('text', $event)"
        :is-preview-hidden="true"
      >
        <div slot="status">
          <a href="#!" v-if="savingInProgress">Сохранение изменений...</a>
          <a href="#!" v-else>Все изменения сохранены</a>
        </div>
        <template class="toolbar__spacer" slot="actions">
          <div class="toolbar__group" v-show='!showEditForm && !showAddForm && !showShareForm'>
            <div class="toolbar__group">
              <button @click="showAddNoteForm"><i class="material-icons">add</i></button>
              <button @click="showEditNoteForm"><i class="material-icons">edit</i></button>
              <button @click="getShareLink"><i class="material-icons">share</i></button>
            </div>
            <div class="toolbar__spacer" />
            <treeselect
              class="treeselect--fullwidth"
              :options='tree'
              :show-count="true"
              v-model='currentID'
              :multiple='false'
              :clearable='false'
              :auto-focus='true'
              ref="ts0"
            />
            <div class="toolbar__spacer" />
          </div>
          <div class="toolbar__group" v-show='showShareForm'>
            <input
              id="share"
              class="toolbar__input"
              :value="fullShareUrl"
              disabled="disabled"
            />
            <button @click="unshareNotepad"><i class="material-icons">delete</i></button>
            <button @click="closeForm"><i class="material-icons">done</i></button>
          </div>
          <div class="toolbar__group" v-show="showAddForm">
            <input class="toolbar__input" v-model="newNotepad.name" />
            <treeselect
              :options='tree'
              :show-count="true"
              v-model='newNotepad.ancestry'
              :multiple='false'
              ref="ts1"
            />
            <button @click="closeForm"><i class="material-icons">done</i></button>
          </div>
          <div class="toolbar__group" v-show='showEditForm'>
            <input class="toolbar__input" :value="notepad.name" @input="update('name', $event.target.value)" />
            <treeselect
              :options='tree'
              :show-count="true"
              :value='notepad.ancestry'
              @input="update('ancestry', $event)"
              :multiple='false'
              ref="ts2"
            />
            <button @click="closeForm"><i class="material-icons">done</i></button>
          </div>
        </template>
      </markdown-editor>
    </div>
  </div>
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
        showShareForm: false,
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
      getShareLink() {
        function dec2hex (dec) {
          return ('0' + dec.toString(16)).substr(-2)
        }

        function generateId (len) {
          let arr = new Uint8Array((len || 40) / 2);
          window.crypto.getRandomValues(arr);
          return Array.from(arr, dec2hex).join('');
        }
        this.showShareForm = true;

        if(this.notepad.shareUrl == null)
          this.update('shareUrl', generateId(40));
      },
      unshareNotepad() {
        this.update('shareUrl', null);
      },
      closeForm() {
        if(this.showAddForm && this.newNotepad.name.length > 0) {
          this.createNotepad(this.newNotepad);
        }
        this.showAddForm = false;
        this.showEditForm = false;
        this.showShareForm = false;
      },
      update(field, value) {
        if(this.notepad[field] === value) return;
        if(value === undefined) return;
        this.updateNotepadField({ field, value });
      }
    },

    computed: {
      ...mapGetters({
        notepad: 'getCurrentNotepad',
        notepads: 'getNotepads',
        tree: 'getNotepadsTree',
        timestamp: 'getNotepadsTimestamp'
      }),
      savingInProgress() {
        return this.$store.state.notepads.isSaving;
      },
      fullShareUrl() {
        return `https://rudenets.ru/n/${this.notepad.shareUrl}`;
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
