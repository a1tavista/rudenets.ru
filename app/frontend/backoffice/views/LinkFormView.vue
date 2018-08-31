<template>
  <div>
    <div class="view__header header">
      <h3 class="header__title">{{ formTitle }}</h3>
      <div class="header__actions">
        <button
          v-if='!link.entry.published'
          @click='publishLink'
        >Опубликовать</button>
        <button
          v-if='link.entry.published'
          @click='unpublishLink'
        >Скрыть в черновики</button>
        <button
          v-if='!link.entry.published'
          @click='remove'
        >Удалить</button>
      </div>
    </div>
    <div class="view__content">
      <img :src='link.src' />
      <input
        type='text'
        :value='link.title'
        @input="update('title', $event.target.value)"
        placeholder='Название страницы'
      />
      <textarea
        :value='link.description'
        @input="update('description', $event.target.value)"
        placeholder='Описание'
      />
      <textarea
        :value='link.summary'
        @input="update('summary', $event.target.value)"
        placeholder='Комментарий'
      />
      <div>
        <a href="#!" v-if="savingInProgress">Сохранение изменений...</a>
        <a href="#!" v-else>Все изменения сохранены</a>
      </div>
    </div>
  </div>
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
        'fetchLink',
        'updateLinkField',
        'publishLink',
        'unpublishLink',
        'deleteLink'
      ]),
      update(field, value) {
        this.updateLinkField({ field, value });
      },
      remove() {
        this.$router.push('/');
        this.deleteLink();
      }
    },

    computed: {
      ...mapGetters({
        link: 'getCurrentLink'
      }),
      currentID() {
        const id = this.$store.state.route.params.id;
        return id || null;
      },
      formTitle() {
        return 'Редактирование ссылки';
      },
      savingInProgress() {
        return this.$store.state.links.isSaving;
      }
    },

    mounted() {
      if(this.currentID !== null)
        this.fetchLink({id: this.currentID});
    },

    watch: {
      '$route'(to, from) {
        if(this.currentID !== null) {
          this.fetchLink({id: this.currentID});
        }
      }
    },

    components: {MarkdownEditor, InputTag},

    props: ["type"]
  }
</script>
