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
            :disabled="!!post.publishedAtLocalized"
        />
      </el-row>
    </el-card>

    <el-card class='el-card_margin-bottom el-card_with-overflow' v-if="!post.publishedAtLocalized">
      <v-editor
          :value="post.contentBlocks"
          :lock-type="true"
          @input="update('contentBlocks', $event)"
      />
    </el-card>

    <el-card class='el-card_margin-bottom'>
      <post-settings v-if="!post.publishedAtLocalized" />
      <div v-else>Опубликовано {{ post.publishedAtLocalized }}</div>
    </el-card>
  </div>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
import PostFormViewSettings from "./ChannelPostFormViewSettings";
import MarkdownBlockEditor from '../../components/MarkdownBlockEditor';

export default {
  methods: {
    ...mapActions([
      'updateChannelPostField',
    ]),
    update(field, value) {
      this.updateChannelPostField({ field, value });
    },
  },
  computed: {
    ...mapGetters({
      post: 'getCurrentChannelPost'
    }),
    currentID() {
      const id = this.$store.state.route.params.id;
      return id || null;
    },
    savingInProgress() {
      return this.$store.state.channelPosts.isSaving;
    }
  },
  components: {
    PostSettings: PostFormViewSettings,
    VEditor: MarkdownBlockEditor
  },
}
</script>
