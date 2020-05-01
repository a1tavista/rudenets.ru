<template>
  <div>
    <el-card class='el-card_margin-bottom'>
      <el-row>
        <el-input
            type='text'
            :value='page.title'
            @input="update('title', $event)"
            placeholder='Название страницы'
            class='el-input_xxl'
        />
      </el-row>
    </el-card>

    <el-card class='el-card_margin-bottom'>
      <el-row>
        <el-input
            type="textarea"
            :value='page.customCss'
            @input="update('customCss', $event)"
            :autosize="{ minRows: 2, maxRows: 6 }"
            placeholder="Стили CSS"
        />
      </el-row>
    </el-card>

    <el-card class='el-card_margin-bottom el-card_with-overflow'>
      <v-editor :value="page.contentBlocks" @input="update('contentBlocks', $event)"/>
    </el-card>
  </div>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
import MarkdownBlockEditor from '../../components/MarkdownBlockEditor';

export default {
  methods: {
    ...mapActions([
      'updatePageField',
    ]),
    update(field, value) {
      this.updatePageField({ field, value });
    },
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
  components: {
    VEditor: MarkdownBlockEditor
  },
}
</script>
