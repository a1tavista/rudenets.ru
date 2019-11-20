<template>
  <div>
    <div class="header view__header">
      <h3 class="header__title">{{ formTitle }}</h3>
      <div class="header__actions">
        <button
          v-if='!post.entry.published'
          @click='publishPost'
        >Опубликовать</button>
        <button
          v-if='post.entry.published'
          @click='unpublishPost'
        >Скрыть в черновики</button>
        <button
          v-if='!post.entry.published'
          @click='remove'
        >Удалить</button>
      </div>
    </div>
    <div class="view__content">
      <input
        type='text'
        :value='post.title'
        @input="update('title', $event.target.value)"
        placeholder='Название заметки'
      />
      <text-editor></text-editor>
      <markdown-editor
        class="editor--large"
        placeholder='Полный текст заметки'
        :value="post.text"
        @input="update('text', $event)"
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
  import {mapActions, mapGetters, mapState} from "vuex";
  import TextEditor from "../components/TextEditor";

  export default {
    methods: {
      ...mapActions([
        'newPost',
        'fetchPost',
        'updatePostField',
        'publishPost',
        'unpublishPost',
        'deletePost'
      ]),
      update(field, value) {
        this.updatePostField({ field, value });
      },
      remove() {
        this.$router.push('/');
        this.deletePost();
      }
    },

    computed: {
      ...mapGetters({
        post: 'getCurrentPost'
      }),
      currentID() {
        const id = this.$store.state.route.params.id;
        return id || null;
      },
      formTitle() {
        return this.post.id ? 'Редактирование заметки' : 'Новая заметка';
      },
      savingInProgress() {
        return this.$store.state.posts.isSaving;
      }
    },

    mounted() {
      if(this.currentID !== null)
        this.fetchPost({id: this.currentID});
      else
        this.newPost();
    },

    watch: {
      '$route'(to, from) {
        if(this.currentID !== null)
          this.fetchPost({id: this.currentID});
        else
          this.newPost();
      },
    },

    components: {TextEditor, MarkdownEditor},

    props: ["type"]
  }
</script>
