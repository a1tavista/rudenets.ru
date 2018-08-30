<template>
  <div class="note-editing-form">
    <div class="note-editing-form__header">
      <h3 class="note-editing-form__header-title">{{ formTitle }}</h3>
      <div class="note-editing-form__header-actions">
        <button
          v-if='!note.entry.published'
          @click='publishNote'
        >Опубликовать</button>
        <button
          v-if='note.entry.published'
          @click='unpublishNote'
        >Скрыть в черновики</button>
        <button
          v-if='!note.entry.published'
          @click='remove'
        >Удалить</button>
      </div>
    </div>
    <input
      type='text'
      :value='note.title'
      @input="update('title', $event.target.value)"
      placeholder='Название заметки'
    />
    <textarea
      :value='note.summary'
      @input="update('summary', $event.target.value)"
      placeholder='Краткое описание'
    />
    <input-tag
      :tags='tagList'
      :on-change='updateTags'
      placeholder='Метки'
    />
    <markdown-editor
      placeholder='Полный текст заметки'
      :value="note.text"
      @input="update('text', $event)"
    >
      <div slot="status">
        <a href="#!" v-if="savingInProgress">Сохранение изменений...</a>
        <a href="#!" v-else>Все изменения сохранены</a>
      </div>
    </markdown-editor>
  </div>
</template>

<script>
  import notesService from '../services/notesService';
  import MarkdownEditor from '../components/editor/MarkdownEditor.vue';
  import InputTag from 'vue-input-tag';
  import {mapActions, mapGetters, mapState} from "vuex";

  export default {
    data() {
      return {
        tagList: []
      };
    },

    methods: {
      ...mapActions([
        'newNote',
        'fetchNote',
        'updateNoteField',
        'publishNote',
        'unpublishNote',
        'deleteNote'
      ]),
      updateTags(value) {
        this.update('tagList', value);
      },
      update(field, value) {
        this.updateNoteField({ field, value });
      },
      remove() {
        this.$router.push('/');
        this.deleteNote();
      }
    },

    computed: {
      ...mapGetters({
        note: 'getCurrentNote'
      }),
      currentID() {
        const id = this.$store.state.route.params.id;
        return id || null;
      },
      formTitle() {
        return this.note.id ? 'Редактирование заметки' : 'Новая заметка';
      },
      savingInProgress() {
        return this.$store.state.notes.isSaving;
      }
    },

    mounted() {
      if(this.currentID !== null)
        this.fetchNote({id: this.currentID});
      else
        this.newNote();
    },

    watch: {
      '$route'(to, from) {
        if(this.currentID !== null)
          this.fetchNote({id: this.currentID});
        else
          this.newNote();
      },
      'note.tagList'() {
        this.tagList = [...this.note.tagList];
      }
    },

    components: {MarkdownEditor, InputTag},

    props: ["type"]
  }
</script>
