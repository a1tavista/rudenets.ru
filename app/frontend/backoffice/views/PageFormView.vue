<template>
  <div>
    <div class="header view__header">
      <h3 class="header__title">Редактирование страницы</h3>
    </div>
    <div class="view__content">
      <input
        type='text'
        :value='page.title'
        @input="update('title', $event.target.value)"
        placeholder='Название страницы'
      />
      <markdown-editor
        class="editor--large"
        placeholder='Полный текст заметки'
        :value="page.content"
        @input="update('content', $event)"
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
  import {mapActions, mapGetters} from "vuex";

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
    props: ["type"]
  }
</script>
