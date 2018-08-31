<template>
  <div>
    <div class="view__header header">
      <div class="header__select">
        <treeselect
          :options='tree'
          :show-count="true"
          v-model='currentID'
          :multiple='false'
          :clearable='false'
          :auto-focus='true'
          class='treeselect--fullwidth'
        />
      </div>
      <div class="header__actions">
        <button @click="showAddNoteForm"><i class="material-icons">add</i></button>
        <button @click="showEditNoteForm"><i class="material-icons">edit</i></button>
        <button @click="getShareLink"><i class="material-icons">share</i></button>
      </div>
    </div>

    <modal v-if="showAddForm" @close="closeForm">
      <h3 slot="header">Создание заметки</h3>
      <div slot="body">
        <input v-model="newNotepad.name" placeholder="Название заметки"/>
        <treeselect
          :options='tree'
          :show-count="true"
          v-model='newNotepad.ancestry'
          :multiple='false'
          class='treeselect--fullwidth'
        />
      </div>
      <div slot="footer">
        <button @click="closeForm">Сохранить</button>
      </div>
    </modal>
    <modal v-if="showEditForm" @close="closeForm">
      <h3 slot="header">Изменение заметки</h3>
      <div slot="body">
        <input :value="notepad.name" @input="update('name', $event.target.value)" />
        <treeselect
          :options='tree'
          :show-count="true"
          :value='notepad.ancestry'
          @input="update('ancestry', $event)"
          :multiple='false'
          class='treeselect--fullwidth'
        />
      </div>
      <div slot="footer">
        <button @click="closeForm">Сохранить</button>
      </div>
    </modal>
    <modal v-if="showShareForm" @close="closeForm">
      <h3 slot="header">Заметка опубликована!</h3>
      <div slot="body">
        <p style="margin-bottom: 8px;">Ссылка для доступа:</p>
        <pre>{{ fullShareUrl }}</pre>
      </div>
      <div slot="footer">
        <button @click="unshareNotepad">Распубликовать</button>
        <button @click="closeForm">Сохранить</button>
      </div>
    </modal>

    <div class='view__content view__content_paddingless'>
      <markdown-editor
        class="editor--sticky"
        :value="notepad.text"
        @input="update('text', $event)"
        :is-preview-hidden="true"
      >
        <div slot="status">
          <a href="#!" v-if="savingInProgress">Сохранение изменений...</a>
          <a href="#!" v-else>Все изменения сохранены</a>
        </div>
  </markdown-editor>
    </div>
  </div>
</template>

<script>
  import MarkdownEditor from '../components/editor/MarkdownEditor.vue';
  import Modal from '../components/Modal.vue';
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

    components: {MarkdownEditor, Treeselect, Modal}
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
    width: 100%;
  }

  .vue-treeselect__control {
    z-index: 500;
  }

  .vue-treeselect__menu {
    z-index: 500;
  }

  .vue-treeselect__input:focus {
    box-shadow: none;
  }
</style>
