<template>
  <div>
    <el-card class='el-card_margin-bottom'>
      <el-row>
        <el-input
          type='text'
          :value='post.title'
          @input="update('title', $event)"
          placeholder='Название поста'
          class='el-input_xxl'
        />
      </el-row>
      <el-row>
        <el-input
          type="textarea"
          :value='post.abstract'
          @input="update('abstract', $event)"
          :autosize="{ minRows: 2, maxRows: 6 }"
          placeholder="Описание поста"
        />
      </el-row>
    </el-card>

    <el-card class='el-card_margin-bottom'>
      <post-cover-image v-if="imageCoverAction" :action="imageCoverAction" />
    </el-card>

    <el-card class='el-card_margin-bottom el-card_with-overflow'>
      <v-editor
        :value="post.contentBlocks"
        @input="update('contentBlocks', $event)"
      />
    </el-card>

    <el-card class='el-card_margin-bottom'>
      <el-row>
        <el-input
            type="textarea"
            :value='post.customCss'
            @input="update('customCss', $event)"
            :autosize="{ minRows: 2, maxRows: 6 }"
            placeholder="Стили CSS"
        />
      </el-row>
    </el-card>

    <el-card class='el-card_margin-bottom'>
      <post-settings />
    </el-card>
  </div>
</template>

<script>
import { mapActions, mapGetters, mapState } from "vuex";
import vue2Dropzone from 'vue2-dropzone';
import PostFormViewSettings from "./PostFormViewSettings";
import PostFormViewContentCoverImage from "./PostFormViewContentCoverImage";
import MarkdownBlockEditor from '../../components/MarkdownBlockEditor';

export default {
  methods: {
    ...mapActions([
      'updatePostField',
    ]),
    update(field, value) {
      this.updatePostField({ field, value });
    },
  },
  computed: {
    ...mapGetters({
      post: 'getCurrentPost'
    }),
    currentID() {
      const id = this.$store.state.route.params.id;
      return id || null;
    },
    imageCoverAction() {
      if(!this.currentID) {
        return false;
      }
      return `/api/posts/${this.currentID}/cover_image.json`;
    },
    savingInProgress() {
      return this.$store.state.posts.isSaving;
    }
  },
  components: {
    vueDropzone: vue2Dropzone,
    PostSettings: PostFormViewSettings,
    PostCoverImage: PostFormViewContentCoverImage,
    VEditor: MarkdownBlockEditor
  },
}
</script>
