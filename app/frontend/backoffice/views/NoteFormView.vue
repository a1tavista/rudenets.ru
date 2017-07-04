<script>
  import MarkdownEditor from '../components/editor/MarkdownEditor.vue';
  import InputTag from 'vue-input-tag';

  export default {
    data() {
      return {
        post: {
          id: null,
          title: '',
          text: '',
          tagList: []
        },
        savingInProgress: false
      };
    },
    methods: {
      saveChanges() {
        this.saveDebounced();
      },
      fetchNote() {
        const route = this.$store.state.route;
        this.axios.get(`/api/posts/${route.params.id}.json`)
          .then((response) => {
            this.post = Object.assign({}, this.post, response.data.post);
          });
      },
      saveDebounced: _.debounce(function() {
        this.savingInProgress = true;
        if(this.post.id === null) {
          this.axios.post('/api/posts.json', { post: this.post })
            .then((response) => {
              this.post.id = response.data.id;
              this.savingInProgress = false;
            });
        } else {
          this.axios.put(`/api/posts/${this.post.id}.json`, { post: this.post })
            .then((response) => {
              this.savingInProgress = false;
            });
        }
      }, 500),
      publishNote() {
        this.axios.put(`/api/posts/${this.post.id}/publish.json`)
          .then((response) => {
            this.savingInProgress = false;
          });
      }
    },
    mounted() {
      if(this.type === "new") return;
      this.fetchNote();
    },
    watch: {
      '$route' (to, from) {
        this.fetchNote();
      }
    },
    components: {MarkdownEditor, InputTag},
    props: ["type"]
  }
</script>

<template lang="pug">
  div
    input(type='text' v-model='post.title' placeholder='Название заметки')
    input-tag(:tags="post.tagList")
    markdown-editor.editor--large(placeholder='Полный текст заметки' v-model="post.text" @input='saveChanges')
      div(slot="status")
        a(href="#!" v-if="savingInProgress") Сохранение изменений...
        a(href="#!" v-else) Все изменения сохранены
      div(slot="actions")
        button(@click="publishNote")
          i.material-icons publish
</template>
