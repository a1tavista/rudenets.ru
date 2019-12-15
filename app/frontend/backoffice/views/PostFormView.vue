<template>
  <div>
    <el-row>
      <el-page-header @back="$router.push({ path: '/posts' })" :content="formTitle" />
    </el-row>
    <el-row>
      <post-form-view-content class="view__content" />
    </el-row>
    <div>
      <button v-if='!post.entry.published' @click='remove'>Удалить</button>
    </div>
  </div>
</template>

<script>
import PostFormViewContent from "./PostFormView/PostFormViewContent";
import {mapActions, mapGetters, mapState} from "vuex";


export default {
  components: { PostFormViewContent },
  data() {
    return {
      isInitialized: false,
    };
  },
  methods: {
    ...mapActions([
      'newPost',
      'fetchPost',
      'updatePostField',
      'deletePost'
    ]),
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
      return this.post.id ? 'Редактирование поста' : 'Новый пост';
    },
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

  props: ["type"]
}
</script>
