<template>
  <div>
    <el-row>
      <el-page-header @back="$router.push({ path: '/page' })" :content="formTitle" />
    </el-row>
    <el-row>
      <page-form-view-content class="view__content" />
    </el-row>
  </div>
</template>

<script>
import PageFormViewContent from "./PageFormView/PageFormViewContent";
import {mapActions, mapGetters} from "vuex";


export default {
  components: { PageFormViewContent },
  data() {
    return {
      isInitialized: false,
    };
  },
  methods: {
    ...mapActions([
      'fetchPage',
      'updatePageField'
    ])
  },

  computed: {
    ...mapGetters({
      page: 'getCurrentPage'
    }),
    currentID() {
      const id = this.$store.state.route.params.id;
      return id || null;
    },
    formTitle() {
      return this.page.id ? 'Редактирование страницы' : 'Новый пост';
    },
  },

  mounted() {
    if(this.currentID !== null)
      this.fetchPage({id: this.currentID});
  },

  watch: {
    '$route'(to, from) {
      if(this.currentID !== null)
        this.fetchPage({id: this.currentID});
    },
  },

  props: ["type"]
}
</script>
