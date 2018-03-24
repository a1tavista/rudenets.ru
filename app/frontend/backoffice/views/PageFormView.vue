<template lang="pug">
  .note-editing-form
    .note-editing-form__header
      h3.note-editing-form__header-title Редактирование страницы

    input(
      type='text'
      :value='page.title'
      @input="update('title', $event.target.value)"
      placeholder='Название страницы'
    )

    markdown-editor.editor--large(
      placeholder='Полный текст заметки'
      :value="page.content"
      @input="update('content', $event)"
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
      return {};
    },

    methods: {
      ...mapActions([
        'fetchPage',
        'updatePageField'
      ]),
      update(field, value) {
        this.updatePageField({ field, value });
      }
    },

    computed: {
      ...mapGetters({
        page: 'getCurrentPage'
      }),
      currentID() {
        const id = this.$store.state.route.params.id;
        return id || null;
      },
      savingInProgress() {
        return this.$store.state.pages.isSaving;
      }
    },

    mounted() {
      if(this.currentID !== null)
        this.fetchPage({id: this.currentID});
    },

    watch: {
      '$route'(to, from) {
        if(this.currentID !== null) {
          this.fetchPage({id: this.currentID});
        }
      }
    },

    components: {MarkdownEditor, InputTag},

    props: ["type"]
  }
</script>
