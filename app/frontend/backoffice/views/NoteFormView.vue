<template lang="pug">
  .note-editing-form
    .note-editing-form__header
      h3.note-editing-form__header-title {{ formTitle }}
      .note-editing-form__header-actions
        button(
          v-if='!note.entry.published'
          @click='publishNote'
        ) Опубликовать
        button(
          v-if='note.entry.published'
          @click='unpublishNote'
        ) Скрыть в черновики
        // button(v-if='!note.entry.published') Переместить в конспекты
        button(
          v-if='!note.entry.published'
          @click='remove'
        ) Удалить


    input(
      type='text'
      :value='note.title'
      @input="update('title', $event.target.value)"
      placeholder='Название заметки'
    )

    textarea(
      :value='note.summary'
      @input="update('summary', $event.target.value)"
      placeholder='Краткое описание'
    )

    input-tag(
      :tags='tagList'
      :on-change='updateTags'
      placeholder='Метки'
    )

    markdown-editor.editor--large(
      placeholder='Полный текст заметки'
      :value="note.text"
      @input.native="update('text', $event.target.value)"
    )
      div(slot="status")
        a(href="#!" v-if="savingInProgress") Сохранение изменений...
        a(href="#!" v-else) Все изменения сохранены
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
        return this.$store.state.posts.currentNoteSaving;
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
