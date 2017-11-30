<template lang="pug">
  div
    h3(v-if='note.id') Редактирование заметки
    h3(v-else) Новая заметка

    input(
      type='text'
      :value='note.title'
      @input="update('title', $event.target.value)"
      placeholder='Название заметки'
    )

    input-tag(
      :tags="tagList" :on-change="updateTags"
    )

    markdown-editor.editor--large(
      placeholder='Полный текст заметки'
      :value="note.text"
      @input.native="update('text', $event.target.value)"
    )

      div(slot="status")
        a(href="#!" v-if="savingInProgress") Сохранение изменений...
        a(href="#!" v-else) Все изменения сохранены
      div(slot="actions")
        button(@click="publishNote")
          i.material-icons publish
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
      ...mapActions(['newNote', 'fetchNote', 'updateNoteField', 'publishNote']),
      updateTags(value) {
        this.update('tagList', value);
      },
      update(field, value) {
        this.updateNoteField({ field, value });
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
