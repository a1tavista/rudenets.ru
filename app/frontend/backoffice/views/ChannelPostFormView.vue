<template>
  <div>
    <el-row>
      <el-page-header @back="$router.push({ path: '/channel' })" :content="formTitle" />
    </el-row>
    <el-row>
      <channel-post-form-view-content class="view__content" />
    </el-row>
  </div>
</template>

<script>
import ChannelPostFormViewContent from "./ChannelPostFormView/ChannelPostFormViewContent";
import {mapActions, mapGetters} from "vuex";


export default {
  components: { ChannelPostFormViewContent },
  data() {
    return {
      isInitialized: false,
    };
  },
  methods: {
    ...mapActions([
      'newChannelPost',
      'fetchChannelPost',
      'updateChannelPostField'
    ])
  },

  computed: {
    ...mapGetters({
      post: 'getCurrentChannelPost'
    }),
    currentID() {
      const id = this.$store.state.route.params.id;
      return id || null;
    },
    formTitle() {
      return this.post.id ? 'Просмотр поста' : 'Новый пост';
    },
  },

  mounted() {
    if(this.currentID !== null)
      this.fetchChannelPost({id: this.currentID});
    else
      this.newChannelPost();
  },

  watch: {
    '$route'(to, from) {
      if(this.currentID !== null)
        this.fetchChannelPost({id: this.currentID});
      else
        this.newChannelPost();
    },
  },

  props: ["type"]
}
</script>
